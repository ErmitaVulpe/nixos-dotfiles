use amane::{
    Align, Audio, Battery, Button, Color, Full, Justify, Layer, LayerWindow, Monitor, Parent,
    Rectangle, Row, Service, Text, Vertical, Widget, Workspaces, Zone, children,
};

use crate::{clock, theme::BASE16};

pub const BAR_HEIGHT: f32 = 30.;

pub fn bar(monitor: &Monitor) -> LayerWindow {
    let workspaces = Workspaces::read();
    let mut buttons: Vec<Box<dyn Widget>> = Vec::with_capacity(9);
    for workspace in workspaces.list() {
        if workspace.output() != Some(monitor.name.as_str()) {
            continue;
        }

        buttons.push(Box::new({
            let fill = if workspace.focused() {
                BASE16[3]
            } else if workspace.urgent() {
                BASE16[9]
            } else {
                BASE16[1]
            };

            let id = workspace.id();

            Rectangle::new()
                .width(BAR_HEIGHT)
                .height(Parent)
                .fill(fill)
                .on_click(move |_| Workspaces::focus(id))
                .child(Text::new(workspace.index().to_string()).color(Color::WHITE))
        }));
    }

    let clock = clock::Clock::read();
    let battery = Battery::read();

    LayerWindow::new()
        .width(Full)
        .height(BAR_HEIGHT)
        .anchor_vertical(Vertical::Top)
        .layer(Layer::Top)
        .space(Zone::Reserve)
        .child(
            Row::new(children!(
                section(Row::new(buttons), Align::Start),
                section(text("Hewwo haiii :3"), Align::Center),
                section(
                    Row::new(children!(
                        volume_widget(),
                        text(format!("bat:{}%", battery.percent())),
                        text(&clock.time)
                    ))
                    .align(Align::Center)
                    .gap(12.),
                    Align::End
                )
            ))
            .justify(Justify::Center)
            .align(Align::Center),
        )
}

fn section(content: impl Widget + 'static, align: impl Into<Align>) -> Rectangle {
    Rectangle::new()
        .width(Parent)
        .height(Parent)
        .fill(BASE16[0])
        .align_child(align, Align::Center)
        .child(content)
}

/// Creates a default Text for a bar
fn text(content: impl Into<String>) -> Text {
    Text::new(content).color(BASE16[5].into())
}

fn volume_widget() -> Rectangle {
    let audio = Audio::read();

    Rectangle::new()
        .width(75.)
        .height(Parent)
        .align_child(Align::End, Align::Center)
        .on_click(|b| {
            if matches!(b, Button::Left) {
                Audio::toggle_mute();
            }
        })
        .child(text(if audio.muted() {
            "vol:mut".to_string()
        } else {
            format!("vol:{}%", audio.volume())
        }))
}

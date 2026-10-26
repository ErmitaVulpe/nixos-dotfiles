use amane::{
    App, Color, Column, Full, Horizontal, Layer, LayerWindow, Margin, Monitor, Parent, Rectangle,
    Text, Vertical, Zone, children,
};

fn main() {
    App::new()
        .window(bar)
        .window_per_monitor(activate_linux)
        .run();
}

fn activate_linux(monitor: &Monitor) -> LayerWindow {
    let rem = monitor.width.min(monitor.height) as f32;
    let margin = (rem * 0.066) as i32;

    LayerWindow::new()
        .width(monitor.width as f32 * 0.125)
        .height(monitor.height as f32 * 0.04)
        .anchor_vertical(Vertical::Bottom)
        .anchor_horizontal(Horizontal::Right)
        .margin(Margin {
            top: 0,
            right: margin,
            bottom: margin,
            left: 0,
        })
        .click_through()
        .child(Column::new(children![
            Text::new("Activate Linux")
                .size(rem * 0.0175)
                .color(Color::rgba(250, 250, 250, 100)),
            Text::new("Go to Settings to activate Linux")
                .size(rem * 0.0125)
                .color(Color::rgba(250, 250, 250, 100)),
        ]))
}

fn bar() -> LayerWindow {
    LayerWindow::new()
        .width(Full)
        .height(30.0)
        .anchor_vertical(Vertical::Top)
        .layer(Layer::Top)
        .space(Zone::Reserve)
        .child(
            Rectangle::new()
                .width(Parent)
                .height(Parent)
                .fill(Color::BLUE)
                .child(Text::new("hello world").size(20.0).color(Color::WHITE)),
        )
}

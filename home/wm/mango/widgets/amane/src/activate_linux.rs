use amane::{Color, Column, Horizontal, LayerWindow, Margin, Monitor, Text, Vertical, children};

pub fn activate_linux(monitor: &Monitor) -> LayerWindow {
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

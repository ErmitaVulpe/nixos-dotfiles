use amane::{Image, Layer, LayerWindow, Monitor, Rectangle, Size::Parent, WindowSize, Zone};

use crate::{bar::BAR_HEIGHT, theme::WALLPAPER_PATH};

pub fn wallpaper(monitor: &Monitor) -> LayerWindow {
    LayerWindow::new()
        .width(WindowSize::Full)
        .height(WindowSize::Fixed(monitor.height as f32 - BAR_HEIGHT))
        .anchor_vertical(amane::Vertical::Bottom)
        .layer(Layer::Background)
        .space(Zone::Ignore)
        .namespace("wallpaper")
        .click_through()
        .child(
            Rectangle::new()
                .width(Parent)
                .height(Parent)
                .fill(Image::cover(WALLPAPER_PATH)),
        )
}

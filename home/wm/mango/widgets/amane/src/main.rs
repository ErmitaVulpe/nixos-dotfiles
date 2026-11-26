mod activate_linux;
mod bar;
mod clock;
mod theme;
mod wallpaper;

fn main() {
    amane::App::new()
        .window_per_monitor(activate_linux::activate_linux)
        .window_per_monitor(bar::bar)
        .window_per_monitor(wallpaper::wallpaper)
        .run();
}

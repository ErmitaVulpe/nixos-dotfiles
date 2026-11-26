use std::time::Duration;

const DATE_CMD: &str = "date \"+%a %d/%m/%Y %H:%M:%S\"";

pub struct Clock {
    pub time: String,
}

impl amane::Service for Clock {
    fn new() -> Self {
        Self {
            time: amane::output(DATE_CMD),
        }
    }

    fn interval() -> Duration {
        Duration::from_secs(1)
    }

    fn update(&mut self) -> bool {
        self.time = amane::output(DATE_CMD);
        true
    }
}

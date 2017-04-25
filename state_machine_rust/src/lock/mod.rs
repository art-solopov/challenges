use std::default::Default;
use std::fmt;

enum State {
    Locked,
    Unlocked,
}

pub struct Lock {
    state: State,
    key: String
}

impl Default for Lock {
    fn default() -> Lock {
        Lock { state: State::Unlocked, key: String::from("") }
    }
}

impl fmt::Display for Lock {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "<Lock {} [{}]>", self._state_str(), self.key)
    }
}

impl Lock {
    pub fn turn<K: Into<String>>(&mut self, key: K) {
        let key_str = key.into();
        match self.state {
            State::Locked =>
                if self.key == key_str {
                    self.state = State::Unlocked;
                } else {
                    println!("Wrong key {}", key_str);
                },
            State::Unlocked => {
                self.key = key_str.clone();
                self.state = State::Locked;
            }
        }
    }

    fn _state_str(&self) -> String {
        match self.state {
            State::Locked => String::from("locked"),
            State::Unlocked => String::from("unlocked")
        }
    }
}

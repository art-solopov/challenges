trait Good {
    fn name(&self) -> String;
    fn manufacturer(&self) -> String;
}

trait Drink : Good {
    fn flavor(&self) -> String;
}

trait Snack : Good {
    fn snack_type(&self) -> String;
}

struct Chocolate {
    _name: String,
    _manufacturer: String
}

impl Good for Chocolate {
    fn name(&self) -> String {
        return format!("{} {}", self._manufacturer, self._name);
    }
    fn manufacturer(&self) -> String {
        return format!("{}", self._manufacturer);
    }
}

impl Snack for Chocolate {
    fn snack_type(&self) -> String {
        return String::from("Chocolate");
    }
}

impl Good for Chips {
    fn
}

fn main() {
    let lindt = Chocolate {
        _name: String::from("Milk"),
        _manufacturer: String::from("Lindt")
    };

    println!("{}: {}", lindt.snack_type(), lindt.name());
}

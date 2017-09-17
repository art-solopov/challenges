trait Good {
    fn name(&self) -> String;
    fn manufacturer(&self) -> String;
}

trait Drink : Good {
    fn flavour(&self) -> String;
}

trait Snack : Good {
    fn snack_type(&self) -> String;
}

/* Chocolate */

struct Chocolate {
    name: String,
    manufacturer: String
}

impl Good for Chocolate {
    fn name(&self) -> String {
        return format!("{} {}", self.manufacturer, self.name);
    }
    fn manufacturer(&self) -> String {
        return format!("{}", self.manufacturer);
    }
}

impl Snack for Chocolate {
    fn snack_type(&self) -> String {
        return String::from("Chocolate");
    }
}

/* Crisps */

struct Crisps {
    manufacturer: String,
    flavour: String
}

impl Good for Crisps {
    fn name(&self) -> String {
        return format!("{} — {} flavour", self.manufacturer, self.flavour);
    }
    fn manufacturer(&self) -> String {
        return format!("{}", self.manufacturer);
    }
}

impl Snack for Crisps {
    fn snack_type(&self) -> String {
        return String::from("Crisps");
    }
}

/* Coke */

struct Coke {
    manufacturer: String,
    name: String
}

impl Good for Coke {
    fn name(&self) -> String {
        return format!("{}", self.name);
    }
    fn manufacturer(&self) -> String {
        return format!("{}", self.manufacturer);
    }
}

impl Drink for Coke {
    fn flavour(&self) -> String { return String::from("Coke") } 
}

/* Main */

fn main() {
    let lindt = Chocolate {
        name: String::from("Milk"),
        manufacturer: String::from("Lindt")
    };
    let lays_salt = Crisps {
        manufacturer: String::from("Lays"),
        flavour: String::from("Salt")
    };

    println!("{}: {}", lindt.snack_type(), lindt.name());
    println!("{}", lays_salt.name());
}

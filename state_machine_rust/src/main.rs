use std::default::Default;

extern crate time;

mod lock;

fn main() {
    println!("{}", time::now().ctime());
    
    let mut lock: lock::Lock = Default::default();
    println!("{}", lock);
    lock.turn("12345");
    println!("{}", lock);
    lock.turn("56A");
    lock.turn("12345");
    println!("{}", lock);
}

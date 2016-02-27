use std::io;
use std::str::FromStr;

fn min_pair(a: & Option<(f32, f32)>, b: & Option<(f32, f32)>) -> Option<(f32, f32)> {
    return match (*a, *b) {
        (None, None) => None,
        (_, None) => *a,
        (None, _) => *b,
        (Some(at), Some(bt)) =>
            if (at.1 - at.0) >= (bt.1 - bt.0) { *a } else { *b }
    }
}

fn minmax(seq: & Vec<f32>, adj: bool) -> Option<(f32, f32)> {
    let mut min: (usize, &f32) = (0, &seq[0]);
    let mut max: (usize, &f32) = (0, &seq[0]);

    for (i, e) in seq.iter().enumerate() {
        if e < min.1 {
            min = (i, e);
        }
        if e > max.1 {
            max = (i, e);
        }
    }

    if min.1 == max.1 {
        return None;
    }
    if min.0 > max.0 {
        let spl;
        let s1: Vec<f32>;
        let s2: Vec<f32>;
        let mm1: Option<(f32, f32)>;
        let mm2: Option<(f32, f32)>;

        spl = seq.split_at(max.0 + 1);
        s1 = spl.0.to_vec();
        s2 = spl.1.to_vec();
        if s1.len() == 0 || s2.len() == 0 {
            return None;
        }
        mm1 = minmax(& s1, true);
        mm2 = minmax(& s2, true);
        return min_pair(&mm1, &mm2);
    }
    if adj && min.0 + 1 == max.0 {
        let mut s1: Vec<f32> = seq.clone();
        let mut s2: Vec<f32> = seq.clone();

        let mm1: Option<(f32, f32)>;
        let mm2: Option<(f32, f32)>;

        s1.remove(min.0);
        s2.remove(max.0);

        mm1 = minmax(& s1, false);
        mm2 = minmax(& s2, false);
        return min_pair(&mm1, &mm2);
    }

    return Some((*min.1, *max.1));
}

fn main() {
    let mut input = String::new();
    let market: Vec<f32>;
    let mm: Option<(f32, f32)>;

    io::stdin().read_line(&mut input);
    market = input.split_whitespace()
        .map(|e| f32::from_str(e).unwrap())
        .collect();

    mm = minmax(&market, true);
    match mm {
        None => println!("No result"),
        Some(v) => println!("{} {}", v.0, v.1),
    }
}

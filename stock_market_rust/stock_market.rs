fn cmp_key(tup: &(usize, &f32)) -> i64 {
    return (tup.1 * 1000.0) as i64;
}

fn minmax(seq: & Vec<f32>, adj: bool) -> (f32, f32) {
    let min: (usize, &f32);
    let max: (usize, &f32);

    let en = seq.iter().enumerate();

    min = en.clone().min_by_key(cmp_key).unwrap();
    max = en.clone().max_by_key(cmp_key).unwrap();

    if min.1 == max.1 {
        return (seq[0], seq[0]);
    }
    if min.0 > max.0 {
        let spl;
        let mut s1: Vec<f32> = vec! [];
        let mut s2: Vec<f32> = vec! [];
        let mm1: (f32, f32);
        let mm2: (f32, f32);

        spl = seq.split_at(max.0 + 1);
        s1.extend_from_slice(spl.0);
        s2.extend_from_slice(spl.1);
        mm1 = minmax(& s1, true);
        mm2 = minmax(& s2, true);
        if (mm1.1 - mm1.0) >= (mm2.1 - mm2.0) {
            return mm1;
        }
        return mm2;
    }
    if adj && min.0 + 1 == max.0 {
        let mut s1: Vec<f32> = seq.clone();
        let mut s2: Vec<f32> = seq.clone();

        let mm1: (f32, f32);
        let mm2: (f32, f32);

        s1.remove(min.0);
        s2.remove(max.0);

        mm1 = minmax(& s1, false);
        mm2 = minmax(& s2, false);

        if (mm1.1 - mm1.0) >= (mm2.1 - mm2.0) {
            return mm1;
        }
        return mm2;
    }

    return (*min.1, *max.1);
}

fn main() {
    let market: Vec<f32> = vec![4.0, 1.0, 7.0, 4.0, 5.0];
    println!("{:?}", minmax(&market, true));
}

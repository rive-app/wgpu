const LIMIT: u32 = 6u;
const MOST: u32 = 4294967295u;

@group(0) @binding(0) 
var image: texture_2d<f32>;
@group(0) @binding(1) 
var<storage, read_write> tally: atomic<i32>;

fn f(x: i32) -> i32 {
    return (x * 2i);
}

fn counted() -> i32 {
    var sum: i32 = 0i;

    for (var i: i32 = 0i; (i < 4i); i = (i + 1i)) {
        {
            let _e7 = sum;
            let _e8 = i;
            sum = (_e7 + _e8);
        }
    }
    let _e13 = sum;
    return _e13;
}

fn constant_bound() -> u32 {
    var sum_1: u32 = 0u;

    for (var i_1: u32 = 0u; (i_1 != LIMIT); i_1 = (i_1 + 1u)) {
        {
            let _e7 = sum_1;
            let _e8 = i_1;
            sum_1 = (_e7 + _e8);
        }
    }
    let _e13 = sum_1;
    return _e13;
}

fn skips() -> i32 {
    var sum_2: i32 = 0i;

    for (var i_2: i32 = 8i; (i_2 > 0i); i_2 = (i_2 - 2i)) {
        {
            let _e7 = i_2;
            if (_e7 == 4i) {
                continue;
            }
            let _e10 = sum_2;
            let _e11 = i_2;
            sum_2 = (_e10 + _e11);
        }
    }
    let _e16 = sum_2;
    return _e16;
}

fn doubling() -> f32 {
    var sum_3: f32 = 0f;

    for (var x_1: f32 = 1f; (x_1 < 64f); x_1 = (x_1 * 2f)) {
        {
            let _e7 = sum_3;
            let _e8 = x_1;
            sum_3 = (_e7 + _e8);
        }
    }
    let _e13 = sum_3;
    return _e13;
}

fn steps_by_a_call() -> i32 {
    var i_3: i32 = 0i;

    loop {
        let _e2 = i_3;
        if (_e2 < 64i) {
        } else {
            break;
        }
        {
        }
        continuing {
            let _e5 = i_3;
            i_3 = max((_e5 * 2i), 1i);
        }
    }
    let _e10 = i_3;
    return _e10;
}

fn counts_a_flag() -> i32 {
    var n: i32 = 0i;

    for (var go: bool = true; (go != false); go = (n < 3i)) {
        {
            let _e8 = n;
            n = (_e8 + 1i);
        }
    }
    let _e13 = n;
    return _e13;
}

fn skips_through_switch() -> i32 {
    var sum_4: i32 = 0i;

    for (var i_4: i32 = 0i; (i_4 < 4i); i_4 = (i_4 + 1i)) {
        {
            let _e7 = i_4;
            switch _e7 {
                default: {
                    let _e8 = i_4;
                    if (_e8 == 2i) {
                        continue;
                    }
                }
            }
            let _e11 = sum_4;
            let _e12 = i_4;
            sum_4 = (_e11 + _e12);
        }
    }
    let _e17 = sum_4;
    return _e17;
}

fn nested(n_1: i32) -> i32 {
    var total: i32 = 0i;

    for (var z: i32 = -1i; (z <= 1i); z = (z + 1i)) {
        {
            for (var y: i32 = n_1; (y <= 1i); y = (y + 1i)) {
                {
                    let _e12 = total;
                    let _e13 = z;
                    let _e14 = y;
                    total = (_e12 + (_e13 * _e14));
                }
            }
        }
    }
    let _e23 = total;
    return _e23;
}

fn stores_another_ahead() -> i32 {
    var total_1: i32 = 0i;
    var bias: i32 = 0i;

    bias = 7i;
    for (var i_5: i32 = 0i; (i_5 < 4i); i_5 = (i_5 + 1i)) {
        {
            let _e10 = total_1;
            let _e11 = bias;
            total_1 = (_e10 + _e11);
        }
    }
    let _e16 = total_1;
    return _e16;
}

fn steps_by_a_body_value() -> i32 {
    var n_2: i32 = 0i;
    var i_6: i32 = 0i;

    loop {
        let _e4 = i_6;
        if (_e4 < 64i) {
        } else {
            break;
        }
        let _e7 = i_6;
        let _e8 = f(_e7);
        let stride = (_e8 + 1i);
        let _e12 = n_2;
        n_2 = (_e12 + 1i);
        continuing {
            let _e14 = i_6;
            i_6 = (_e14 + stride);
        }
    }
    let _e16 = n_2;
    return _e16;
}

fn steps_by_a_body_load() -> i32 {
    var acc: i32 = 1i;
    var i_7: i32 = 0i;

    loop {
        let _e4 = i_7;
        if (_e4 < 16i) {
        } else {
            break;
        }
        let x_2 = acc;
        let _e8 = acc;
        acc = (_e8 + 1i);
        continuing {
            let _e11 = i_7;
            i_7 = (_e11 + x_2);
        }
    }
    let _e13 = acc;
    return _e13;
}

fn carries_on() -> i32 {
    var total_2: i32 = 0i;
    var i_8: i32 = 0i;

    for (var round_: i32 = 0i; (round_ < 2i); round_ = (round_ + 1i)) {
        {
            loop {
                let _e9 = i_8;
                if (_e9 < 4i) {
                } else {
                    break;
                }
                {
                    let _e12 = total_2;
                    let _e13 = i_8;
                    total_2 = (_e12 + _e13);
                }
                continuing {
                    let _e16 = i_8;
                    i_8 = (_e16 + 1i);
                }
            }
        }
    }
    let _e21 = total_2;
    return _e21;
}

fn tests_a_named_load() -> i32 {
    var i_9: i32 = 0i;

    loop {
        let x_3 = i_9;
        if (x_3 < 4i) {
        } else {
            break;
        }
        continuing {
            let _e6 = i_9;
            i_9 = (_e6 + 1i);
        }
    }
    let _e8 = i_9;
    return _e8;
}

fn inside_continuing() -> i32 {
    var n_3: i32 = 0i;
    var i_10: i32 = 0i;

    loop {
        let _e4 = i_10;
        if (_e4 >= 2i) {
            break;
        }
        continuing {
            let _e8 = i_10;
            i_10 = (_e8 + 1i);
            for (var j: i32 = 0i; (j < 3i); j = (j + 1i)) {
                {
                    let _e16 = n_3;
                    n_3 = (_e16 + 1i);
                }
            }
        }
    }
    let _e21 = n_3;
    return _e21;
}

fn strides() -> i32 {
    var i_11: i32 = 0i;

    loop {
        let _e2 = i_11;
        if (_e2 < 64i) {
        } else {
            break;
        }
        let _e5 = i_11;
        let _e6 = f(_e5);
        let stride_1 = (_e6 + 1i);
        continuing {
            let _e9 = i_11;
            i_11 = (_e9 + stride_1);
        }
    }
    let _e11 = i_11;
    return _e11;
}

fn steps_from_earlier_read() -> i32 {
    var i_12: i32 = 0i;
    var n_4: i32 = 0i;

    let start = i_12;
    loop {
        let _e5 = i_12;
        if (_e5 < 4i) {
        } else {
            break;
        }
        {
            let _e9 = n_4;
            n_4 = (_e9 + 1i);
        }
        continuing {
            let _e11 = n_4;
            i_12 = (start + _e11);
        }
    }
    let _e13 = n_4;
    return _e13;
}

fn steps_to_earlier_sum() -> i32 {
    var i_13: i32 = 0i;
    var n_5: i32 = 0i;

    loop {
        let _e4 = i_13;
        if (_e4 < 4i) {
        } else {
            break;
        }
        let _e7 = i_13;
        let next = (_e7 + 1i);
        i_13 = 10i;
        let _e12 = n_5;
        n_5 = (_e12 + 1i);
        continuing {
            i_13 = next;
        }
    }
    let _e14 = n_5;
    return _e14;
}

fn never_ends() -> i32 {
    var n_6: i32 = 0i;
    var i_14: i32 = 0i;
    var j_1: i32 = 0i;
    var k: u32 = 0u;
    var l: u32 = 0u;

    loop {
        let _e4 = i_14;
        if (_e4 <= 2147483647i) {
        } else {
            break;
        }
        {
            let _e8 = n_6;
            n_6 = (_e8 + 1i);
        }
        continuing {
            let _e11 = i_14;
            i_14 = (_e11 + 1i);
        }
    }
    loop {
        let _e15 = j_1;
        if (_e15 >= i32(-2147483648)) {
        } else {
            break;
        }
        {
            let _e19 = n_6;
            n_6 = (_e19 + 1i);
        }
        continuing {
            let _e22 = j_1;
            j_1 = (_e22 - 1i);
        }
    }
    loop {
        let _e26 = k;
        if (_e26 <= MOST) {
        } else {
            break;
        }
        {
            let _e30 = n_6;
            n_6 = (_e30 + 1i);
        }
        continuing {
            let _e33 = k;
            k = (_e33 + 1u);
        }
    }
    loop {
        let _e37 = l;
        if (_e37 >= 0u) {
        } else {
            break;
        }
        {
            let _e41 = n_6;
            n_6 = (_e41 + 1i);
        }
        continuing {
            let _e44 = l;
            l = (_e44 - 1u);
        }
    }
    let _e46 = n_6;
    return _e46;
}

fn names_its_step() -> i32 {
    var i_15: i32 = 0i;

    loop {
        let _e2 = i_15;
        if (_e2 < 4i) {
        } else {
            break;
        }
        continuing {
            let _e5 = i_15;
            let next_1 = (_e5 + 1i);
            i_15 = next_1;
        }
    }
    let _e8 = i_15;
    return _e8;
}

fn argument_bound(n_7: i32) -> i32 {
    var sum_5: i32 = 0i;
    var i_16: i32 = 0i;

    loop {
        let _e5 = i_16;
        if (_e5 < n_7) {
        } else {
            break;
        }
        {
            let _e7 = sum_5;
            let _e8 = i_16;
            sum_5 = (_e7 + _e8);
        }
        continuing {
            let _e11 = i_16;
            i_16 = (_e11 + 1i);
        }
    }
    let _e13 = sum_5;
    return _e13;
}

fn variable_bound() -> i32 {
    var n_8: i32 = 4i;
    var sum_6: i32 = 0i;
    var i_17: i32 = 0i;

    loop {
        let _e6 = i_17;
        let _e7 = n_8;
        if (_e6 < _e7) {
        } else {
            break;
        }
        {
            let _e9 = n_8;
            n_8 = (_e9 - 1i);
            let _e12 = sum_6;
            let _e13 = i_17;
            sum_6 = (_e12 + _e13);
        }
        continuing {
            let _e16 = i_17;
            i_17 = (_e16 + 1i);
        }
    }
    let _e18 = sum_6;
    return _e18;
}

fn no_step() -> u32 {
    var n_9: u32 = 40u;
    var steps: u32 = 0u;

    loop {
        let _e4 = n_9;
        if (_e4 > 1u) {
        } else {
            break;
        }
        {
            let _e7 = n_9;
            n_9 = (_e7 / 2u);
            let _e10 = steps;
            steps = (_e10 + 1u);
        }
    }
    let _e13 = steps;
    return _e13;
}

fn steps_another() -> i32 {
    var i_18: i32 = 0i;
    var j_2: i32 = 0i;

    loop {
        let _e4 = i_18;
        if (_e4 < 4i) {
        } else {
            break;
        }
        {
            let _e7 = i_18;
            let _e8 = j_2;
            i_18 = (_e7 + _e8);
        }
        continuing {
            let _e11 = j_2;
            j_2 = (_e11 + 1i);
        }
    }
    let _e13 = j_2;
    return _e13;
}

fn steps_twice() -> i32 {
    var i_19: i32 = 0i;
    var j_3: i32 = 8i;

    loop {
        let _e4 = i_19;
        if (_e4 < 8i) {
        } else {
            break;
        }
        continuing {
            let _e8 = i_19;
            i_19 = (_e8 + 1i);
            let _e11 = j_3;
            j_3 = (_e11 - 1i);
        }
    }
    let _e13 = j_3;
    return _e13;
}

fn steps_a_member() -> i32 {
    var v: vec2<i32> = vec2<i32>(0i, 0i);

    loop {
        let _e5 = v.x;
        if (_e5 < 4i) {
        } else {
            break;
        }
        {
        }
        continuing {
            let _e10 = v.x;
            v.x = (_e10 + 1i);
        }
    }
    let _e13 = v.x;
    return _e13;
}

fn until() -> i32 {
    var i_20: i32 = 0i;

    loop {
        let _e2 = i_20;
        if (_e2 >= 4i) {
            break;
        }
        continuing {
            let _e6 = i_20;
            i_20 = (_e6 + 1i);
        }
    }
    let _e8 = i_20;
    return _e8;
}

fn test_read_later() -> i32 {
    var hits: i32 = 0i;
    var i_21: i32 = 0i;

    loop {
        let _e4 = i_21;
        let inside = (_e4 < 4i);
        if inside {
        } else {
            break;
        }
        let _e7 = hits;
        hits = (_e7 + i32(inside));
        continuing {
            let _e11 = i_21;
            i_21 = (_e11 + 1i);
        }
    }
    let _e13 = hits;
    return _e13;
}

fn load_read_later() -> i32 {
    var i_22: i32 = 0i;
    var n_10: i32 = 0i;

    loop {
        let x_4 = i_22;
        if (x_4 < 4i) {
        } else {
            break;
        }
        i_22 = 10i;
        let _e8 = n_10;
        n_10 = (_e8 + x_4);
        continuing {
            i_22 = (x_4 + 1i);
        }
    }
    let _e12 = n_10;
    return _e12;
}

fn other_load_ahead_of_test(a: i32) -> i32 {
    var i_23: i32 = 0i;
    var j_4: i32;
    var n_11: i32 = 0i;

    j_4 = a;
    loop {
        let y_1 = j_4;
        let _e7 = i_23;
        if (_e7 < 4i) {
        } else {
            break;
        }
        j_4 = 100i;
        let _e11 = n_11;
        n_11 = (_e11 + y_1);
        continuing {
            let _e14 = i_23;
            i_23 = (_e14 + 1i);
        }
    }
    let _e16 = n_11;
    return _e16;
}

fn steps_by_an_atomic() -> i32 {
    var n_12: i32 = 0i;
    var i_24: i32 = 0i;

    loop {
        let _e4 = i_24;
        if (_e4 < 16i) {
        } else {
            break;
        }
        let _e8 = n_12;
        n_12 = (_e8 + 1i);
        continuing {
            let x_5 = atomicLoad((&tally));
            i_24 = (x_5 + x_5);
        }
    }
    let _e13 = n_12;
    return _e13;
}

fn test_calls() -> i32 {
    var i_25: i32 = 0i;

    loop {
        let _e2 = i_25;
        let _e3 = f(_e2);
        if (_e3 < 8i) {
        } else {
            break;
        }
        {
        }
        continuing {
            let _e7 = i_25;
            i_25 = (_e7 + 1i);
        }
    }
    let _e9 = i_25;
    return _e9;
}

fn image_test() -> i32 {
    var i_26: i32 = 0i;

    loop {
        let _e3 = i_26;
        let _e6 = i_26;
        let _e7 = textureLoad(image, vec2<i32>(_e3, 0i), _e6);
        if (_e7.x > 0.5f) {
        } else {
            break;
        }
        {
        }
        continuing {
            let _e12 = i_26;
            i_26 = (_e12 + 1i);
        }
    }
    let _e14 = i_26;
    return _e14;
}

fn breaks_after_step() -> i32 {
    var i_27: i32 = 0i;

    loop {
        let _e2 = i_27;
        if (_e2 < 8i) {
        } else {
            break;
        }
        continuing {
            let _e6 = i_27;
            i_27 = (_e6 + 1i);
            let _e8 = i_27;
            break if (_e8 == 5i);
        }
    }
    let _e11 = i_27;
    return _e11;
}

@compute @workgroup_size(1, 1, 1) 
fn main() {
    let _e0 = counted();
    let _e1 = constant_bound();
    let _e2 = skips();
    let _e3 = doubling();
    let _e4 = steps_by_a_call();
    let _e5 = counts_a_flag();
    let _e6 = skips_through_switch();
    let _e8 = nested(0i);
    let _e9 = stores_another_ahead();
    let _e10 = steps_by_a_body_value();
    let _e11 = steps_by_a_body_load();
    let _e12 = carries_on();
    let _e13 = tests_a_named_load();
    let _e14 = inside_continuing();
    let _e15 = strides();
    let _e16 = steps_from_earlier_read();
    let _e17 = steps_to_earlier_sum();
    let _e18 = never_ends();
    let _e19 = names_its_step();
    let _e21 = argument_bound(3i);
    let _e22 = variable_bound();
    let _e23 = no_step();
    let _e24 = steps_another();
    let _e25 = steps_twice();
    let _e26 = steps_a_member();
    let _e27 = until();
    let _e28 = test_read_later();
    let _e29 = load_read_later();
    let _e31 = other_load_ahead_of_test(2i);
    let _e32 = steps_by_an_atomic();
    let _e33 = test_calls();
    let _e34 = image_test();
    let _e35 = breaks_after_step();
    return;
}

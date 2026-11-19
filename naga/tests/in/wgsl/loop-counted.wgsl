// MSL and GLSL write a counted loop as a `for` loop: one whose body opens by
// testing a local variable against a constant, and whose `continuing` block is
// one store to that variable. Any other loop keeps its test in the body and
// its `continuing` block behind a first pass gate.

const LIMIT = 6u;
const MOST = 4294967295u;

@group(0) @binding(0) var image: texture_2d<f32>;

fn f(x: i32) -> i32 { return x * 2; }

fn counted() -> i32 {
    var sum = 0;
    for (var i = 0; i < 4; i++) {
        sum += i;
    }
    return sum;
}

fn constant_bound() -> u32 {
    var sum = 0u;
    for (var i = 0u; i != LIMIT; i += 1u) {
        sum += i;
    }
    return sum;
}

// `continue` runs the step, as it does from a header.
fn skips() -> i32 {
    var sum = 0;
    for (var i = 8; i > 0; i -= 2) {
        if i == 4 {
            continue;
        }
        sum += i;
    }
    return sum;
}

// The step is any one store to the counter, not only a sum.
fn doubling() -> f32 {
    var sum = 0.0;
    for (var x = 1.0; x < 64.0; x = x * 2.0) {
        sum += x;
    }
    return sum;
}

fn steps_by_a_call() -> i32 {
    var i = 0;
    for (; i < 64; i = max(i * 2, 1)) {
    }
    return i;
}

fn counts_a_flag() -> i32 {
    var n = 0;
    for (var go = true; go != false; go = n < 3) {
        n++;
    }
    return n;
}

// `continue` leaves the one case switch GLSL writes as a loop, then runs the step.
fn skips_through_switch() -> i32 {
    var sum = 0;
    for (var i = 0; i < 4; i++) {
        switch i {
            default: {
                if i == 2 {
                    continue;
                }
            }
        }
        sum += i;
    }
    return sum;
}

// The header reads in place the load the test named.
fn tests_a_named_load() -> i32 {
    var i = 0;
    loop {
        let x = i;
        if x < 4 {
        } else {
            break;
        }
        continuing {
            i++;
        }
    }
    return i;
}

fn inside_continuing() -> i32 {
    var n = 0;
    var i = 0;
    loop {
        if i >= 2 {
            break;
        }
        continuing {
            i++;
            for (var j = 0; j < 3; j++) {
                n++;
            }
        }
    }
    return n;
}

// The step reads `stride` from the body, so it is declared ahead of the loop.
fn strides() -> i32 {
    var i = 0;
    loop {
        if i < 64 {
        } else {
            break;
        }
        let stride = f(i) + 1;
        continuing {
            i += stride;
        }
    }
    return i;
}

// `start` holds the counter as it was before the loop, not at the step.
fn steps_from_earlier_read() -> i32 {
    var i = 0;
    var n = 0;
    let start = i;
    for (; i < 4; i = start + n) {
        n++;
    }
    return n;
}

// `next` holds the sum the body made, before it stored to the counter again.
fn steps_to_earlier_sum() -> i32 {
    var i = 0;
    var n = 0;
    loop {
        if i < 4 {
        } else {
            break;
        }
        let next = i + 1;
        i = 10;
        n++;
        continuing {
            i = next;
        }
    }
    return n;
}

// ANGLE takes a loop whose test cannot fail for one that ends, so these keep
// the form it guards.
fn never_ends() -> i32 {
    var n = 0;
    for (var i = 0; i <= 2147483647; i++) {
        n++;
    }
    for (var j = 0; j >= -2147483648; j--) {
        n++;
    }
    for (var k = 0u; k <= MOST; k++) {
        n++;
    }
    for (var l = 0u; l >= 0u; l--) {
        n++;
    }
    return n;
}

// A named sum in `continuing` is a temporary, which a header cannot declare.
fn names_its_step() -> i32 {
    var i = 0;
    loop {
        if i < 4 {
        } else {
            break;
        }
        continuing {
            let next = i + 1;
            i = next;
        }
    }
    return i;
}

// Metal ran slower with a `for` loop bounded by an argument.
fn argument_bound(n: i32) -> i32 {
    var sum = 0;
    for (var i = 0; i < n; i++) {
        sum += i;
    }
    return sum;
}

fn variable_bound() -> i32 {
    var n = 4;
    var sum = 0;
    for (var i = 0; i < n; i++) {
        n -= 1;
        sum += i;
    }
    return sum;
}

fn no_step() -> u32 {
    var n = 40u;
    var steps = 0u;
    while n > 1u {
        n /= 2u;
        steps += 1u;
    }
    return steps;
}

fn steps_another() -> i32 {
    var i = 0;
    var j = 0;
    for (; i < 4; j++) {
        i += j;
    }
    return j;
}

fn steps_twice() -> i32 {
    var i = 0;
    var j = 8;
    loop {
        if i < 8 {
        } else {
            break;
        }
        continuing {
            i++;
            j--;
        }
    }
    return j;
}

fn steps_a_member() -> i32 {
    var v = vec2(0, 0);
    for (; v.x < 4; v.x++) {
    }
    return v.x;
}

// The test breaks where it holds.
fn until() -> i32 {
    var i = 0;
    loop {
        if i >= 4 {
            break;
        }
        continuing {
            i++;
        }
    }
    return i;
}

// The body reads `inside` after the test, so the test stays where it is.
fn test_read_later() -> i32 {
    var hits = 0;
    var i = 0;
    loop {
        let inside = i < 4;
        if inside {
        } else {
            break;
        }
        hits += i32(inside);
        continuing {
            i++;
        }
    }
    return hits;
}

// A call is a statement, which a header cannot hold.
fn test_calls() -> i32 {
    var i = 0;
    for (; f(i) < 8; i++) {
    }
    return i;
}

// A texture load clamps its level in a statement ahead of it.
fn image_test() -> i32 {
    var i = 0;
    for (; textureLoad(image, vec2(i, 0), i).x > 0.5; i++) {
    }
    return i;
}

// `break if` runs after the step.
fn breaks_after_step() -> i32 {
    var i = 0;
    loop {
        if i < 8 {
        } else {
            break;
        }
        continuing {
            i++;
            break if i == 5;
        }
    }
    return i;
}

@compute @workgroup_size(1)
fn main() {
    _ = counted();
    _ = constant_bound();
    _ = skips();
    _ = doubling();
    _ = steps_by_a_call();
    _ = counts_a_flag();
    _ = skips_through_switch();
    _ = tests_a_named_load();
    _ = inside_continuing();
    _ = strides();
    _ = steps_from_earlier_read();
    _ = steps_to_earlier_sum();
    _ = never_ends();
    _ = names_its_step();
    _ = argument_bound(3);
    _ = variable_bound();
    _ = no_step();
    _ = steps_another();
    _ = steps_twice();
    _ = steps_a_member();
    _ = until();
    _ = test_read_later();
    _ = test_calls();
    _ = image_test();
    _ = breaks_after_step();
}

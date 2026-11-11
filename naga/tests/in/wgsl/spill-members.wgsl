// The uses of a member a dynamic index spills share one spill variable,
// stored once where the value holding it is computed.

@group(0) @binding(0) var<uniform> pick: vec4u;

struct Rows {
    a: array<vec4f, 4>,
    b: array<vec4f, 4>,
    f: f32,
}

fn rows() -> Rows {
    var r: Rows;
    r.a[0] = vec4f(pick);
    r.f = 2.0;
    return r;
}

fn by_value(r: Rows) -> vec4f {
    return r.a[pick.x] + r.a[pick.y] + r.b[pick.z];
}

@fragment
fn main() -> @location(0) vec4f {
    var source = rows();
    let copy = source;
    var sum = copy.a[pick.x] + copy.a[pick.y] * copy.f;
    let made = rows();
    if pick.z > 1u {
        sum += made.b[pick.z];
    } else {
        sum += made.b[pick.w];
    }
    for (var k = 0u; k < pick.x; k++) {
        sum += made.a[k] + made.a[pick.y];
    }
    var grid = array<array<vec4f, 2>, 2>(array(sum, sum), array(vec4f(1.0), sum));
    let table = grid;
    sum += table[1][pick.x] + table[1][pick.y];
    // A value indexed dynamically itself is read through its own variable.
    let both = grid;
    sum += both[pick.x][pick.y] + both[1][pick.z];
    // A value whose source is written after it is read through its own variable.
    var later = rows();
    let before = later;
    later.f = 0.0;
    sum += before.a[pick.x] + before.a[pick.y];
    let all = array<Rows, 2>(copy, made);
    sum += all[pick.x].a[pick.y] + all[pick.z].b[1];
    return sum + by_value(made);
}

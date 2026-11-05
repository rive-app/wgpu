// A value indexed dynamically is stored into its spill variable once where it
// is computed, rather than before every index.

@group(0) @binding(0) var<uniform> pick: vec4u;

fn table() -> array<vec4f, 4> {
    return array<vec4f, 4>(vec4f(1.0), vec4f(2.0), vec4f(3.0), vec4f(4.0));
}

@fragment
fn main() -> @location(0) vec4f {
    var source = table();
    source[0] = vec4f(pick.xyzw);
    let copy = source;
    let result = table();
    var sum = copy[pick.x] + copy[pick.y] + result[pick.z] + result[pick.w];
    for (var k = 0u; k < pick.x; k++) {
        let row = array<vec4f, 2>(vec4f(f32(k)), sum);
        sum += row[k & 1u] + row[pick.y & 1u];
    }
    return sum;
}

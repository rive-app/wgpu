// Adreno reads a loaded struct or array from its variable again where the
// value is used, after later stores to it, so such a value keeps a variable of
// its own.

struct L { p: vec3f, r: f32 }
struct W { pad: vec4f, m: mat3x3f }

@group(0) @binding(0) var<uniform> i: u32;

@fragment
fn main() -> @location(0) vec4f {
    var c = array<L, 2>(L(vec3f(1.0), 2.0), L(vec3f(3.0), 4.0));
    let k = c;
    let e = c[1];
    c[1].p = vec3f(0.0);
    var w: W;
    let kw = w;
    w.m[2] = vec3f(1.0);
    var ms = array<mat2x2f, 2>();
    let km = ms;
    ms[1][0] = vec2f(1.0);
    // Written before its load only, so read in place.
    var o: L;
    o.p = vec3f(5.0);
    let ko = o;
    return vec4f(k[1].p + k[i].p + e.p + kw.m[2] + ko.p, km[1][0].x);
}

struct L {
    p: vec3<f32>,
    r: f32,
}

struct W {
    pad: vec4<f32>,
    m: mat3x3<f32>,
}

@group(0) @binding(0) 
var<uniform> i: u32;

@fragment 
fn main() -> @location(0) vec4<f32> {
    var c: array<L, 2> = array<L, 2>(L(vec3(1f), 2f), L(vec3(3f), 4f));
    var w: W;
    var ms: array<mat2x2<f32>, 2> = array<mat2x2<f32>, 2>();
    var o: L;

    var k = c;
    var e = c[1];
    c[1].p = vec3(0f);
    var kw = w;
    w.m[2] = vec3(1f);
    var km = ms;
    ms[1][0] = vec2(1f);
    o.p = vec3(5f);
    let ko = o;
    let _e38 = i;
    return vec4<f32>(((((k[1].p + k[_e38].p) + e.p) + kw.m[2]) + ko.p), km[1][0].x);
}

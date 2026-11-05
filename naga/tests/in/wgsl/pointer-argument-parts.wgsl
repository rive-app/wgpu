// SPIR-V passes only whole variables to functions, so a pointer into part of
// one passes a copy, written back after the call.

struct W { pad: vec4f, m: mat3x3f }

@group(0) @binding(0) var<uniform> i: u32;

fn put(p: ptr<function, vec4f>) {
    *p = *p + vec4f(1.0);
}

fn put_column(p: ptr<function, vec3f>) {
    *p = vec3f(2.0);
}

@fragment
fn main() -> @location(0) vec4f {
    var v: array<vec4f, 4>;
    var w: W;
    put(&v[i]);
    put(&w.pad);
    put_column(&w.m[i]);
    return v[1] + w.pad + w.m[2].xyzz;
}

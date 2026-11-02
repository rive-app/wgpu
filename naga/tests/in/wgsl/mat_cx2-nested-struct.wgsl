// Uniform structs that hold an N-by-2 matrix in a nested struct or an array of
// structs, which need std140 compatible types at every level.

struct Inner {
    m: mat3x2<f32>,
    s: f32,
}

struct Mid {
    pad: vec4<f32>,
    inner: Inner,
}

struct U {
    a: vec4<f32>,
    mid: Mid,
    mids: array<Mid, 2>,
}

@group(0) @binding(0)
var<uniform> u: U;

fn take(m: Mid) -> f32 {
    return m.inner.m[2].y + m.inner.s;
}

@fragment
fn main(@builtin(position) p: vec4<f32>) -> @location(0) vec4<f32> {
    let i = u32(p.x) & 1u;
    let whole = u;
    let one = u.mids[i];
    let m = u.mid.inner.m;
    return vec4<f32>(
        take(u.mid) + whole.mids[1].inner.s,
        u.mids[i].inner.m[i].x + one.inner.s,
        u.mid.inner.m[1][i],
        u.mid.inner.m[0].y + m[2].x,
    );
}

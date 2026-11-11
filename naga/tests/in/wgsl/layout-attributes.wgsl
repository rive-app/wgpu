// Members placed by `@size` and `@align` keep their offsets in the WGSL we
// write, through a `@size` on the member before each.

struct Padded {
    @size(32) m: mat2x2<f32>,
    v: vec4<f32>,
    @size(48) n: mat3x2<f32>,
    f: f32,
}

struct Aligned {
    a: f32,
    @align(16) b: f32,
}

struct Holder {
    x: f32,
    @align(32) tail: vec2<f32>,
}

// A runtime sized array takes no `@size`, so the members before it still do.
struct Particles {
    count: u32,
    @align(16) items: array<vec2<f32>>,
}

@group(0) @binding(0) var<uniform> padded: Padded;
@group(0) @binding(1) var<uniform> holder: Holder;
@group(0) @binding(2) var<storage, read> list: array<Aligned>;
@group(0) @binding(3) var<storage, read> particles: Particles;

struct Out {
    @location(0) color: vec4<f32>,
    @builtin(frag_depth) depth: f32,
}

@fragment
fn main() -> Out {
    let sum = padded.v + vec4(padded.n[2], padded.f, holder.x + holder.tail.y + list[1].b + particles.items[particles.count].x);
    return Out(sum, 0.5);
}

struct Padded {
    @size(32) m: mat2x2<f32>,
    v: vec4<f32>,
    @size(48) n: mat3x2<f32>,
    f: f32,
}

struct Aligned {
    @size(16) a: f32,
    @size(16) b: f32,
}

struct Holder {
    @size(32) x: f32,
    @size(32) tail: vec2<f32>,
}

struct Particles {
    @size(16) count: u32,
    items: array<vec2<f32>>,
}

struct Out {
    @location(0) color: vec4<f32>,
    @builtin(frag_depth) depth: f32,
}

@group(0) @binding(0) 
var<uniform> padded: Padded;
@group(0) @binding(1) 
var<uniform> holder: Holder;
@group(0) @binding(2) 
var<storage> list: array<Aligned>;
@group(0) @binding(3) 
var<storage> particles: Particles;

@fragment 
fn main() -> Out {
    let _e2 = padded.v;
    let _e6 = padded.n[2];
    let _e9 = padded.f;
    let _e12 = holder.x;
    let _e16 = holder.tail.y;
    let _e21 = list[1].b;
    let _e27 = particles.count;
    let _e30 = particles.items[_e27].x;
    let sum = (_e2 + vec4<f32>(_e6, _e9, (((_e12 + _e16) + _e21) + _e30)));
    return Out(sum, 0.5f);
}

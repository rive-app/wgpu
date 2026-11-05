// A pointer into part of a private variable passes a copy at module scope,
// which entry points list in their interface from SPIR-V 1.4.

var<private> g: array<vec4f, 4>;

@group(0) @binding(0) var<uniform> i: u32;

fn put(p: ptr<private, vec4f>) {
    *p = *p + vec4f(1.0);
}

fn put_all(p: ptr<private, array<vec4f, 4>>) {
    put(&(*p)[i]);
}

fn twice() {
    put(&g[i]);
    put(&g[0]);
}

@fragment
fn main() -> @location(0) vec4f {
    twice();
    twice();
    put_all(&g);
    return g[1];
}

@fragment
fn other() -> @location(0) vec4f {
    put(&g[2]);
    return g[2];
}

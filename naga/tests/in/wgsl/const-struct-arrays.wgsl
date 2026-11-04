// Adreno fails to compile a dynamic index into a `const` array of structs or
// one written inline, and ANGLE on Metal fails to draw one holding matrices.

struct L { p: vec3f, r: f32 }
struct W { pad: vec4f, m: mat3x3f }
struct H { ls: array<L, 2> }

const LS = array<L, 2>(L(vec3f(1.0), 3.0), L(vec3f(2.0), 4.0));
const WS = array<W, 2>(W(vec4f(1.0), mat3x3f()), W(vec4f(2.0), mat3x3f()));
const HS = H(array<L, 2>(L(vec3f(1.0), 3.0), L(vec3f(2.0), 4.0)));
const VS = array<vec4f, 2>(vec4f(1.0), vec4f(2.0));
// Adreno misreads arrays of structs holding arrays however they are declared,
// so these stay const, which fails most of them to compile there.
const HS2 = array<H, 2>(HS, HS);

@group(0) @binding(0) var<uniform> i: u32;

@fragment
fn main() -> @location(0) vec4f {
    let written = array<L, 2>(L(vec3f(5.0), 6.0), L(vec3f(7.0), 8.0))[i].p;
    return vec4f(LS[i].p + WS[i].m[0] + HS.ls[i].p + written, VS[i].x + HS2[i].ls[1].r);
}

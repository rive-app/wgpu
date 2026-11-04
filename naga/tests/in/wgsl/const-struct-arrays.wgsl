// Adreno fails to compile a dynamic index into a `const` array of structs or
// one written inline, and ANGLE on Metal fails to draw one holding matrices.

struct L { p: vec3f, r: f32 }
struct W { pad: vec4f, m: mat3x3f }
struct H { ls: array<L, 2> }

const LS = array<L, 2>(L(vec3f(1.0), 3.0), L(vec3f(2.0), 4.0));
const WS = array<W, 2>(W(vec4f(1.0), mat3x3f()), W(vec4f(2.0), mat3x3f()));
const HS = H(array<L, 2>(L(vec3f(1.0), 3.0), L(vec3f(2.0), 4.0)));
const VS = array<vec4f, 2>(vec4f(1.0), vec4f(2.0));
// Adreno misreads arrays of structs holding arrays initialized or assigned
// whole, so they fill one element at a time.
const HS2 = array<H, 2>(HS, HS);
var<private> PH = HS2;
var<private> ZH: array<H, 2>;

@group(0) @binding(0) var<uniform> i: u32;

@fragment
fn main() -> @location(0) vec4f {
    let written = array<L, 2>(L(vec3f(5.0), 6.0), L(vec3f(7.0), 8.0))[i].p;
    let written_holding = array<H, 2>(HS, H(array<L, 2>(L(vec3f(5.0), 6.0), L(vec3f(7.0), 8.0))))[i].ls[1].p;
    var c = HS2;
    var z: array<H, 2>;
    z = c;
    let copy = z;
    ZH[i] = PH[i];
    var n = 0u;
    loop {
        let a = array<H, 2>(c[n], c[1]);
        n += 1u;
        c[0].ls[0].r = f32(n);
        continuing {
            z = a;
            break if n > i;
        }
    }
    let p = LS[i].p + WS[i].m[0] + HS.ls[i].p + written + written_holding + c[i].ls[i].p + copy[i].ls[0].p;
    return vec4f(p, VS[i].x + HS2[i].ls[1].r + PH[i].ls[0].r + ZH[1].ls[i].r);
}

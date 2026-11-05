// GLSL ES 3.00 has no textureGather, so gathers read the four texels they
// cover at their centers instead.

@group(0) @binding(0) var tf: texture_2d<f32>;
@group(0) @binding(1) var ti: texture_2d<i32>;
@group(0) @binding(2) var tu: texture_2d_array<u32>;
@group(0) @binding(3) var td: texture_depth_2d;
@group(0) @binding(4) var tda: texture_depth_2d_array;
@group(0) @binding(5) var s: sampler;
@group(0) @binding(6) var sc: sampler_comparison;
@group(0) @binding(7) var tp: texture_depth_2d;
@group(0) @binding(8) var<uniform> uv: vec4f;
@fragment fn main() -> @location(0) vec4f {
    var r = textureGather(1, tf, s, uv.xy) + textureGather(2, tf, s, uv.xy, vec2i(-1, 2));
    r += vec4f(textureGather(0, ti, s, uv.xy)) + vec4f(textureGather(3, tu, s, uv.xy, 1, vec2i(1, 0)));
    r += textureGatherCompare(td, sc, uv.xy, uv.z) + textureGatherCompare(tda, sc, uv.xy, 1u, uv.z, vec2i(0, 1));
    r += textureGather(tp, s, uv.zw);
    return r;
}

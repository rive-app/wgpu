// A gather takes no level, so it skips the textureGrad that stands in for
// textureLod on array and cube shadow samplers.

@group(0) @binding(0) var t: texture_depth_2d_array;
@group(0) @binding(1) var s: sampler_comparison;
@group(0) @binding(2) var c: texture_depth_cube;

@fragment
fn main(@location(0) uv: vec2f) -> @location(0) vec4f {
    return textureGatherCompare(t, s, uv, 1, 0.5, vec2i(0, 1)) + textureGatherCompare(c, s, vec3f(uv, 1.0), 0.5);
}

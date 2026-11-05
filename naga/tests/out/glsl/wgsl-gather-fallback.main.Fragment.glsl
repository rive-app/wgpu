#version 300 es

precision highp float;
precision highp int;

vec4 naga_gather(highp sampler2D t, vec2 uv, ivec2 offset, int component) {
    vec2 size = vec2(textureSize(t, 0).xy);
    vec2 base = floor(uv.xy * size - 0.5) + vec2(offset) + 0.5;
    return vec4(textureLod(t, (base + vec2(0, 1)) / size, 0.0)[component], textureLod(t, (base + vec2(1, 1)) / size, 0.0)[component], textureLod(t, (base + vec2(1, 0)) / size, 0.0)[component], textureLod(t, (base + vec2(0, 0)) / size, 0.0)[component]);
}

ivec4 naga_gather(highp isampler2D t, vec2 uv, ivec2 offset, int component) {
    vec2 size = vec2(textureSize(t, 0).xy);
    vec2 base = floor(uv.xy * size - 0.5) + vec2(offset) + 0.5;
    return ivec4(textureLod(t, (base + vec2(0, 1)) / size, 0.0)[component], textureLod(t, (base + vec2(1, 1)) / size, 0.0)[component], textureLod(t, (base + vec2(1, 0)) / size, 0.0)[component], textureLod(t, (base + vec2(0, 0)) / size, 0.0)[component]);
}

uvec4 naga_gather(highp usampler2DArray t, vec3 uv, ivec2 offset, int component) {
    vec2 size = vec2(textureSize(t, 0).xy);
    vec2 base = floor(uv.xy * size - 0.5) + vec2(offset) + 0.5;
    return uvec4(textureLod(t, vec3((base + vec2(0, 1)) / size, uv.z), 0.0)[component], textureLod(t, vec3((base + vec2(1, 1)) / size, uv.z), 0.0)[component], textureLod(t, vec3((base + vec2(1, 0)) / size, uv.z), 0.0)[component], textureLod(t, vec3((base + vec2(0, 0)) / size, uv.z), 0.0)[component]);
}

vec4 naga_gather(highp sampler2DShadow t, vec2 uv, ivec2 offset, float depth_ref) {
    vec2 size = vec2(textureSize(t, 0).xy);
    vec2 base = floor(uv.xy * size - 0.5) + vec2(offset) + 0.5;
    return vec4(textureLod(t, vec3((base + vec2(0, 1)) / size, depth_ref), 0.0), textureLod(t, vec3((base + vec2(1, 1)) / size, depth_ref), 0.0), textureLod(t, vec3((base + vec2(1, 0)) / size, depth_ref), 0.0), textureLod(t, vec3((base + vec2(0, 0)) / size, depth_ref), 0.0));
}

vec4 naga_gather(highp sampler2DArrayShadow t, vec3 uv, ivec2 offset, float depth_ref) {
    vec2 size = vec2(textureSize(t, 0).xy);
    vec2 base = floor(uv.xy * size - 0.5) + vec2(offset) + 0.5;
    return vec4(textureGrad(t, vec4((base + vec2(0, 1)) / size, uv.z, depth_ref), vec2(0.0), vec2(0.0)), textureGrad(t, vec4((base + vec2(1, 1)) / size, uv.z, depth_ref), vec2(0.0), vec2(0.0)), textureGrad(t, vec4((base + vec2(1, 0)) / size, uv.z, depth_ref), vec2(0.0), vec2(0.0)), textureGrad(t, vec4((base + vec2(0, 0)) / size, uv.z, depth_ref), vec2(0.0), vec2(0.0)));
}

uniform highp sampler2D _group_0_binding_0_fs;

uniform highp isampler2D _group_0_binding_1_fs;

uniform highp usampler2DArray _group_0_binding_2_fs;

uniform highp sampler2DShadow _group_0_binding_3_fs;

uniform highp sampler2DArrayShadow _group_0_binding_4_fs;

uniform highp sampler2D _group_0_binding_7_fs;

layout(std140) uniform type_7_block_0Fragment { vec4 _group_0_binding_8_fs; };

layout(location = 0) out vec4 _fs2p_location0;

void main() {
    vec4 r = vec4(0.0);
    vec4 _e3 = _group_0_binding_8_fs;
    vec4 _e5 = naga_gather(_group_0_binding_0_fs, _e3.xy, ivec2(0), 1);
    vec4 _e9 = _group_0_binding_8_fs;
    vec4 _e14 = naga_gather(_group_0_binding_0_fs, _e9.xy, ivec2(-1, 2), 2);
    r = (_e5 + _e14);
    vec4 _e17 = r;
    vec4 _e21 = _group_0_binding_8_fs;
    ivec4 _e23 = naga_gather(_group_0_binding_1_fs, _e21.xy, ivec2(0), 0);
    vec4 _e28 = _group_0_binding_8_fs;
    uvec4 _e34 = naga_gather(_group_0_binding_2_fs, vec3(_e28.xy, 1), ivec2(1, 0), 3);
    r = (_e17 + (vec4(_e23) + vec4(_e34)));
    vec4 _e38 = r;
    vec4 _e42 = _group_0_binding_8_fs;
    float _e46 = _group_0_binding_8_fs.z;
    vec4 _e47 = naga_gather(_group_0_binding_3_fs, _e42.xy, ivec2(0), _e46);
    vec4 _e51 = _group_0_binding_8_fs;
    float _e56 = _group_0_binding_8_fs.z;
    vec4 _e60 = naga_gather(_group_0_binding_4_fs, vec3(_e51.xy, 1u), ivec2(0, 1), _e56);
    r = (_e38 + (_e47 + _e60));
    vec4 _e63 = r;
    vec4 _e67 = _group_0_binding_8_fs;
    vec4 _e69 = naga_gather(_group_0_binding_7_fs, _e67.zw, ivec2(0), 0);
    r = (_e63 + _e69);
    vec4 _e71 = r;
    _fs2p_location0 = _e71;
    return;
}


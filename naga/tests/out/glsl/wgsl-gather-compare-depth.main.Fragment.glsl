#version 310 es

precision highp float;
precision highp int;

uniform highp sampler2DArrayShadow _group_0_binding_0_fs;

uniform highp samplerCubeShadow _group_0_binding_2_fs;

layout(location = 0) smooth in vec2 _vs2fs_location0;
layout(location = 0) out vec4 _fs2p_location0;

void main() {
    vec2 uv = _vs2fs_location0;
    vec4 _e8 = textureGatherOffset(_group_0_binding_0_fs, vec3(uv, 1), 0.5, ivec2(0, 1));
    vec4 _e14 = textureGather(_group_0_binding_2_fs, vec3(vec3(uv, 1.0)), 0.5);
    _fs2p_location0 = (_e8 + _e14);
    return;
}


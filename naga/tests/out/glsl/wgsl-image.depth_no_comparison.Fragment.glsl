#version 430 core
uniform sampler2D _group_1_binding_2_fs;

layout(location = 0) out vec4 _fs2p_location0;

void main() {
    vec2 tc = vec2(0.5);
    float s2d = texture(_group_1_binding_2_fs, vec2(tc)).x;
    vec4 s2d_gather = textureGather(_group_1_binding_2_fs, vec2(tc), 0);
    float s2d_level = textureLod(_group_1_binding_2_fs, vec2(tc), float(1)).x;
    _fs2p_location0 = ((vec4(s2d) + s2d_gather) + vec4(s2d_level));
    return;
}


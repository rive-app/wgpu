#version 330 core

void main() {
    int i = 0;
    ivec2 i2_ = ivec2(0);
    ivec3 i3_ = ivec3(0);
    ivec4 i4_ = ivec4(0);
    uint u = 0u;
    uvec2 u2_ = uvec2(0u);
    uvec3 u3_ = uvec3(0u);
    uvec4 u4_ = uvec4(0u);
    vec2 f2_ = vec2(0.0);
    vec4 f4_ = vec4(0.0);
    ivec4 _e25 = i4_;
    u = uint((_e25[0] & 0xFF) | ((_e25[1] & 0xFF) << 8) | ((_e25[2] & 0xFF) << 16) | ((_e25[3] & 0xFF) << 24));
    uvec4 _e27 = u4_;
    u = (_e27[0] & 0xFFu) | ((_e27[1] & 0xFFu) << 8) | ((_e27[2] & 0xFFu) << 16) | ((_e27[3] & 0xFFu) << 24);
    uint _e29 = u;
    f4_ = (vec4(ivec4(_e29 << 24, _e29 << 16, _e29 << 8, _e29) >> 24) / 127.0);
    uint _e31 = u;
    f4_ = (vec4(_e31 & 0xFFu, _e31 >> 8 & 0xFFu, _e31 >> 16 & 0xFFu, _e31 >> 24) / 255.0);
    uint _e33 = u;
    f2_ = (vec2(ivec2(_e33 << 16, _e33) >> 16) / 32767.0);
    uint _e35 = u;
    f2_ = (vec2(_e35 & 0xFFFFu, _e35 >> 16) / 65535.0);
    int _e37 = i;
    i = (int(floor(log2(float(max(uint(_e37) & (uint(0u) - uint(_e37)), uint(1u)))) + 0.5)) - int(uint(_e37) == 0u));
    uvec2 _e39 = u2_;
    u2_ = uvec2((ivec2(floor(log2(vec2(max(_e39 & (uvec2(0u) - _e39), uvec2(1u)))) + 0.5)) - ivec2(equal(_e39, uvec2(0u)))));
    return;
}


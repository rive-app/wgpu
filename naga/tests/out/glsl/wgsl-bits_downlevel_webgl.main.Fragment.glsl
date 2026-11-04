#version 300 es

precision highp float;
precision highp int;


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
    vec4 _e25 = f4_;
    u = ((uint(int(floor(clamp(_e25[0], -1.0, 1.0) * 127.0 + 0.5))) & 255u) << 0u | (uint(int(floor(clamp(_e25[1], -1.0, 1.0) * 127.0 + 0.5))) & 255u) << 8u | (uint(int(floor(clamp(_e25[2], -1.0, 1.0) * 127.0 + 0.5))) & 255u) << 16u | (uint(int(floor(clamp(_e25[3], -1.0, 1.0) * 127.0 + 0.5))) & 255u) << 24u);
    vec4 _e27 = f4_;
    u = ((uint(int(floor(clamp(_e27[0], 0.0, 1.0) * 255.0 + 0.5))) & 255u) << 0u | (uint(int(floor(clamp(_e27[1], 0.0, 1.0) * 255.0 + 0.5))) & 255u) << 8u | (uint(int(floor(clamp(_e27[2], 0.0, 1.0) * 255.0 + 0.5))) & 255u) << 16u | (uint(int(floor(clamp(_e27[3], 0.0, 1.0) * 255.0 + 0.5))) & 255u) << 24u);
    vec2 _e29 = f2_;
    u = packSnorm2x16(floor(_e29 * 32767.0 + 0.5) / 32767.0);
    vec2 _e31 = f2_;
    u = packUnorm2x16(floor(_e31 * 65535.0 + 0.5) / 65535.0);
    ivec4 _e33 = i4_;
    u = uint((_e33[0] & 0xFF) | ((_e33[1] & 0xFF) << 8) | ((_e33[2] & 0xFF) << 16) | ((_e33[3] & 0xFF) << 24));
    uvec4 _e35 = u4_;
    u = (_e35[0] & 0xFFu) | ((_e35[1] & 0xFFu) << 8) | ((_e35[2] & 0xFFu) << 16) | ((_e35[3] & 0xFFu) << 24);
    uint _e37 = u;
    f4_ = max(vec4((ivec4(uvec4(_e37) >> uvec4(0u, 8u, 16u, 24u) & 255u) ^ 128) - 128) / 127.0, vec4(-1.0));
    uint _e39 = u;
    f4_ = (vec4(_e39 & 0xFFu, _e39 >> 8 & 0xFFu, _e39 >> 16 & 0xFFu, _e39 >> 24) / 255.0);
    uint _e41 = u;
    f2_ = unpackSnorm2x16(_e41);
    uint _e43 = u;
    f2_ = unpackUnorm2x16(_e43);
    int _e45 = i;
    i = (int(floor(log2(float(max(uint(_e45) & (uint(0u) - uint(_e45)), uint(1u)))) + 0.5)) - int(uint(_e45) == 0u));
    uvec2 _e47 = u2_;
    u2_ = uvec2((ivec2(floor(log2(vec2(max(_e47 & (uvec2(0u) - _e47), uvec2(1u)))) + 0.5)) - ivec2(equal(_e47, uvec2(0u)))));
    return;
}


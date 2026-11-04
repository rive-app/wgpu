#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
#extension GL_EXT_shader_8bit_storage : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

void main()
{
    vec4 _48 = vec4(0.0);
    uvec3 _42 = uvec3(0u);
    ivec4 _36 = ivec4(0);
    int _30 = 0;
    uvec4 _44 = uvec4(0u);
    uint _38 = 0u;
    ivec2 _32 = ivec2(0);
    vec2 _46 = vec2(0.0);
    uvec2 _40 = uvec2(0u);
    ivec3 _34 = ivec3(0);
    _38 = packSnorm4x8(floor((_48 * vec4(127.0)) + vec4(0.5)) / vec4(127.0));
    _38 = packUnorm4x8(floor((_48 * vec4(255.0)) + vec4(0.5)) / vec4(255.0));
    _38 = packSnorm2x16(floor((_46 * vec2(32767.0)) + vec2(0.5)) / vec2(32767.0));
    _38 = packUnorm2x16(floor((_46 * vec2(65535.0)) + vec2(0.5)) / vec2(65535.0));
    _38 = packHalf2x16(_46);
    _38 = pack32(u8vec4(_36));
    _38 = pack32(u8vec4(_44));
    _38 = pack32(u8vec4(clamp(_36, ivec4(-128), ivec4(127))));
    _38 = pack32(u8vec4(clamp(_44, uvec4(0u), uvec4(255u))));
    _48 = unpackSnorm4x8(_38);
    _48 = unpackUnorm4x8(_38);
    _46 = unpackSnorm2x16(_38);
    _46 = unpackUnorm2x16(_38);
    _46 = unpackHalf2x16(_38);
    _36 = ivec4(unpack8(_38));
    _44 = uvec4(unpack8(_38));
    uint _132 = min(5u, 32u);
    _30 = bitfieldInsert(_30, _30, int(_132), int(min(10u, (32u - _132))));
    uint _138 = min(5u, 32u);
    _32 = bitfieldInsert(_32, _32, int(_138), int(min(10u, (32u - _138))));
    uint _144 = min(5u, 32u);
    _34 = bitfieldInsert(_34, _34, int(_144), int(min(10u, (32u - _144))));
    uint _150 = min(5u, 32u);
    _36 = bitfieldInsert(_36, _36, int(_150), int(min(10u, (32u - _150))));
    uint _156 = min(5u, 32u);
    _38 = bitfieldInsert(_38, _38, int(_156), int(min(10u, (32u - _156))));
    uint _162 = min(5u, 32u);
    _40 = bitfieldInsert(_40, _40, int(_162), int(min(10u, (32u - _162))));
    uint _168 = min(5u, 32u);
    _42 = bitfieldInsert(_42, _42, int(_168), int(min(10u, (32u - _168))));
    uint _174 = min(5u, 32u);
    _44 = bitfieldInsert(_44, _44, int(_174), int(min(10u, (32u - _174))));
    uint _179 = min(5u, 32u);
    _30 = bitfieldExtract(_30, int(_179), int(min(10u, (32u - _179))));
    uint _184 = min(5u, 32u);
    _32 = bitfieldExtract(_32, int(_184), int(min(10u, (32u - _184))));
    uint _189 = min(5u, 32u);
    _34 = bitfieldExtract(_34, int(_189), int(min(10u, (32u - _189))));
    uint _194 = min(5u, 32u);
    _36 = bitfieldExtract(_36, int(_194), int(min(10u, (32u - _194))));
    uint _199 = min(5u, 32u);
    _38 = bitfieldExtract(_38, int(_199), int(min(10u, (32u - _199))));
    uint _204 = min(5u, 32u);
    _40 = bitfieldExtract(_40, int(_204), int(min(10u, (32u - _204))));
    uint _209 = min(5u, 32u);
    _42 = bitfieldExtract(_42, int(_209), int(min(10u, (32u - _209))));
    uint _214 = min(5u, 32u);
    _44 = bitfieldExtract(_44, int(_214), int(min(10u, (32u - _214))));
    _30 = findLSB(_30);
    _40 = uvec2(findLSB(_40));
    _34 = findMSB(_34);
    _42 = uvec3(findMSB(_42));
    _30 = findMSB(_30);
    _38 = uint(findMSB(_38));
    _30 = bitCount(_30);
    _32 = bitCount(_32);
    _34 = bitCount(_34);
    _36 = bitCount(_36);
    _38 = uint(bitCount(_38));
    _40 = uvec2(bitCount(_40));
    _42 = uvec3(bitCount(_42));
    _44 = uvec4(bitCount(_44));
    _30 = bitfieldReverse(_30);
    _32 = bitfieldReverse(_32);
    _34 = bitfieldReverse(_34);
    _36 = bitfieldReverse(_36);
    _38 = bitfieldReverse(_38);
    _40 = bitfieldReverse(_40);
    _42 = bitfieldReverse(_42);
    _44 = bitfieldReverse(_44);
}


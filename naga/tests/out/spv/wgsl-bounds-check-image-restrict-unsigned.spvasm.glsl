#version 460
#extension GL_EXT_samplerless_texture_functions : require

layout(set = 0, binding = 0) uniform texture1D image_1d;
layout(set = 0, binding = 1) uniform texture2D image_2d;
layout(set = 0, binding = 2) uniform texture2DArray image_2d_array;
layout(set = 0, binding = 3) uniform texture2D image_depth_2d;

layout(location = 0) out vec4 _88;

vec4 test_textureLoad_1d(uint coords, uint level)
{
    int _31 = int(min(level, uint(textureQueryLevels(image_1d) - 1)));
    return texelFetch(image_1d, int(min(coords, (uint(textureSize(image_1d, _31)) - 1u))), _31);
}

vec4 test_textureLoad_2d(uvec2 coords, uint level)
{
    int _46 = int(min(level, uint(textureQueryLevels(image_2d) - 1)));
    return texelFetch(image_2d, ivec2(min(coords, (uvec2(textureSize(image_2d, _46)) - uvec2(1u)))), _46);
}

vec4 test_textureLoad_2d_array(uvec2 coords, int index, uint level)
{
    int _65 = int(min(level, uint(textureQueryLevels(image_2d_array) - 1)));
    return texelFetch(image_2d_array, ivec3(min(uvec3(coords, uint(index)), (uvec3(textureSize(image_2d_array, _65)) - uvec3(1u)))), _65);
}

float test_textureLoad_depth_2d(uvec2 coords, uint level)
{
    int _80 = int(min(level, uint(textureQueryLevels(image_depth_2d) - 1)));
    return texelFetch(image_depth_2d, ivec2(min(coords, (uvec2(textureSize(image_depth_2d, _80)) - uvec2(1u)))), _80).x;
}

void main()
{
    _88 = vec4(0.0);
}


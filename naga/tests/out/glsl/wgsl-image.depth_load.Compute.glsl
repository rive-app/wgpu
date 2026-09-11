#version 430 core
#extension GL_ARB_compute_shader : require
layout(local_size_x = 16, local_size_y = 1, local_size_z = 1) in;

uniform sampler2DMS _group_0_binding_4_cs;

layout(rgba8ui) readonly uniform uimage2D _group_0_binding_1_cs;

layout(r32ui) writeonly uniform uimage1D _group_0_binding_2_cs;


void main() {
    uvec3 local_id_1 = gl_LocalInvocationID;
    uvec2 dim = uvec2(imageSize(_group_0_binding_1_cs).xy);
    ivec2 itc = (ivec2((dim * local_id_1.xy)) % ivec2(10, 20));
    float val = texelFetch(_group_0_binding_4_cs, itc, int(local_id_1.z)).x;
    imageStore(_group_0_binding_2_cs, itc.x, uvec4(uint(val)));
    return;
}


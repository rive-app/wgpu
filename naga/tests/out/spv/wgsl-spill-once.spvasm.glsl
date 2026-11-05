#version 460

layout(set = 0, binding = 0, std140) uniform _12_11
{
    uvec4 _m0;
} _11;

layout(location = 0) out vec4 _28;

vec4[4] _15()
{
    return vec4[](vec4(1.0), vec4(2.0), vec4(3.0), vec4(4.0));
}

void main()
{
    vec4 _36[4] = vec4[](vec4(0.0), vec4(0.0), vec4(0.0), vec4(0.0));
    vec4 _39 = vec4(0.0);
    uint _42 = 0u;
    uvec2 _86 = uvec2(4294967295u);
    _36 = _15();
    _36[0u] = vec4(_11._m0.xyzw);
    vec4 _51[4] = _36;
    vec4 _53[4] = _15();
    _39 = ((_51[_11._m0.x] + _51[_11._m0.y]) + _53[_11._m0.z]) + _53[_11._m0.w];
    for (;;)
    {
        if (all(equal(uvec2(0u), _86)))
        {
            break;
        }
        _86 -= uvec2(uint(_86.y == 0u), 1u);
        if (!(_42 < _11._m0.x))
        {
            break;
        }
        vec4 _111[2] = vec4[](vec4(float(_42)), _39);
        _39 += (_111[_42 & 1u] + _111[_11._m0.y & 1u]);
        _42++;
        continue;
    }
    _28 = _39;
}


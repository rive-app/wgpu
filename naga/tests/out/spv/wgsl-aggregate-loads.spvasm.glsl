#version 460

struct _5
{
    vec3 _m0;
    float _m1;
};

struct _8
{
    vec4 _m0;
    mat3 _m1;
};

layout(set = 0, binding = 0, std140) uniform _16_15
{
    uint _m0;
} _15;

layout(location = 0) out vec4 _19;

void main()
{
    _8 _43 = _8(vec4(0.0), mat3(vec3(0.0), vec3(0.0), vec3(0.0)));
    _5 _48 = _5(vec3(0.0), 0.0);
    _5 _41[2] = _5[](_5(vec3(1.0), 2.0), _5(vec3(3.0), 4.0));
    mat2 _46[2] = mat2[](mat2(vec2(0.0), vec2(0.0)), mat2(vec2(0.0), vec2(0.0)));
    _5 _53[2] = _41;
    _5 _58 = _41[1u];
    _41[1u]._m0 = vec3(0.0);
    _8 _63 = _43;
    _43._m1[2u] = vec3(1.0);
    mat2 _68[2] = _46;
    _46[1u][0u] = vec2(1.0);
    _48._m0 = vec3(5.0);
    _19 = vec4((((_53[1u]._m0 + _53[_15._m0]._m0) + _58._m0) + _63._m1[2u]) + _48._m0, _68[1u][0u].x);
}


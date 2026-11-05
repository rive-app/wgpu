#version 460

struct _7
{
    vec4 _m0;
    mat3 _m1;
};

layout(set = 0, binding = 0, std140) uniform _14_13
{
    uint _m0;
} _13;

layout(location = 0) out vec4 _33;

void _18(inout vec4 _17)
{
    _17 += vec4(1.0);
}

void _27(out vec3 _26)
{
    _26 = vec3(2.0);
}

void main()
{
    vec4 _40[4] = vec4[](vec4(0.0), vec4(0.0), vec4(0.0), vec4(0.0));
    _7 _43 = _7(vec4(0.0), mat3(vec3(0.0), vec3(0.0), vec3(0.0)));
    vec4 _50 = _40[_13._m0];
    _18(_50);
    _40[_13._m0] = _50;
    vec4 _55 = _43._m0;
    _18(_55);
    _43._m0 = _55;
    vec3 _63 = _43._m1[_13._m0];
    _27(_63);
    _43._m1[_13._m0] = _63;
    _33 = (_40[1u] + _43._m0) + _43._m1[2u].xyzz;
}


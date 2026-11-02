#version 460

struct Inner
{
    mat3x2 m;
    float s;
};

struct Mid
{
    vec4 pad;
    Inner inner;
};

struct U
{
    vec4 a;
    Mid mid;
    Mid mids[2];
};

struct std140_Inner
{
    vec2 m_col0;
    vec2 m_col1;
    vec2 m_col2;
    float s;
};

struct std140_Mid
{
    vec4 pad;
    std140_Inner inner;
};

struct std140_U
{
    vec4 a;
    std140_Mid mid;
    std140_Mid mids[2];
};

layout(set = 0, binding = 0, std140) uniform u
{
    std140_U _m0;
} u_1;

layout(location = 0) out vec4 _88;

Inner Inner_from_std140(std140_Inner _47)
{
    return Inner(mat3x2(_47.m_col0, _47.m_col1, _47.m_col2), _47.s);
}

Mid Mid_from_std140(std140_Mid _41)
{
    return Mid(_41.pad, Inner_from_std140(_41.inner));
}

Mid[2] array_Mid_2_from_std140(std140_Mid _61[2])
{
    return Mid[](Mid_from_std140(_61[0]), Mid_from_std140(_61[1]));
}

U U_from_std140(std140_U _35)
{
    return U(_35.a, Mid_from_std140(_35.mid), array_Mid_2_from_std140(_35.mids));
}

float take(Mid m)
{
    return m.inner.m[2].y + m.inner.s;
}

vec2 mat3x2_f32_get_column(mat3x2 _71, uint _72)
{
    vec2 _83;
    switch (_72)
    {
        case 0u:
        {
            _83 = _71[0];
            break;
        }
        case 1u:
        {
            _83 = _71[1];
            break;
        }
        case 2u:
        {
            _83 = _71[2];
            break;
        }
        default:
        {
            break; // unreachable workaround
        }
    }
    return _83;
}

void main()
{
    uint _103 = uint(clamp(gl_FragCoord.x, 0.0, 4294967040.0)) & 1u;
    _88 = vec4(take(Mid_from_std140(u_1._m0.mid)) + U_from_std140(u_1._m0).mids[1].inner.s, mat3x2_f32_get_column(mat3x2(u_1._m0.mids[_103].inner.m_col0, u_1._m0.mids[_103].inner.m_col1, u_1._m0.mids[_103].inner.m_col2), _103).x + Mid_from_std140(u_1._m0.mids[_103]).inner.s, u_1._m0.mid.inner.m_col1[_103], u_1._m0.mid.inner.m_col0.y + mat3x2(u_1._m0.mid.inner.m_col0, u_1._m0.mid.inner.m_col1, u_1._m0.mid.inner.m_col2)[2].x);
}


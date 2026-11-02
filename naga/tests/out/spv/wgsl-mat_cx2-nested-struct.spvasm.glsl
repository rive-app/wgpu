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

layout(location = 0) out vec4 _51;

float take(Mid m)
{
    return m.inner.m[2].y + m.inner.s;
}

vec2 mat3x2_f32_get_column(mat3x2 _34, uint _35)
{
    vec2 _46;
    switch (_35)
    {
        case 0u:
        {
            _46 = _34[0];
            break;
        }
        case 1u:
        {
            _46 = _34[1];
            break;
        }
        case 2u:
        {
            _46 = _34[2];
            break;
        }
        default:
        {
            break; // unreachable workaround
        }
    }
    return _46;
}

void main()
{
    uint _66 = uint(clamp(gl_FragCoord.x, 0.0, 4294967040.0)) & 1u;
    _51 = vec4(take(Mid(u_1._m0.mid.pad, Inner(mat3x2(u_1._m0.mid.inner.m_col0, u_1._m0.mid.inner.m_col1, u_1._m0.mid.inner.m_col2), u_1._m0.mid.inner.s))) + U(u_1._m0.a, Mid(u_1._m0.mid.pad, Inner(mat3x2(u_1._m0.mid.inner.m_col0, u_1._m0.mid.inner.m_col1, u_1._m0.mid.inner.m_col2), u_1._m0.mid.inner.s)), Mid[](Mid(u_1._m0.mids[0].pad, Inner(mat3x2(u_1._m0.mids[0].inner.m_col0, u_1._m0.mids[0].inner.m_col1, u_1._m0.mids[0].inner.m_col2), u_1._m0.mids[0].inner.s)), Mid(u_1._m0.mids[1].pad, Inner(mat3x2(u_1._m0.mids[1].inner.m_col0, u_1._m0.mids[1].inner.m_col1, u_1._m0.mids[1].inner.m_col2), u_1._m0.mids[1].inner.s)))).mids[1].inner.s, mat3x2_f32_get_column(mat3x2(u_1._m0.mids[_66].inner.m_col0, u_1._m0.mids[_66].inner.m_col1, u_1._m0.mids[_66].inner.m_col2), _66).x + Mid(u_1._m0.mids[_66].pad, Inner(mat3x2(u_1._m0.mids[_66].inner.m_col0, u_1._m0.mids[_66].inner.m_col1, u_1._m0.mids[_66].inner.m_col2), u_1._m0.mids[_66].inner.s)).inner.s, u_1._m0.mid.inner.m_col1[_66], u_1._m0.mid.inner.m_col0.y + mat3x2(u_1._m0.mid.inner.m_col0, u_1._m0.mid.inner.m_col1, u_1._m0.mid.inner.m_col2)[2].x);
}


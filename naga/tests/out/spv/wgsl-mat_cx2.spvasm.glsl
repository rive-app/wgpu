#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct StructWithMat
{
    mat2 m;
};

struct StructWithArrayOfStructOfMat
{
    StructWithMat a[4];
};

struct std140_mat2x2_f32_
{
    vec2 col0;
    vec2 col1;
};

struct std140_StructWithMat
{
    vec2 m_col0;
    vec2 m_col1;
};

struct std140_StructWithArrayOfStructOfMat
{
    std140_StructWithMat a[4];
};

layout(set = 0, binding = 0, std430) buffer s_m
{
    mat2 _m0;
} s_m_1;

layout(set = 0, binding = 1, std140) uniform u_m
{
    std140_mat2x2_f32_ _m0;
} u_m_1;

layout(set = 1, binding = 0, std430) buffer s_sm
{
    StructWithMat _m0;
} s_sm_1;

layout(set = 1, binding = 1, std140) uniform u_sm
{
    std140_StructWithMat _m0;
} u_sm_1;

layout(set = 2, binding = 0, std430) buffer s_am
{
    mat2 _m0[4];
} s_am_1;

layout(set = 2, binding = 1, std140) uniform u_am
{
    std140_mat2x2_f32_ _m0[4];
} u_am_1;

layout(set = 3, binding = 0, std430) buffer s_sasm
{
    StructWithArrayOfStructOfMat _m0;
} s_sasm_1;

layout(set = 3, binding = 1, std140) uniform u_sasm
{
    std140_StructWithArrayOfStructOfMat _m0;
} u_sasm_1;

vec2 mat2x2_f32_get_column(mat2 _44, uint _45)
{
    vec2 _54;
    switch (_45)
    {
        case 0u:
        {
            _54 = _44[0];
            break;
        }
        case 1u:
        {
            _54 = _44[1];
            break;
        }
        default:
        {
            break; // unreachable workaround
        }
    }
    return _54;
}

void access_m()
{
    int idx = 1;
    idx--;
    s_m_1._m0 = mat2(u_m_1._m0.col0, u_m_1._m0.col1);
    s_m_1._m0[0u] = u_m_1._m0.col0;
    s_m_1._m0[idx] = mat2x2_f32_get_column(mat2(u_m_1._m0.col0, u_m_1._m0.col1), uint(idx));
    s_m_1._m0[0u].x = u_m_1._m0.col0.x;
    s_m_1._m0[0u][idx] = u_m_1._m0.col0[idx];
    s_m_1._m0[idx].x = mat2x2_f32_get_column(mat2(u_m_1._m0.col0, u_m_1._m0.col1), uint(idx)).x;
    s_m_1._m0[idx][idx] = mat2x2_f32_get_column(mat2(u_m_1._m0.col0, u_m_1._m0.col1), uint(idx))[idx];
}

void access_sm()
{
    int idx = 1;
    idx--;
    s_sm_1._m0 = StructWithMat(mat2(u_sm_1._m0.m_col0, u_sm_1._m0.m_col1));
    s_sm_1._m0.m = mat2(u_sm_1._m0.m_col0, u_sm_1._m0.m_col1);
    s_sm_1._m0.m[0u] = u_sm_1._m0.m_col0;
    s_sm_1._m0.m[idx] = mat2x2_f32_get_column(mat2(u_sm_1._m0.m_col0, u_sm_1._m0.m_col1), uint(idx));
    s_sm_1._m0.m[0u].x = u_sm_1._m0.m_col0.x;
    s_sm_1._m0.m[0u][idx] = u_sm_1._m0.m_col0[idx];
    s_sm_1._m0.m[idx].x = mat2x2_f32_get_column(mat2(u_sm_1._m0.m_col0, u_sm_1._m0.m_col1), uint(idx)).x;
    s_sm_1._m0.m[idx][idx] = mat2x2_f32_get_column(mat2(u_sm_1._m0.m_col0, u_sm_1._m0.m_col1), uint(idx))[idx];
}

void access_am()
{
    int idx = 1;
    idx--;
    s_am_1._m0 = mat2[](mat2(u_am_1._m0[0].col0, u_am_1._m0[0].col1), mat2(u_am_1._m0[1].col0, u_am_1._m0[1].col1), mat2(u_am_1._m0[2].col0, u_am_1._m0[2].col1), mat2(u_am_1._m0[3].col0, u_am_1._m0[3].col1));
    s_am_1._m0[0u] = mat2(u_am_1._m0[0u].col0, u_am_1._m0[0u].col1);
    s_am_1._m0[idx] = mat2(u_am_1._m0[idx].col0, u_am_1._m0[idx].col1);
    s_am_1._m0[0u][0u] = u_am_1._m0[0u].col0;
    s_am_1._m0[0u][idx] = mat2x2_f32_get_column(mat2(u_am_1._m0[0u].col0, u_am_1._m0[0u].col1), uint(idx));
    s_am_1._m0[idx][0u] = u_am_1._m0[idx].col0;
    s_am_1._m0[idx][idx] = mat2x2_f32_get_column(mat2(u_am_1._m0[idx].col0, u_am_1._m0[idx].col1), uint(idx));
    s_am_1._m0[0u][0u].x = u_am_1._m0[0u].col0.x;
    s_am_1._m0[0u][0u][idx] = u_am_1._m0[0u].col0[idx];
    s_am_1._m0[0u][idx].x = mat2x2_f32_get_column(mat2(u_am_1._m0[0u].col0, u_am_1._m0[0u].col1), uint(idx)).x;
    s_am_1._m0[0u][idx][idx] = mat2x2_f32_get_column(mat2(u_am_1._m0[0u].col0, u_am_1._m0[0u].col1), uint(idx))[idx];
    s_am_1._m0[idx][0u].x = u_am_1._m0[idx].col0.x;
    s_am_1._m0[idx][0u][idx] = u_am_1._m0[idx].col0[idx];
    s_am_1._m0[idx][idx].x = mat2x2_f32_get_column(mat2(u_am_1._m0[idx].col0, u_am_1._m0[idx].col1), uint(idx)).x;
    s_am_1._m0[idx][idx][idx] = mat2x2_f32_get_column(mat2(u_am_1._m0[idx].col0, u_am_1._m0[idx].col1), uint(idx))[idx];
}

void access_sasm()
{
    int idx = 1;
    idx--;
    s_sasm_1._m0 = StructWithArrayOfStructOfMat(StructWithMat[](StructWithMat(mat2(u_sasm_1._m0.a[0].m_col0, u_sasm_1._m0.a[0].m_col1)), StructWithMat(mat2(u_sasm_1._m0.a[1].m_col0, u_sasm_1._m0.a[1].m_col1)), StructWithMat(mat2(u_sasm_1._m0.a[2].m_col0, u_sasm_1._m0.a[2].m_col1)), StructWithMat(mat2(u_sasm_1._m0.a[3].m_col0, u_sasm_1._m0.a[3].m_col1))));
    s_sasm_1._m0.a = StructWithMat[](StructWithMat(mat2(u_sasm_1._m0.a[0].m_col0, u_sasm_1._m0.a[0].m_col1)), StructWithMat(mat2(u_sasm_1._m0.a[1].m_col0, u_sasm_1._m0.a[1].m_col1)), StructWithMat(mat2(u_sasm_1._m0.a[2].m_col0, u_sasm_1._m0.a[2].m_col1)), StructWithMat(mat2(u_sasm_1._m0.a[3].m_col0, u_sasm_1._m0.a[3].m_col1)));
    s_sasm_1._m0.a[0u].m = mat2(u_sasm_1._m0.a[0u].m_col0, u_sasm_1._m0.a[0u].m_col1);
    s_sasm_1._m0.a[idx].m = mat2(u_sasm_1._m0.a[idx].m_col0, u_sasm_1._m0.a[idx].m_col1);
    s_sasm_1._m0.a[0u].m[0u] = u_sasm_1._m0.a[0u].m_col0;
    s_sasm_1._m0.a[0u].m[idx] = mat2x2_f32_get_column(mat2(u_sasm_1._m0.a[0u].m_col0, u_sasm_1._m0.a[0u].m_col1), uint(idx));
    s_sasm_1._m0.a[idx].m[0u] = u_sasm_1._m0.a[idx].m_col0;
    s_sasm_1._m0.a[idx].m[idx] = mat2x2_f32_get_column(mat2(u_sasm_1._m0.a[idx].m_col0, u_sasm_1._m0.a[idx].m_col1), uint(idx));
    s_sasm_1._m0.a[0u].m[0u].x = u_sasm_1._m0.a[0u].m_col0.x;
    s_sasm_1._m0.a[0u].m[0u][idx] = u_sasm_1._m0.a[0u].m_col0[idx];
    s_sasm_1._m0.a[0u].m[idx].x = mat2x2_f32_get_column(mat2(u_sasm_1._m0.a[0u].m_col0, u_sasm_1._m0.a[0u].m_col1), uint(idx)).x;
    s_sasm_1._m0.a[0u].m[idx][idx] = mat2x2_f32_get_column(mat2(u_sasm_1._m0.a[0u].m_col0, u_sasm_1._m0.a[0u].m_col1), uint(idx))[idx];
    s_sasm_1._m0.a[idx].m[0u].x = u_sasm_1._m0.a[idx].m_col0.x;
    s_sasm_1._m0.a[idx].m[0u][idx] = u_sasm_1._m0.a[idx].m_col0[idx];
    s_sasm_1._m0.a[idx].m[idx].x = mat2x2_f32_get_column(mat2(u_sasm_1._m0.a[idx].m_col0, u_sasm_1._m0.a[idx].m_col1), uint(idx)).x;
    s_sasm_1._m0.a[idx].m[idx][idx] = mat2x2_f32_get_column(mat2(u_sasm_1._m0.a[idx].m_col0, u_sasm_1._m0.a[idx].m_col1), uint(idx))[idx];
}

void main()
{
    access_m();
    access_sm();
    access_am();
    access_sasm();
}


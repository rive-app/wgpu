#version 430 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

uniform sampler2D _group_0_binding_0_cs;

layout(std430) buffer type_4_block_0Compute { vec2 _group_0_binding_1_cs; };

int counter = 0;


int f(int x) {
    return (x * 2);
}

void named() {
    int a = 0;
    bool cmp;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            if (cmp) {
                break;
            }
        }
        loop_init = false;
        int _e2 = a;
        cmp = (_e2 < 8);
        if (cmp) {
            int _e5 = a;
            a = (_e5 + 1);
        }
    }
    return;
}

void call_result() {
    int a_1 = 0;
    int v;
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            if ((v > 10)) {
                break;
            }
        }
        loop_init_1 = false;
        int _e2 = a_1;
        v = f(_e2);
        int _e4 = a_1;
        a_1 = (_e4 + 1);
    }
    return;
}

void through_pointer() {
    int arr[4] = int[4](0, 1, 2, 3);
    int i = 0;
    int _e8;
    bool loop_init_2 = true;
    while(true) {
        if (!loop_init_2) {
            int _e13 = arr[_e8];
            if ((_e13 > 2)) {
                break;
            }
        }
        loop_init_2 = false;
        _e8 = i;
        int _e10 = i;
        i = (_e10 + 1);
    }
    return;
}

void nested() {
    int a_2 = 0;
    bool outer;
    bool loop_init_3 = true;
    while(true) {
        if (!loop_init_3) {
            if (outer) {
                break;
            }
        }
        loop_init_3 = false;
        int _e2 = a_2;
        outer = (_e2 < 8);
        bool inner;
        bool loop_init_4 = true;
        while(true) {
            if (!loop_init_4) {
                if (inner) {
                    break;
                }
            }
            loop_init_4 = false;
            int _e5 = a_2;
            inner = (_e5 < 4);
            int _e8 = a_2;
            a_2 = (_e8 + 1);
        }
    }
    return;
}

void dead_use() {
    int a_3 = 0;
    int v_1;
    int w;
    bool loop_init_5 = true;
    while(true) {
        if (!loop_init_5) {
            int _e10 = a_3;
            if ((_e10 > 5)) {
                int dead = (v_1 + w);
            }
            int _e14 = a_3;
            if ((_e14 > 10)) {
                break;
            }
        }
        loop_init_5 = false;
        int _e2 = a_3;
        v_1 = f(_e2);
        int _e4 = a_3;
        w = (_e4 * 2);
        int _e7 = a_3;
        a_3 = (_e7 + 1);
    }
    return;
}

void restricted_image_load() {
    int i_1 = 0;
    float val;
    bool loop_init_6 = true;
    while(true) {
        if (!loop_init_6) {
            if ((val > 0.0)) {
                break;
            }
        }
        loop_init_6 = false;
        int _e3 = i_1;
        int _e7_clamped_lod = clamp(0, 0, textureQueryLevels(_group_0_binding_0_cs) - 1);
        vec4 _e7 = texelFetch(_group_0_binding_0_cs, clamp(ivec2(_e3, 0), ivec2(0), textureSize(_group_0_binding_0_cs, _e7_clamped_lod) - ivec2(1)), _e7_clamped_lod);
        val = _e7.x;
        int _e9 = i_1;
        i_1 = (_e9 + 1);
    }
    return;
}

uint one() {
    return 1u;
}

void call_result_as_index() {
    float v1_;
    bool loop_init_7 = true;
    while(true) {
        if (!loop_init_7) {
            if ((v1_ > 0.0)) {
                break;
            }
        }
        loop_init_7 = false;
        uint _e1 = one();
        v1_ = _group_0_binding_1_cs[_e1];
    }
    return;
}

void break_if_uses_continuing() {
    bool loop_init_8 = true;
    while(true) {
        if (!loop_init_8) {
            int seen = counter;
            int _e3 = counter;
            counter = (_e3 + 1);
            if ((seen > 3)) {
                break;
            }
        }
        loop_init_8 = false;
    }
    return;
}

void main() {
    named();
    call_result();
    through_pointer();
    nested();
    dead_use();
    restricted_image_load();
    call_result_as_index();
    break_if_uses_continuing();
    return;
}


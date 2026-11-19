#version 430 core
#extension GL_ARB_compute_shader : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

const uint LIMIT = 6u;
const uint MOST = 4294967295u;

uniform sampler2D _group_0_binding_0_cs;


int f(int x) {
    return (x * 2);
}

int counted() {
    int sum = 0;
    int i = 0;
    for (; (i < 4); i += 1) {
        {
            int _e7 = sum;
            int _e8 = i;
            sum = (_e7 + _e8);
        }
    }
    int _e13 = sum;
    return _e13;
}

uint constant_bound() {
    uint sum_1 = 0u;
    uint i_1 = 0u;
    for (; (i_1 != LIMIT); i_1 += 1u) {
        {
            uint _e7 = sum_1;
            uint _e8 = i_1;
            sum_1 = (_e7 + _e8);
        }
    }
    uint _e13 = sum_1;
    return _e13;
}

int skips() {
    int sum_2 = 0;
    int i_2 = 8;
    for (; (i_2 > 0); i_2 -= 2) {
        {
            int _e7 = i_2;
            if ((_e7 == 4)) {
                continue;
            }
            int _e10 = sum_2;
            int _e11 = i_2;
            sum_2 = (_e10 + _e11);
        }
    }
    int _e16 = sum_2;
    return _e16;
}

float doubling() {
    float sum_3 = 0.0;
    float x_1 = 1.0;
    for (; (x_1 < 64.0); x_1 = (x_1 * 2.0)) {
        {
            float _e7 = sum_3;
            float _e8 = x_1;
            sum_3 = (_e7 + _e8);
        }
    }
    float _e13 = sum_3;
    return _e13;
}

int steps_by_a_call() {
    int i_3 = 0;
    for (; (i_3 < 64); i_3 = max((i_3 * 2), 1)) {
        {
        }
    }
    int _e10 = i_3;
    return _e10;
}

int counts_a_flag() {
    int n = 0;
    bool go = true;
    for (; (go != false); go = (n < 3)) {
        {
            int _e8 = n;
            n = (_e8 + 1);
        }
    }
    int _e13 = n;
    return _e13;
}

int skips_through_switch() {
    int sum_4 = 0;
    int i_4 = 0;
    for (; (i_4 < 4); i_4 += 1) {
        {
            int _e7 = i_4;
            bool should_continue = false;
            do {
                int _e8 = i_4;
                if ((_e8 == 2)) {
                    should_continue = true;
                    break;
                }
            } while(false);
            if (should_continue) {
                continue;
            }
            int _e11 = sum_4;
            int _e12 = i_4;
            sum_4 = (_e11 + _e12);
        }
    }
    int _e17 = sum_4;
    return _e17;
}

int tests_a_named_load() {
    int i_5 = 0;
    for (; (i_5 < 4); i_5 += 1) {
    }
    int _e8 = i_5;
    return _e8;
}

int inside_continuing() {
    int n_1 = 0;
    int i_6 = 0;
    int j = 0;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            int _e8 = i_6;
            i_6 = (_e8 + 1);
            j = 0;
            for (; (j < 3); j += 1) {
                {
                    int _e16 = n_1;
                    n_1 = (_e16 + 1);
                }
            }
        }
        loop_init = false;
        int _e4 = i_6;
        if ((_e4 >= 2)) {
            break;
        }
    }
    int _e21 = n_1;
    return _e21;
}

int strides() {
    int i_7 = 0;
    int stride;
    for (; (i_7 < 64); i_7 += stride) {
        int _e5 = i_7;
        int _e6 = f(_e5);
        stride = (_e6 + 1);
    }
    int _e11 = i_7;
    return _e11;
}

int steps_from_earlier_read() {
    int i_8 = 0;
    int n_2 = 0;
    int start = i_8;
    for (; (i_8 < 4); i_8 = (start + n_2)) {
        {
            int _e9 = n_2;
            n_2 = (_e9 + 1);
        }
    }
    int _e13 = n_2;
    return _e13;
}

int steps_to_earlier_sum() {
    int i_9 = 0;
    int n_3 = 0;
    int next;
    for (; (i_9 < 4); i_9 = next) {
        int _e7 = i_9;
        next = (_e7 + 1);
        i_9 = 10;
        int _e12 = n_3;
        n_3 = (_e12 + 1);
    }
    int _e14 = n_3;
    return _e14;
}

int never_ends() {
    int n_4 = 0;
    int i_10 = 0;
    int j_1 = 0;
    uint k = 0u;
    uint l = 0u;
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            int _e11 = i_10;
            i_10 = (_e11 + 1);
        }
        loop_init_1 = false;
        int _e4 = i_10;
        if ((_e4 <= 2147483647)) {
        } else {
            break;
        }
        {
            int _e8 = n_4;
            n_4 = (_e8 + 1);
        }
    }
    bool loop_init_2 = true;
    while(true) {
        if (!loop_init_2) {
            int _e22 = j_1;
            j_1 = (_e22 - 1);
        }
        loop_init_2 = false;
        int _e15 = j_1;
        if ((_e15 >= -2147483648)) {
        } else {
            break;
        }
        {
            int _e19 = n_4;
            n_4 = (_e19 + 1);
        }
    }
    bool loop_init_3 = true;
    while(true) {
        if (!loop_init_3) {
            uint _e33 = k;
            k = (_e33 + 1u);
        }
        loop_init_3 = false;
        uint _e26 = k;
        if ((_e26 <= MOST)) {
        } else {
            break;
        }
        {
            int _e30 = n_4;
            n_4 = (_e30 + 1);
        }
    }
    bool loop_init_4 = true;
    while(true) {
        if (!loop_init_4) {
            uint _e44 = l;
            l = (_e44 - 1u);
        }
        loop_init_4 = false;
        uint _e37 = l;
        if ((_e37 >= 0u)) {
        } else {
            break;
        }
        {
            int _e41 = n_4;
            n_4 = (_e41 + 1);
        }
    }
    int _e46 = n_4;
    return _e46;
}

int names_its_step() {
    int i_11 = 0;
    bool loop_init_5 = true;
    while(true) {
        if (!loop_init_5) {
            int _e5 = i_11;
            int next_1 = (_e5 + 1);
            i_11 = next_1;
        }
        loop_init_5 = false;
        int _e2 = i_11;
        if ((_e2 < 4)) {
        } else {
            break;
        }
    }
    int _e8 = i_11;
    return _e8;
}

int argument_bound(int n_5) {
    int sum_5 = 0;
    int i_12 = 0;
    bool loop_init_6 = true;
    while(true) {
        if (!loop_init_6) {
            int _e11 = i_12;
            i_12 = (_e11 + 1);
        }
        loop_init_6 = false;
        int _e5 = i_12;
        if ((_e5 < n_5)) {
        } else {
            break;
        }
        {
            int _e7 = sum_5;
            int _e8 = i_12;
            sum_5 = (_e7 + _e8);
        }
    }
    int _e13 = sum_5;
    return _e13;
}

int variable_bound() {
    int n_6 = 4;
    int sum_6 = 0;
    int i_13 = 0;
    bool loop_init_7 = true;
    while(true) {
        if (!loop_init_7) {
            int _e16 = i_13;
            i_13 = (_e16 + 1);
        }
        loop_init_7 = false;
        int _e6 = i_13;
        int _e7 = n_6;
        if ((_e6 < _e7)) {
        } else {
            break;
        }
        {
            int _e9 = n_6;
            n_6 = (_e9 - 1);
            int _e12 = sum_6;
            int _e13 = i_13;
            sum_6 = (_e12 + _e13);
        }
    }
    int _e18 = sum_6;
    return _e18;
}

uint no_step() {
    uint n_7 = 40u;
    uint steps = 0u;
    while(true) {
        uint _e4 = n_7;
        if ((_e4 > 1u)) {
        } else {
            break;
        }
        {
            uint _e7 = n_7;
            n_7 = (_e7 / 2u);
            uint _e10 = steps;
            steps = (_e10 + 1u);
        }
    }
    uint _e13 = steps;
    return _e13;
}

int steps_another() {
    int i_14 = 0;
    int j_2 = 0;
    bool loop_init_8 = true;
    while(true) {
        if (!loop_init_8) {
            int _e11 = j_2;
            j_2 = (_e11 + 1);
        }
        loop_init_8 = false;
        int _e4 = i_14;
        if ((_e4 < 4)) {
        } else {
            break;
        }
        {
            int _e7 = i_14;
            int _e8 = j_2;
            i_14 = (_e7 + _e8);
        }
    }
    int _e13 = j_2;
    return _e13;
}

int steps_twice() {
    int i_15 = 0;
    int j_3 = 8;
    bool loop_init_9 = true;
    while(true) {
        if (!loop_init_9) {
            int _e8 = i_15;
            i_15 = (_e8 + 1);
            int _e11 = j_3;
            j_3 = (_e11 - 1);
        }
        loop_init_9 = false;
        int _e4 = i_15;
        if ((_e4 < 8)) {
        } else {
            break;
        }
    }
    int _e13 = j_3;
    return _e13;
}

int steps_a_member() {
    ivec2 v = ivec2(0, 0);
    bool loop_init_10 = true;
    while(true) {
        if (!loop_init_10) {
            int _e10 = v.x;
            v.x = (_e10 + 1);
        }
        loop_init_10 = false;
        int _e5 = v.x;
        if ((_e5 < 4)) {
        } else {
            break;
        }
        {
        }
    }
    int _e13 = v.x;
    return _e13;
}

int until() {
    int i_16 = 0;
    bool loop_init_11 = true;
    while(true) {
        if (!loop_init_11) {
            int _e6 = i_16;
            i_16 = (_e6 + 1);
        }
        loop_init_11 = false;
        int _e2 = i_16;
        if ((_e2 >= 4)) {
            break;
        }
    }
    int _e8 = i_16;
    return _e8;
}

int test_read_later() {
    int hits = 0;
    int i_17 = 0;
    bool loop_init_12 = true;
    while(true) {
        if (!loop_init_12) {
            int _e11 = i_17;
            i_17 = (_e11 + 1);
        }
        loop_init_12 = false;
        int _e4 = i_17;
        bool inside = (_e4 < 4);
        if (inside) {
        } else {
            break;
        }
        int _e7 = hits;
        hits = (_e7 + int(inside));
    }
    int _e13 = hits;
    return _e13;
}

int test_calls() {
    int i_18 = 0;
    bool loop_init_13 = true;
    while(true) {
        if (!loop_init_13) {
            int _e7 = i_18;
            i_18 = (_e7 + 1);
        }
        loop_init_13 = false;
        int _e2 = i_18;
        int _e3 = f(_e2);
        if ((_e3 < 8)) {
        } else {
            break;
        }
        {
        }
    }
    int _e9 = i_18;
    return _e9;
}

int image_test() {
    int i_19 = 0;
    bool loop_init_14 = true;
    while(true) {
        if (!loop_init_14) {
            int _e12 = i_19;
            i_19 = (_e12 + 1);
        }
        loop_init_14 = false;
        int _e3 = i_19;
        int _e6 = i_19;
        int _e7_clamped_lod = clamp(_e6, 0, textureQueryLevels(_group_0_binding_0_cs) - 1);
        vec4 _e7 = texelFetch(_group_0_binding_0_cs, clamp(ivec2(_e3, 0), ivec2(0), textureSize(_group_0_binding_0_cs, _e7_clamped_lod) - ivec2(1)), _e7_clamped_lod);
        if ((_e7.x > 0.5)) {
        } else {
            break;
        }
        {
        }
    }
    int _e14 = i_19;
    return _e14;
}

int breaks_after_step() {
    int i_20 = 0;
    bool loop_init_15 = true;
    while(true) {
        if (!loop_init_15) {
            int _e6 = i_20;
            i_20 = (_e6 + 1);
            int _e8 = i_20;
            if ((_e8 == 5)) {
                break;
            }
        }
        loop_init_15 = false;
        int _e2 = i_20;
        if ((_e2 < 8)) {
        } else {
            break;
        }
    }
    int _e11 = i_20;
    return _e11;
}

void main() {
    int _e0 = counted();
    uint _e1 = constant_bound();
    int _e2 = skips();
    float _e3 = doubling();
    int _e4 = steps_by_a_call();
    int _e5 = counts_a_flag();
    int _e6 = skips_through_switch();
    int _e7 = tests_a_named_load();
    int _e8 = inside_continuing();
    int _e9 = strides();
    int _e10 = steps_from_earlier_read();
    int _e11 = steps_to_earlier_sum();
    int _e12 = never_ends();
    int _e13 = names_its_step();
    int _e15 = argument_bound(3);
    int _e16 = variable_bound();
    uint _e17 = no_step();
    int _e18 = steps_another();
    int _e19 = steps_twice();
    int _e20 = steps_a_member();
    int _e21 = until();
    int _e22 = test_read_later();
    int _e23 = test_calls();
    int _e24 = image_test();
    int _e25 = breaks_after_step();
    return;
}


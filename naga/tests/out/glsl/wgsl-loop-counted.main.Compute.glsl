#version 430 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

const uint LIMIT = 6u;
const uint MOST = 4294967295u;

uniform sampler2D _group_0_binding_0_cs;

layout(std430) buffer type_4_block_0Compute { int _group_0_binding_1_cs; };


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

int nested(int n_1) {
    int total = 0;
    int z = -1;
    int y = 0;
    for (; (z <= 1); z += 1) {
        {
            y = n_1;
            for (; (y <= 1); y += 1) {
                {
                    int _e12 = total;
                    int _e13 = z;
                    int _e14 = y;
                    total = (_e12 + (_e13 * _e14));
                }
            }
        }
    }
    int _e23 = total;
    return _e23;
}

int stores_another_ahead() {
    int total_1 = 0;
    int bias = 0;
    int i_5 = 0;
    bias = 7;
    for (; (i_5 < 4); i_5 += 1) {
        {
            int _e10 = total_1;
            int _e11 = bias;
            total_1 = (_e10 + _e11);
        }
    }
    int _e16 = total_1;
    return _e16;
}

int steps_by_a_body_value() {
    int n_2 = 0;
    int i_6 = 0;
    int stride;
    for (; (i_6 < 64); i_6 += stride) {
        int _e7 = i_6;
        int _e8 = f(_e7);
        stride = (_e8 + 1);
        int _e12 = n_2;
        n_2 = (_e12 + 1);
    }
    int _e16 = n_2;
    return _e16;
}

int steps_by_a_body_load() {
    int acc = 1;
    int i_7 = 0;
    int x_2;
    for (; (i_7 < 16); i_7 += x_2) {
        x_2 = acc;
        int _e8 = acc;
        acc = (_e8 + 1);
    }
    int _e13 = acc;
    return _e13;
}

int carries_on() {
    int total_2 = 0;
    int i_8 = 0;
    int round_ = 0;
    for (; (round_ < 2); round_ += 1) {
        {
            for (; (i_8 < 4); i_8 += 1) {
                {
                    int _e12 = total_2;
                    int _e13 = i_8;
                    total_2 = (_e12 + _e13);
                }
            }
        }
    }
    int _e21 = total_2;
    return _e21;
}

int tests_a_named_load() {
    int i_9 = 0;
    for (; (i_9 < 4); i_9 += 1) {
    }
    int _e8 = i_9;
    return _e8;
}

int inside_continuing() {
    int n_3 = 0;
    int i_10 = 0;
    int j = 0;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            int _e8 = i_10;
            i_10 = (_e8 + 1);
            j = 0;
            for (; (j < 3); j += 1) {
                {
                    int _e16 = n_3;
                    n_3 = (_e16 + 1);
                }
            }
        }
        loop_init = false;
        int _e4 = i_10;
        if ((_e4 >= 2)) {
            break;
        }
    }
    int _e21 = n_3;
    return _e21;
}

int strides() {
    int i_11 = 0;
    int stride_1;
    for (; (i_11 < 64); i_11 += stride_1) {
        int _e5 = i_11;
        int _e6 = f(_e5);
        stride_1 = (_e6 + 1);
    }
    int _e11 = i_11;
    return _e11;
}

int steps_from_earlier_read() {
    int i_12 = 0;
    int n_4 = 0;
    int start = i_12;
    for (; (i_12 < 4); i_12 = (start + n_4)) {
        {
            int _e9 = n_4;
            n_4 = (_e9 + 1);
        }
    }
    int _e13 = n_4;
    return _e13;
}

int steps_to_earlier_sum() {
    int i_13 = 0;
    int n_5 = 0;
    int next;
    for (; (i_13 < 4); i_13 = next) {
        int _e7 = i_13;
        next = (_e7 + 1);
        i_13 = 10;
        int _e12 = n_5;
        n_5 = (_e12 + 1);
    }
    int _e14 = n_5;
    return _e14;
}

int never_ends() {
    int n_6 = 0;
    int i_14 = 0;
    int j_1 = 0;
    uint k = 0u;
    uint l = 0u;
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            int _e11 = i_14;
            i_14 = (_e11 + 1);
        }
        loop_init_1 = false;
        int _e4 = i_14;
        if ((_e4 <= 2147483647)) {
        } else {
            break;
        }
        {
            int _e8 = n_6;
            n_6 = (_e8 + 1);
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
            int _e19 = n_6;
            n_6 = (_e19 + 1);
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
            int _e30 = n_6;
            n_6 = (_e30 + 1);
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
            int _e41 = n_6;
            n_6 = (_e41 + 1);
        }
    }
    int _e46 = n_6;
    return _e46;
}

int names_its_step() {
    int i_15 = 0;
    bool loop_init_5 = true;
    while(true) {
        if (!loop_init_5) {
            int _e5 = i_15;
            int next_1 = (_e5 + 1);
            i_15 = next_1;
        }
        loop_init_5 = false;
        int _e2 = i_15;
        if ((_e2 < 4)) {
        } else {
            break;
        }
    }
    int _e8 = i_15;
    return _e8;
}

int argument_bound(int n_7) {
    int sum_5 = 0;
    int i_16 = 0;
    bool loop_init_6 = true;
    while(true) {
        if (!loop_init_6) {
            int _e11 = i_16;
            i_16 = (_e11 + 1);
        }
        loop_init_6 = false;
        int _e5 = i_16;
        if ((_e5 < n_7)) {
        } else {
            break;
        }
        {
            int _e7 = sum_5;
            int _e8 = i_16;
            sum_5 = (_e7 + _e8);
        }
    }
    int _e13 = sum_5;
    return _e13;
}

int variable_bound() {
    int n_8 = 4;
    int sum_6 = 0;
    int i_17 = 0;
    bool loop_init_7 = true;
    while(true) {
        if (!loop_init_7) {
            int _e16 = i_17;
            i_17 = (_e16 + 1);
        }
        loop_init_7 = false;
        int _e6 = i_17;
        int _e7 = n_8;
        if ((_e6 < _e7)) {
        } else {
            break;
        }
        {
            int _e9 = n_8;
            n_8 = (_e9 - 1);
            int _e12 = sum_6;
            int _e13 = i_17;
            sum_6 = (_e12 + _e13);
        }
    }
    int _e18 = sum_6;
    return _e18;
}

uint no_step() {
    uint n_9 = 40u;
    uint steps = 0u;
    while(true) {
        uint _e4 = n_9;
        if ((_e4 > 1u)) {
        } else {
            break;
        }
        {
            uint _e7 = n_9;
            n_9 = (_e7 / 2u);
            uint _e10 = steps;
            steps = (_e10 + 1u);
        }
    }
    uint _e13 = steps;
    return _e13;
}

int steps_another() {
    int i_18 = 0;
    int j_2 = 0;
    bool loop_init_8 = true;
    while(true) {
        if (!loop_init_8) {
            int _e11 = j_2;
            j_2 = (_e11 + 1);
        }
        loop_init_8 = false;
        int _e4 = i_18;
        if ((_e4 < 4)) {
        } else {
            break;
        }
        {
            int _e7 = i_18;
            int _e8 = j_2;
            i_18 = (_e7 + _e8);
        }
    }
    int _e13 = j_2;
    return _e13;
}

int steps_twice() {
    int i_19 = 0;
    int j_3 = 8;
    bool loop_init_9 = true;
    while(true) {
        if (!loop_init_9) {
            int _e8 = i_19;
            i_19 = (_e8 + 1);
            int _e11 = j_3;
            j_3 = (_e11 - 1);
        }
        loop_init_9 = false;
        int _e4 = i_19;
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
    int i_20 = 0;
    bool loop_init_11 = true;
    while(true) {
        if (!loop_init_11) {
            int _e6 = i_20;
            i_20 = (_e6 + 1);
        }
        loop_init_11 = false;
        int _e2 = i_20;
        if ((_e2 >= 4)) {
            break;
        }
    }
    int _e8 = i_20;
    return _e8;
}

int test_read_later() {
    int hits = 0;
    int i_21 = 0;
    bool loop_init_12 = true;
    while(true) {
        if (!loop_init_12) {
            int _e11 = i_21;
            i_21 = (_e11 + 1);
        }
        loop_init_12 = false;
        int _e4 = i_21;
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

int load_read_later() {
    int i_22 = 0;
    int n_10 = 0;
    int x_3;
    bool loop_init_13 = true;
    while(true) {
        if (!loop_init_13) {
            i_22 = (x_3 + 1);
        }
        loop_init_13 = false;
        x_3 = i_22;
        if ((x_3 < 4)) {
        } else {
            break;
        }
        i_22 = 10;
        int _e8 = n_10;
        n_10 = (_e8 + x_3);
    }
    int _e12 = n_10;
    return _e12;
}

int other_load_ahead_of_test(int a) {
    int i_23 = 0;
    int j_4 = 0;
    int n_11 = 0;
    j_4 = a;
    bool loop_init_14 = true;
    while(true) {
        if (!loop_init_14) {
            int _e14 = i_23;
            i_23 = (_e14 + 1);
        }
        loop_init_14 = false;
        int y_1 = j_4;
        int _e7 = i_23;
        if ((_e7 < 4)) {
        } else {
            break;
        }
        j_4 = 100;
        int _e11 = n_11;
        n_11 = (_e11 + y_1);
    }
    int _e16 = n_11;
    return _e16;
}

int steps_by_an_atomic() {
    int n_12 = 0;
    int i_24 = 0;
    bool loop_init_15 = true;
    while(true) {
        if (!loop_init_15) {
            int x_4 = atomicOr(_group_0_binding_1_cs, 0);
            i_24 = (x_4 + x_4);
        }
        loop_init_15 = false;
        int _e4 = i_24;
        if ((_e4 < 16)) {
        } else {
            break;
        }
        int _e8 = n_12;
        n_12 = (_e8 + 1);
    }
    int _e13 = n_12;
    return _e13;
}

int test_calls() {
    int i_25 = 0;
    bool loop_init_16 = true;
    while(true) {
        if (!loop_init_16) {
            int _e7 = i_25;
            i_25 = (_e7 + 1);
        }
        loop_init_16 = false;
        int _e2 = i_25;
        int _e3 = f(_e2);
        if ((_e3 < 8)) {
        } else {
            break;
        }
        {
        }
    }
    int _e9 = i_25;
    return _e9;
}

int image_test() {
    int i_26 = 0;
    bool loop_init_17 = true;
    while(true) {
        if (!loop_init_17) {
            int _e12 = i_26;
            i_26 = (_e12 + 1);
        }
        loop_init_17 = false;
        int _e3 = i_26;
        int _e6 = i_26;
        int _e7_clamped_lod = clamp(_e6, 0, textureQueryLevels(_group_0_binding_0_cs) - 1);
        vec4 _e7 = texelFetch(_group_0_binding_0_cs, clamp(ivec2(_e3, 0), ivec2(0), textureSize(_group_0_binding_0_cs, _e7_clamped_lod) - ivec2(1)), _e7_clamped_lod);
        if ((_e7.x > 0.5)) {
        } else {
            break;
        }
        {
        }
    }
    int _e14 = i_26;
    return _e14;
}

int breaks_after_step() {
    int i_27 = 0;
    bool loop_init_18 = true;
    while(true) {
        if (!loop_init_18) {
            int _e6 = i_27;
            i_27 = (_e6 + 1);
            int _e8 = i_27;
            if ((_e8 == 5)) {
                break;
            }
        }
        loop_init_18 = false;
        int _e2 = i_27;
        if ((_e2 < 8)) {
        } else {
            break;
        }
    }
    int _e11 = i_27;
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
    int _e8 = nested(0);
    int _e9 = stores_another_ahead();
    int _e10 = steps_by_a_body_value();
    int _e11 = steps_by_a_body_load();
    int _e12 = carries_on();
    int _e13 = tests_a_named_load();
    int _e14 = inside_continuing();
    int _e15 = strides();
    int _e16 = steps_from_earlier_read();
    int _e17 = steps_to_earlier_sum();
    int _e18 = never_ends();
    int _e19 = names_its_step();
    int _e21 = argument_bound(3);
    int _e22 = variable_bound();
    uint _e23 = no_step();
    int _e24 = steps_another();
    int _e25 = steps_twice();
    int _e26 = steps_a_member();
    int _e27 = until();
    int _e28 = test_read_later();
    int _e29 = load_read_later();
    int _e31 = other_load_ahead_of_test(2);
    int _e32 = steps_by_an_atomic();
    int _e33 = test_calls();
    int _e34 = image_test();
    int _e35 = breaks_after_step();
    return;
}


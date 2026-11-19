// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

constant uint LIMIT = 6u;
constant uint MOST = 4294967295u;

int f(
    int x
) {
    return as_type<int>(as_type<uint>(x) * as_type<uint>(2));
}

int counted(
) {
    int sum = 0;
    int i = 0;
    uint2 loop_bound = uint2(4294967295u);
    for (; i < 4; i = as_type<int>(as_type<uint>(i) + as_type<uint>(1))) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        {
            int _e7 = sum;
            int _e8 = i;
            sum = as_type<int>(as_type<uint>(_e7) + as_type<uint>(_e8));
        }
    }
    int _e13 = sum;
    return _e13;
}

uint constant_bound(
) {
    uint sum_1 = 0u;
    uint i_1 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u);
    for (; i_1 != LIMIT; i_1 = i_1 + 1u) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        {
            uint _e7 = sum_1;
            uint _e8 = i_1;
            sum_1 = _e7 + _e8;
        }
    }
    uint _e13 = sum_1;
    return _e13;
}

int skips(
) {
    int sum_2 = 0;
    int i_2 = 8;
    uint2 loop_bound_2 = uint2(4294967295u);
    for (; i_2 > 0; i_2 = as_type<int>(as_type<uint>(i_2) - as_type<uint>(2))) {
        if (metal::all(loop_bound_2 == uint2(0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        {
            int _e7 = i_2;
            if (_e7 == 4) {
                continue;
            }
            int _e10 = sum_2;
            int _e11 = i_2;
            sum_2 = as_type<int>(as_type<uint>(_e10) + as_type<uint>(_e11));
        }
    }
    int _e16 = sum_2;
    return _e16;
}

float doubling(
) {
    float sum_3 = 0.0;
    float x_1 = 1.0;
    uint2 loop_bound_3 = uint2(4294967295u);
    for (; x_1 < 64.0; x_1 = x_1 * 2.0) {
        if (metal::all(loop_bound_3 == uint2(0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        {
            float _e7 = sum_3;
            float _e8 = x_1;
            sum_3 = _e7 + _e8;
        }
    }
    float _e13 = sum_3;
    return _e13;
}

int steps_by_a_call(
) {
    int i_3 = 0;
    uint2 loop_bound_4 = uint2(4294967295u);
    for (; i_3 < 64; i_3 = metal::max(as_type<int>(as_type<uint>(i_3) * as_type<uint>(2)), 1)) {
        if (metal::all(loop_bound_4 == uint2(0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
    }
    int _e10 = i_3;
    return _e10;
}

int counts_a_flag(
) {
    int n = 0;
    bool go = true;
    uint2 loop_bound_5 = uint2(4294967295u);
    for (; go != false; go = n < 3) {
        if (metal::all(loop_bound_5 == uint2(0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        {
            int _e8 = n;
            n = as_type<int>(as_type<uint>(_e8) + as_type<uint>(1));
        }
    }
    int _e13 = n;
    return _e13;
}

int skips_through_switch(
) {
    int sum_4 = 0;
    int i_4 = 0;
    uint2 loop_bound_6 = uint2(4294967295u);
    for (; i_4 < 4; i_4 = as_type<int>(as_type<uint>(i_4) + as_type<uint>(1))) {
        if (metal::all(loop_bound_6 == uint2(0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        {
            int _e7 = i_4;
            switch(_e7) {
                default: {
                    int _e8 = i_4;
                    if (_e8 == 2) {
                        continue;
                    }
                    break;
                }
            }
            int _e11 = sum_4;
            int _e12 = i_4;
            sum_4 = as_type<int>(as_type<uint>(_e11) + as_type<uint>(_e12));
        }
    }
    int _e17 = sum_4;
    return _e17;
}

int tests_a_named_load(
) {
    int i_5 = 0;
    uint2 loop_bound_7 = uint2(4294967295u);
    for (; i_5 < 4; i_5 = as_type<int>(as_type<uint>(i_5) + as_type<uint>(1))) {
        if (metal::all(loop_bound_7 == uint2(0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
    }
    int _e8 = i_5;
    return _e8;
}

int inside_continuing(
) {
    int n_1 = 0;
    int i_6 = 0;
    int j = {};
    uint2 loop_bound_8 = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound_8 == uint2(0u))) { break; }
        loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
        if (!loop_init) {
            int _e8 = i_6;
            i_6 = as_type<int>(as_type<uint>(_e8) + as_type<uint>(1));
            j = 0;
            uint2 loop_bound_9 = uint2(4294967295u);
            for (; j < 3; j = as_type<int>(as_type<uint>(j) + as_type<uint>(1))) {
                if (metal::all(loop_bound_9 == uint2(0u))) { break; }
                loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
                {
                    int _e16 = n_1;
                    n_1 = as_type<int>(as_type<uint>(_e16) + as_type<uint>(1));
                }
            }
        }
        loop_init = false;
        int _e4 = i_6;
        if (_e4 >= 2) {
            break;
        }
    }
    int _e21 = n_1;
    return _e21;
}

int strides(
) {
    int i_7 = 0;
    int stride = {};
    uint2 loop_bound_10 = uint2(4294967295u);
    for (; i_7 < 64; i_7 = as_type<int>(as_type<uint>(i_7) + as_type<uint>(stride))) {
        if (metal::all(loop_bound_10 == uint2(0u))) { break; }
        loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
        int _e5 = i_7;
        int _e6 = f(_e5);
        stride = as_type<int>(as_type<uint>(_e6) + as_type<uint>(1));
    }
    int _e11 = i_7;
    return _e11;
}

int steps_from_earlier_read(
) {
    int i_8 = 0;
    int n_2 = 0;
    int start = i_8;
    uint2 loop_bound_11 = uint2(4294967295u);
    for (; i_8 < 4; i_8 = as_type<int>(as_type<uint>(start) + as_type<uint>(n_2))) {
        if (metal::all(loop_bound_11 == uint2(0u))) { break; }
        loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
        {
            int _e9 = n_2;
            n_2 = as_type<int>(as_type<uint>(_e9) + as_type<uint>(1));
        }
    }
    int _e13 = n_2;
    return _e13;
}

int steps_to_earlier_sum(
) {
    int i_9 = 0;
    int n_3 = 0;
    int next = {};
    uint2 loop_bound_12 = uint2(4294967295u);
    for (; i_9 < 4; i_9 = next) {
        if (metal::all(loop_bound_12 == uint2(0u))) { break; }
        loop_bound_12 -= uint2(loop_bound_12.y == 0u, 1u);
        int _e7 = i_9;
        next = as_type<int>(as_type<uint>(_e7) + as_type<uint>(1));
        i_9 = 10;
        int _e12 = n_3;
        n_3 = as_type<int>(as_type<uint>(_e12) + as_type<uint>(1));
    }
    int _e14 = n_3;
    return _e14;
}

int never_ends(
) {
    int n_4 = 0;
    int i_10 = 0;
    int j_1 = 0;
    uint k = 0u;
    uint l = 0u;
    uint2 loop_bound_13 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_13 == uint2(0u))) { break; }
        loop_bound_13 -= uint2(loop_bound_13.y == 0u, 1u);
        if (!loop_init_1) {
            int _e11 = i_10;
            i_10 = as_type<int>(as_type<uint>(_e11) + as_type<uint>(1));
        }
        loop_init_1 = false;
        int _e4 = i_10;
        if (_e4 <= 2147483647) {
        } else {
            break;
        }
        {
            int _e8 = n_4;
            n_4 = as_type<int>(as_type<uint>(_e8) + as_type<uint>(1));
        }
    }
    uint2 loop_bound_14 = uint2(4294967295u);
    bool loop_init_2 = true;
    while(true) {
        if (metal::all(loop_bound_14 == uint2(0u))) { break; }
        loop_bound_14 -= uint2(loop_bound_14.y == 0u, 1u);
        if (!loop_init_2) {
            int _e22 = j_1;
            j_1 = as_type<int>(as_type<uint>(_e22) - as_type<uint>(1));
        }
        loop_init_2 = false;
        int _e15 = j_1;
        if (_e15 >= (-2147483647 - 1)) {
        } else {
            break;
        }
        {
            int _e19 = n_4;
            n_4 = as_type<int>(as_type<uint>(_e19) + as_type<uint>(1));
        }
    }
    uint2 loop_bound_15 = uint2(4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (metal::all(loop_bound_15 == uint2(0u))) { break; }
        loop_bound_15 -= uint2(loop_bound_15.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e33 = k;
            k = _e33 + 1u;
        }
        loop_init_3 = false;
        uint _e26 = k;
        if (_e26 <= MOST) {
        } else {
            break;
        }
        {
            int _e30 = n_4;
            n_4 = as_type<int>(as_type<uint>(_e30) + as_type<uint>(1));
        }
    }
    uint2 loop_bound_16 = uint2(4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (metal::all(loop_bound_16 == uint2(0u))) { break; }
        loop_bound_16 -= uint2(loop_bound_16.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e44 = l;
            l = _e44 - 1u;
        }
        loop_init_4 = false;
        uint _e37 = l;
        if (_e37 >= 0u) {
        } else {
            break;
        }
        {
            int _e41 = n_4;
            n_4 = as_type<int>(as_type<uint>(_e41) + as_type<uint>(1));
        }
    }
    int _e46 = n_4;
    return _e46;
}

int names_its_step(
) {
    int i_11 = 0;
    uint2 loop_bound_17 = uint2(4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (metal::all(loop_bound_17 == uint2(0u))) { break; }
        loop_bound_17 -= uint2(loop_bound_17.y == 0u, 1u);
        if (!loop_init_5) {
            int _e5 = i_11;
            int next_1 = as_type<int>(as_type<uint>(_e5) + as_type<uint>(1));
            i_11 = next_1;
        }
        loop_init_5 = false;
        int _e2 = i_11;
        if (_e2 < 4) {
        } else {
            break;
        }
    }
    int _e8 = i_11;
    return _e8;
}

int argument_bound(
    int n_5
) {
    int sum_5 = 0;
    int i_12 = 0;
    uint2 loop_bound_18 = uint2(4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (metal::all(loop_bound_18 == uint2(0u))) { break; }
        loop_bound_18 -= uint2(loop_bound_18.y == 0u, 1u);
        if (!loop_init_6) {
            int _e11 = i_12;
            i_12 = as_type<int>(as_type<uint>(_e11) + as_type<uint>(1));
        }
        loop_init_6 = false;
        int _e5 = i_12;
        if (_e5 < n_5) {
        } else {
            break;
        }
        {
            int _e7 = sum_5;
            int _e8 = i_12;
            sum_5 = as_type<int>(as_type<uint>(_e7) + as_type<uint>(_e8));
        }
    }
    int _e13 = sum_5;
    return _e13;
}

int variable_bound(
) {
    int n_6 = 4;
    int sum_6 = 0;
    int i_13 = 0;
    uint2 loop_bound_19 = uint2(4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (metal::all(loop_bound_19 == uint2(0u))) { break; }
        loop_bound_19 -= uint2(loop_bound_19.y == 0u, 1u);
        if (!loop_init_7) {
            int _e16 = i_13;
            i_13 = as_type<int>(as_type<uint>(_e16) + as_type<uint>(1));
        }
        loop_init_7 = false;
        int _e6 = i_13;
        int _e7 = n_6;
        if (_e6 < _e7) {
        } else {
            break;
        }
        {
            int _e9 = n_6;
            n_6 = as_type<int>(as_type<uint>(_e9) - as_type<uint>(1));
            int _e12 = sum_6;
            int _e13 = i_13;
            sum_6 = as_type<int>(as_type<uint>(_e12) + as_type<uint>(_e13));
        }
    }
    int _e18 = sum_6;
    return _e18;
}

uint naga_div(uint lhs, uint rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}

uint no_step(
) {
    uint n_7 = 40u;
    uint steps = 0u;
    uint2 loop_bound_20 = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound_20 == uint2(0u))) { break; }
        loop_bound_20 -= uint2(loop_bound_20.y == 0u, 1u);
        uint _e4 = n_7;
        if (_e4 > 1u) {
        } else {
            break;
        }
        {
            uint _e7 = n_7;
            n_7 = naga_div(_e7, 2u);
            uint _e10 = steps;
            steps = _e10 + 1u;
        }
    }
    uint _e13 = steps;
    return _e13;
}

int steps_another(
) {
    int i_14 = 0;
    int j_2 = 0;
    uint2 loop_bound_21 = uint2(4294967295u);
    bool loop_init_8 = true;
    while(true) {
        if (metal::all(loop_bound_21 == uint2(0u))) { break; }
        loop_bound_21 -= uint2(loop_bound_21.y == 0u, 1u);
        if (!loop_init_8) {
            int _e11 = j_2;
            j_2 = as_type<int>(as_type<uint>(_e11) + as_type<uint>(1));
        }
        loop_init_8 = false;
        int _e4 = i_14;
        if (_e4 < 4) {
        } else {
            break;
        }
        {
            int _e7 = i_14;
            int _e8 = j_2;
            i_14 = as_type<int>(as_type<uint>(_e7) + as_type<uint>(_e8));
        }
    }
    int _e13 = j_2;
    return _e13;
}

int steps_twice(
) {
    int i_15 = 0;
    int j_3 = 8;
    uint2 loop_bound_22 = uint2(4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (metal::all(loop_bound_22 == uint2(0u))) { break; }
        loop_bound_22 -= uint2(loop_bound_22.y == 0u, 1u);
        if (!loop_init_9) {
            int _e8 = i_15;
            i_15 = as_type<int>(as_type<uint>(_e8) + as_type<uint>(1));
            int _e11 = j_3;
            j_3 = as_type<int>(as_type<uint>(_e11) - as_type<uint>(1));
        }
        loop_init_9 = false;
        int _e4 = i_15;
        if (_e4 < 8) {
        } else {
            break;
        }
    }
    int _e13 = j_3;
    return _e13;
}

int steps_a_member(
) {
    metal::int2 v = metal::int2(0, 0);
    uint2 loop_bound_23 = uint2(4294967295u);
    bool loop_init_10 = true;
    while(true) {
        if (metal::all(loop_bound_23 == uint2(0u))) { break; }
        loop_bound_23 -= uint2(loop_bound_23.y == 0u, 1u);
        if (!loop_init_10) {
            int _e10 = v.x;
            v.x = as_type<int>(as_type<uint>(_e10) + as_type<uint>(1));
        }
        loop_init_10 = false;
        int _e5 = v.x;
        if (_e5 < 4) {
        } else {
            break;
        }
    }
    int _e13 = v.x;
    return _e13;
}

int until(
) {
    int i_16 = 0;
    uint2 loop_bound_24 = uint2(4294967295u);
    bool loop_init_11 = true;
    while(true) {
        if (metal::all(loop_bound_24 == uint2(0u))) { break; }
        loop_bound_24 -= uint2(loop_bound_24.y == 0u, 1u);
        if (!loop_init_11) {
            int _e6 = i_16;
            i_16 = as_type<int>(as_type<uint>(_e6) + as_type<uint>(1));
        }
        loop_init_11 = false;
        int _e2 = i_16;
        if (_e2 >= 4) {
            break;
        }
    }
    int _e8 = i_16;
    return _e8;
}

int test_read_later(
) {
    int hits = 0;
    int i_17 = 0;
    uint2 loop_bound_25 = uint2(4294967295u);
    bool loop_init_12 = true;
    while(true) {
        if (metal::all(loop_bound_25 == uint2(0u))) { break; }
        loop_bound_25 -= uint2(loop_bound_25.y == 0u, 1u);
        if (!loop_init_12) {
            int _e11 = i_17;
            i_17 = as_type<int>(as_type<uint>(_e11) + as_type<uint>(1));
        }
        loop_init_12 = false;
        int _e4 = i_17;
        bool inside = _e4 < 4;
        if (inside) {
        } else {
            break;
        }
        int _e7 = hits;
        hits = as_type<int>(as_type<uint>(_e7) + as_type<uint>(static_cast<int>(inside)));
    }
    int _e13 = hits;
    return _e13;
}

int load_read_later(
) {
    int i_18 = 0;
    int n_8 = 0;
    int x_2 = {};
    uint2 loop_bound_26 = uint2(4294967295u);
    bool loop_init_13 = true;
    while(true) {
        if (metal::all(loop_bound_26 == uint2(0u))) { break; }
        loop_bound_26 -= uint2(loop_bound_26.y == 0u, 1u);
        if (!loop_init_13) {
            i_18 = as_type<int>(as_type<uint>(x_2) + as_type<uint>(1));
        }
        loop_init_13 = false;
        x_2 = i_18;
        if (x_2 < 4) {
        } else {
            break;
        }
        i_18 = 10;
        int _e8 = n_8;
        n_8 = as_type<int>(as_type<uint>(_e8) + as_type<uint>(x_2));
    }
    int _e12 = n_8;
    return _e12;
}

int other_load_ahead_of_test(
    int a
) {
    int i_19 = 0;
    int j_4 = {};
    int n_9 = 0;
    j_4 = a;
    uint2 loop_bound_27 = uint2(4294967295u);
    bool loop_init_14 = true;
    while(true) {
        if (metal::all(loop_bound_27 == uint2(0u))) { break; }
        loop_bound_27 -= uint2(loop_bound_27.y == 0u, 1u);
        if (!loop_init_14) {
            int _e14 = i_19;
            i_19 = as_type<int>(as_type<uint>(_e14) + as_type<uint>(1));
        }
        loop_init_14 = false;
        int y = j_4;
        int _e7 = i_19;
        if (_e7 < 4) {
        } else {
            break;
        }
        j_4 = 100;
        int _e11 = n_9;
        n_9 = as_type<int>(as_type<uint>(_e11) + as_type<uint>(y));
    }
    int _e16 = n_9;
    return _e16;
}

int steps_by_an_atomic(
    device metal::atomic_int const& tally
) {
    int n_10 = 0;
    int i_20 = 0;
    uint2 loop_bound_28 = uint2(4294967295u);
    bool loop_init_15 = true;
    while(true) {
        if (metal::all(loop_bound_28 == uint2(0u))) { break; }
        loop_bound_28 -= uint2(loop_bound_28.y == 0u, 1u);
        if (!loop_init_15) {
            int x_3 = metal::atomic_load_explicit(&tally, metal::memory_order_relaxed);
            i_20 = as_type<int>(as_type<uint>(x_3) + as_type<uint>(x_3));
        }
        loop_init_15 = false;
        int _e4 = i_20;
        if (_e4 < 16) {
        } else {
            break;
        }
        int _e8 = n_10;
        n_10 = as_type<int>(as_type<uint>(_e8) + as_type<uint>(1));
    }
    int _e13 = n_10;
    return _e13;
}

int test_calls(
) {
    int i_21 = 0;
    uint2 loop_bound_29 = uint2(4294967295u);
    bool loop_init_16 = true;
    while(true) {
        if (metal::all(loop_bound_29 == uint2(0u))) { break; }
        loop_bound_29 -= uint2(loop_bound_29.y == 0u, 1u);
        if (!loop_init_16) {
            int _e7 = i_21;
            i_21 = as_type<int>(as_type<uint>(_e7) + as_type<uint>(1));
        }
        loop_init_16 = false;
        int _e2 = i_21;
        int _e3 = f(_e2);
        if (_e3 < 8) {
        } else {
            break;
        }
    }
    int _e9 = i_21;
    return _e9;
}

int image_test(
    metal::texture2d<float, metal::access::sample> image
) {
    int i_22 = 0;
    uint2 loop_bound_30 = uint2(4294967295u);
    bool loop_init_17 = true;
    while(true) {
        if (metal::all(loop_bound_30 == uint2(0u))) { break; }
        loop_bound_30 -= uint2(loop_bound_30.y == 0u, 1u);
        if (!loop_init_17) {
            int _e12 = i_22;
            i_22 = as_type<int>(as_type<uint>(_e12) + as_type<uint>(1));
        }
        loop_init_17 = false;
        int _e3 = i_22;
        int _e6 = i_22;
        uint clamped_lod_e7 = metal::min(uint(_e6), image.get_num_mip_levels() - 1);
        metal::float4 _e7 = image.read(metal::min(metal::uint2(metal::int2(_e3, 0)), metal::uint2(image.get_width(clamped_lod_e7), image.get_height(clamped_lod_e7)) - 1), clamped_lod_e7);
        if (_e7.x > 0.5) {
        } else {
            break;
        }
    }
    int _e14 = i_22;
    return _e14;
}

int breaks_after_step(
) {
    int i_23 = 0;
    uint2 loop_bound_31 = uint2(4294967295u);
    bool loop_init_18 = true;
    while(true) {
        if (metal::all(loop_bound_31 == uint2(0u))) { break; }
        loop_bound_31 -= uint2(loop_bound_31.y == 0u, 1u);
        if (!loop_init_18) {
            int _e6 = i_23;
            i_23 = as_type<int>(as_type<uint>(_e6) + as_type<uint>(1));
            int _e8 = i_23;
            if (_e8 == 5) {
                break;
            }
        }
        loop_init_18 = false;
        int _e2 = i_23;
        if (_e2 < 8) {
        } else {
            break;
        }
    }
    int _e11 = i_23;
    return _e11;
}

kernel void main_(
  metal::texture2d<float, metal::access::sample> image [[user(fake0)]]
, device metal::atomic_int const& tally [[user(fake0)]]
) {
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
    int _e23 = load_read_later();
    int _e25 = other_load_ahead_of_test(2);
    int _e26 = steps_by_an_atomic(tally);
    int _e27 = test_calls();
    int _e28 = image_test(image);
    int _e29 = breaks_after_step();
    return;
}

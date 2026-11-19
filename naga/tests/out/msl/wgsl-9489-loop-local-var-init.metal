// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct type_1 {
    float inner[64];
};
struct type_2 {
    float inner[8];
};

kernel void main_(
  device type_1 const& input [[buffer(0)]]
, device type_2& output [[buffer(1)]]
) {
    uint t = 0u;
    metal::float4 acc_noinit = {};
    metal::float4 acc_init = {};
    uint d = {};
    uint2 loop_bound = uint2(4294967295u);
    for (; t < 4u; t = t + 1u) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        {
            acc_noinit = metal::float4 {};
            acc_init = metal::float4 {};
            d = 0u;
            uint2 loop_bound_1 = uint2(4294967295u);
            for (; d < 16u; d = d + 1u) {
                if (metal::all(loop_bound_1 == uint2(0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                {
                    uint _e15 = t;
                    uint _e18 = d;
                    float _e21 = input.inner[(_e15 * 16u) + _e18];
                    metal::float4 v = metal::float4(_e21);
                    metal::float4 _e23 = acc_noinit;
                    acc_noinit = _e23 + v;
                    metal::float4 _e25 = acc_init;
                    acc_init = _e25 + v;
                }
            }
            uint _e31 = t;
            float _e36 = acc_noinit.x;
            output.inner[_e31 * 2u] = _e36;
            uint _e38 = t;
            float _e45 = acc_init.x;
            output.inner[(_e38 * 2u) + 1u] = _e45;
        }
    }
    return;
}

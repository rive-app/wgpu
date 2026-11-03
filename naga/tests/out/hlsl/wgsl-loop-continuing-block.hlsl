Texture2D<float4> tex : register(t0);
RWByteAddressBuffer v0_ : register(u1);
static int counter = int(0);

int f(int x)
{
    return asint(asuint(x) * asuint(int(2)));
}

void named()
{
    int a = int(0);

    bool cmp;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            if (cmp) {
                break;
            }
        }
        loop_init = false;
        int _e2 = a;
        cmp = (_e2 < int(8));
        if (cmp) {
            int _e5 = a;
            a = asint(asuint(_e5) + asuint(int(1)));
        }
    }
    return;
}

void call_result()
{
    int a_1 = int(0);

    int v;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            if ((v > int(10))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e2 = a_1;
        v = f(_e2);
        int _e4 = a_1;
        a_1 = asint(asuint(_e4) + asuint(int(1)));
    }
    return;
}

typedef int ret_Constructarray4_int_[4];
ret_Constructarray4_int_ Constructarray4_int_(int arg0, int arg1, int arg2, int arg3) {
    int ret[4] = { arg0, arg1, arg2, arg3 };
    return ret;
}

void through_pointer()
{
    int arr[4] = Constructarray4_int_(int(0), int(1), int(2), int(3));
    int i = int(0);

    int _e8;
    uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
    bool loop_init_2 = true;
    while(true) {
        if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_2) {
            int _e13 = arr[min(uint(_e8), 3u)];
            if ((_e13 > int(2))) {
                break;
            }
        }
        loop_init_2 = false;
        _e8 = i;
        int _e10 = i;
        i = asint(asuint(_e10) + asuint(int(1)));
    }
    return;
}

void nested()
{
    int a_2 = int(0);

    bool outer;
    uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            if (outer) {
                break;
            }
        }
        loop_init_3 = false;
        int _e2 = a_2;
        outer = (_e2 < int(8));
        bool inner;
        uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
        bool loop_init_4 = true;
        while(true) {
            if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
            loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
            if (!loop_init_4) {
                if (inner) {
                    break;
                }
            }
            loop_init_4 = false;
            int _e5 = a_2;
            inner = (_e5 < int(4));
            int _e8 = a_2;
            a_2 = asint(asuint(_e8) + asuint(int(1)));
        }
    }
    return;
}

void dead_use()
{
    int a_3 = int(0);

    int v_1;
    int w;
    uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            int _e10 = a_3;
            if ((_e10 > int(5))) {
                int dead = asint(asuint(v_1) + asuint(w));
            }
            int _e14 = a_3;
            if ((_e14 > int(10))) {
                break;
            }
        }
        loop_init_5 = false;
        int _e2 = a_3;
        v_1 = f(_e2);
        int _e4 = a_3;
        w = asint(asuint(_e4) * asuint(int(2)));
        int _e7 = a_3;
        a_3 = asint(asuint(_e7) + asuint(int(1)));
    }
    return;
}

void restricted_image_load()
{
    int i_1 = int(0);

    float val;
    uint2 loop_bound_6 = uint2(4294967295u, 4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (all(loop_bound_6 == uint2(0u, 0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            if ((val > 0.0)) {
                break;
            }
        }
        loop_init_6 = false;
        int _e3 = i_1;
        float4 _e7 = tex.Load(int3(int2(_e3, int(0)), int(0)));
        val = _e7.x;
        int _e9 = i_1;
        i_1 = asint(asuint(_e9) + asuint(int(1)));
    }
    return;
}

uint one()
{
    return 1u;
}

void call_result_as_index()
{
    float v1_;
    uint2 loop_bound_7 = uint2(4294967295u, 4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (all(loop_bound_7 == uint2(0u, 0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            if ((v1_ > 0.0)) {
                break;
            }
        }
        loop_init_7 = false;
        const uint _e1 = one();
        v1_ = asfloat(v0_.Load(_e1*4));
    }
    return;
}

void break_if_uses_continuing()
{
    uint2 loop_bound_8 = uint2(4294967295u, 4294967295u);
    bool loop_init_8 = true;
    while(true) {
        if (all(loop_bound_8 == uint2(0u, 0u))) { break; }
        loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
        if (!loop_init_8) {
            int seen = counter;
            int _e3 = counter;
            counter = asint(asuint(_e3) + asuint(int(1)));
            if ((seen > int(3))) {
                break;
            }
        }
        loop_init_8 = false;
    }
    return;
}

[numthreads(1, 1, 1)]
void main()
{
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

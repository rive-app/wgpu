#version 300 es

precision highp float;
precision highp int;

struct L {
    vec3 p;
    float r;
};
struct W {
    vec4 pad;
    mat3x3 m;
};
struct H {
    L ls[2];
};
L LS[2] = L[2](L(vec3(1.0), 3.0), L(vec3(2.0), 4.0));
W WS[2] = W[2](W(vec4(1.0), mat3x3(0.0)), W(vec4(2.0), mat3x3(0.0)));
H HS = H(L[2](L(vec3(1.0), 3.0), L(vec3(2.0), 4.0)));
const vec4 VS[2] = vec4[2](vec4(1.0), vec4(2.0));
H HS2_[2];

H PH[2];

H ZH[2];

layout(std140) uniform type_8_block_0Fragment { uint _group_0_binding_0_fs; };

layout(location = 0) out vec4 _fs2p_location0;

void main() {
    HS2_[0] = H(L[2](L(vec3(1.0), 3.0), L(vec3(2.0), 4.0))); HS2_[1] = H(L[2](L(vec3(1.0), 3.0), L(vec3(2.0), 4.0)));
    PH[0] = H(L[2](L(vec3(1.0), 3.0), L(vec3(2.0), 4.0))); PH[1] = H(L[2](L(vec3(1.0), 3.0), L(vec3(2.0), 4.0)));
    ZH[0] = H(L[2](L(vec3(0.0), 0.0), L(vec3(0.0), 0.0))); ZH[1] = H(L[2](L(vec3(0.0), 0.0), L(vec3(0.0), 0.0)));
    H c[2]; c[0] = HS2_[0]; c[1] = HS2_[1];
    H z[2]; z[0] = H(L[2](L(vec3(0.0), 0.0), L(vec3(0.0), 0.0))); z[1] = H(L[2](L(vec3(0.0), 0.0), L(vec3(0.0), 0.0)));
    uint n = 0u;
    L _e8[2] = L[2](L(vec3(5.0), 6.0), L(vec3(7.0), 8.0));
    uint _e10 = _group_0_binding_0_fs;
    vec3 written = _e8[_e10].p;
    H _e33[2]; _e33[0] = H(L[2](L(vec3(1.0), 3.0), L(vec3(2.0), 4.0))); _e33[1] = H(L[2](L(vec3(5.0), 6.0), L(vec3(7.0), 8.0)));
    uint _e35 = _group_0_binding_0_fs;
    vec3 written_holding = _e33[_e35].ls[1].p;
    H _e43[2]; _e43[0] = c[0]; _e43[1] = c[1];
    z[0] = _e43[0]; z[1] = _e43[1];
    H copy[2]; copy[0] = z[0]; copy[1] = z[1];
    uint _e47 = _group_0_binding_0_fs;
    uint _e51 = _group_0_binding_0_fs;
    H _e53 = PH[_e51];
    ZH[_e47] = _e53;
    H a[2];
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            z[0] = a[0]; z[1] = a[1];
            uint _e71 = n;
            uint _e73 = _group_0_binding_0_fs;
            if ((_e71 > _e73)) {
                break;
            }
        }
        loop_init = false;
        uint _e56 = n;
        H _e58 = c[_e56];
        H _e60 = c[1];
        a[0] = _e58; a[1] = _e60;
        uint _e62 = n;
        n = (_e62 + 1u);
        uint _e69 = n;
        c[0].ls[0].r = float(_e69);
    }
    uint _e77 = _group_0_binding_0_fs;
    uint _e82 = _group_0_binding_0_fs;
    L _e95[2] = L[2](L(vec3(1.0), 3.0), L(vec3(2.0), 4.0));
    uint _e97 = _group_0_binding_0_fs;
    uint _e104 = _group_0_binding_0_fs;
    uint _e108 = _group_0_binding_0_fs;
    vec3 _e111 = c[_e104].ls[_e108].p;
    uint _e114 = _group_0_binding_0_fs;
    vec3 p = ((((((LS[_e77].p + WS[_e82].m[0]) + _e95[_e97].p) + written) + written_holding) + _e111) + copy[_e114].ls[0].p);
    uint _e122 = _group_0_binding_0_fs;
    uint _e127 = _group_0_binding_0_fs;
    uint _e135 = _group_0_binding_0_fs;
    float _e140 = PH[_e135].ls[0].r;
    uint _e146 = _group_0_binding_0_fs;
    float _e149 = ZH[1].ls[_e146].r;
    _fs2p_location0 = vec4(p, (((VS[_e122].x + HS2_[_e127].ls[1].r) + _e140) + _e149));
    return;
}


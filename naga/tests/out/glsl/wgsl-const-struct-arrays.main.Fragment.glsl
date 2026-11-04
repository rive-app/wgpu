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
const H HS2_[2] = H[2](H(L[2](L(vec3(1.0), 3.0), L(vec3(2.0), 4.0))), H(L[2](L(vec3(1.0), 3.0), L(vec3(2.0), 4.0))));

layout(std140) uniform type_8_block_0Fragment { uint _group_0_binding_0_fs; };

layout(location = 0) out vec4 _fs2p_location0;

void main() {
    L _e8[2] = L[2](L(vec3(5.0), 6.0), L(vec3(7.0), 8.0));
    uint _e10 = _group_0_binding_0_fs;
    vec3 written = _e8[_e10].p;
    uint _e15 = _group_0_binding_0_fs;
    uint _e20 = _group_0_binding_0_fs;
    L _e33[2] = L[2](L(vec3(1.0), 3.0), L(vec3(2.0), 4.0));
    uint _e35 = _group_0_binding_0_fs;
    uint _e42 = _group_0_binding_0_fs;
    uint _e47 = _group_0_binding_0_fs;
    _fs2p_location0 = vec4((((LS[_e15].p + WS[_e20].m[0]) + _e33[_e35].p) + written), (VS[_e42].x + HS2_[_e47].ls[1].r));
    return;
}


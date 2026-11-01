@group(0) @binding(0)
var image_1d: texture_1d<f32>;

fn test_textureLoad_1d(coords: u32, level: u32) -> vec4<f32> {
   return textureLoad(image_1d, coords, level);
}

@group(0) @binding(1)
var image_2d: texture_2d<f32>;

fn test_textureLoad_2d(coords: vec2<u32>, level: u32) -> vec4<f32> {
   return textureLoad(image_2d, coords, level);
}

@group(0) @binding(2)
var image_2d_array: texture_2d_array<f32>;

fn test_textureLoad_2d_array(coords: vec2<u32>, index: i32, level: u32) -> vec4<f32> {
   return textureLoad(image_2d_array, coords, index, level);
}

@group(0) @binding(3)
var image_depth_2d: texture_depth_2d;

fn test_textureLoad_depth_2d(coords: vec2<u32>, level: u32) -> f32 {
   return textureLoad(image_depth_2d, coords, level);
}

@fragment
fn fragment_shader() -> @location(0) vec4<f32> {
    test_textureLoad_1d(0u, 0u);
    test_textureLoad_2d(vec2<u32>(), 0u);
    test_textureLoad_2d_array(vec2<u32>(), 0, 0u);
    test_textureLoad_depth_2d(vec2<u32>(), 0u);
    return vec4<f32>(0.,0.,0.,0.);
}

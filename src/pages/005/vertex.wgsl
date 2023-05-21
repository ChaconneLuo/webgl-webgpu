@group(0) @binding(0) var<uniform> scaleMatrix:mat4x4<f32>;
@group(0) @binding(1) var<uniform> rotateMatrix:mat4x4<f32>;
   
@vertex
fn main(@location(0) pos: vec3<f32>) -> @builtin(position) vec4<f32> {
    var homogeneousPos = vec4<f32>(pos, 1.0);
    return scaleMatrix * rotateMatrix * homogeneousPos;
}
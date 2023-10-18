@group(0) @binding(0) var<uniform> scaleMatrix:mat4x4<f32>;
@group(0) @binding(1) var<uniform> rotateMatrix:mat4x4<f32>;
   
@fragment
fn fs_main(@builtin(position) frag: vec4<f32>) -> @location(0) vec4<f32> {
    if frag.z > 0.5 {
        return vec4<f32>(1.0, 1.0, 1.0, 1.0);
    } else {
        return vec4<f32>(0.0, 1.0, 0.0, 1.0);
    }
}

@vertex
fn vs_main(@location(0) pos: vec3<f32>) -> @builtin(position) vec4<f32> {
    var homogeneousPos = vec4<f32>(pos, 1.0);
    return scaleMatrix * rotateMatrix * homogeneousPos;
}
@fragment
fn fs_main() -> @location(0) vec4<f32> {
    return vec4<f32>(1.0, 1.0, 1.0, 1.0);
}

@vertex
fn vs_main(@location(0) pos: vec3<f32>) -> @builtin(position) vec4<f32> {
    const PI: f32 = 3.141592653589793;
    var scaleMatrix: mat4x4<f32> = mat4x4<f32>(
        1.0, 0.0, 0.0, 0.0,
        0.0, 0.5, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.25, 0.0, 0.0, 1.0
    );
    var rotateMatrix: mat4x4<f32> = mat4x4<f32>(
        cos(PI/4), sin(PI/4), 0.0, 0.0,
        -sin(PI/4), cos(PI/4), 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0
    );
    var homogeneousPos = vec4<f32>(pos, 1.0);
    return scaleMatrix * rotateMatrix * homogeneousPos;
}
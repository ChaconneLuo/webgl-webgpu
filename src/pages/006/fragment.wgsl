@fragment
fn main(@builtin(position) frag: vec4<f32>) -> @location(0) vec4<f32> {
    if frag.z > 0.5 {
        return vec4<f32>(1.0, 1.0, 1.0, 1.0);
    } else {
        return vec4<f32>(0.0, 1.0, 0.0, 1.0);
    }
}
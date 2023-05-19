@vertex
fn main(@location(0) pos: vec3<f32>) -> @builtin(position) vec4<f32> {
    var homogeneousPos = vec4<f32>(pos, 1.0);
    homogeneousPos.x -= 0.5;
    homogeneousPos.y -= 0.5;
    return homogeneousPos;
}
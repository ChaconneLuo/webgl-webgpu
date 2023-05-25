@group(0) @binding(0) var<uniform> scaleMatrix:mat4x4<f32>;
@group(0) @binding(1) var<uniform> rotateMatrix:mat4x4<f32>;
   
struct VertexOut {
    @builtin(position) position: vec4<f32>
}

@vertex
fn vs_main(@location(0) pos: vec3<f32>) -> VertexOut {
    var homogeneousPos = vec4<f32>(pos, 1.0);
    var vertexStruct: VertexOut;
    vertexStruct.position = scaleMatrix * rotateMatrix * homogeneousPos;
    return vertexStruct;
}

@fragment
fn fs_main(vertex: VertexOut) -> @location(0) vec4<f32> {
    if vertex.position.z > 0.5 {
        return vec4<f32>(1.0, 1.0, 1.0, 1.0);
    } else {
        return vec4<f32>(0.0, 1.0, 0.0, 1.0);
    }
}
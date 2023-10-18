struct VertexOutput {
    @location(0) uv: vec2<f32>,
    @builtin(position) position: vec4<f32>,
};

struct UniformParams {
    mvp: mat4x4<f32>,
    tint_color: vec3<f32>,
}

@group(0) @binding(0) var<uniform> params: UniformParams;
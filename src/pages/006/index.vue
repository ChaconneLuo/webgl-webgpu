<script setup lang="ts">
import shader from './shader.wgsl?raw';
if (!navigator.gpu) {
    console.log("WebGPU is not supported!");
} else {
    const init = async () => {
        const adapter = await navigator.gpu.requestAdapter();
        const device = await adapter!.requestDevice();

        const canvas = document.getElementById('webgpu') as HTMLCanvasElement;
        const context = canvas!.getContext('webgpu') as GPUCanvasContext;

        const format = navigator.gpu.getPreferredCanvasFormat();
        context!.configure({
            device: device,
            format: format
        })
        const vertexArray: Float32Array = new Float32Array([
            0.5, 0.5, 0.0,
            0.5, -0.5, 0.0,
            0.0, 0.0, 1.0,
            0.5, -0.5, 0.0,
            0.0, 0.0, 1.0,
            -0.5, -0.5, 0.0,
            -0.5, -0.5, 0.0,
            -0.5, 0.5, 0.0,
            0.0, 0.0, 1.0,
            -0.5, 0.5, 0.0,
            0.0, 0.0, 1.0,
            0.5, 0.5, 0.0,
        ]);

        const vertexBuffer: GPUBuffer = device.createBuffer({
            size: vertexArray.byteLength,
            usage: GPUBufferUsage.VERTEX | GPUBufferUsage.COPY_DST,
        });

        device.queue.writeBuffer(vertexBuffer, 0, vertexArray);

        const scaleArray: Float32Array = new Float32Array([
            1.0, 0.0, 0.0, 0.0,
            0.0, 1.0, 0.0, 0.0,
            0.0, 0.0, 1.0, 0.0,
            0.25, 0.0, 0.0, 1.0
        ])

        const scaleBuffer = device.createBuffer({
            size: scaleArray.byteLength,
            usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST
        });
        device.queue.writeBuffer(scaleBuffer, 0, scaleArray);

        const rotateArray: Float32Array = new Float32Array([
            Math.cos(Math.PI / 4), Math.sin(Math.PI / 4), 0.0, 0.0,
            -Math.sin(Math.PI / 4), Math.cos(Math.PI / 4), 0.0, 0.0,
            0.0, 0.0, 1.0, 0.0,
            0, 0, 0, 1.0
        ]);

        const rotateBuffer = device.createBuffer({
            size: rotateArray.byteLength,
            usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST
        });

        const pipeline: GPURenderPipeline = device.createRenderPipeline({
            vertex: {
                buffers: [
                    {
                        //间隔3个点，每个点4字节，每隔12字节取一个点
                        arrayStride: 12,
                        attributes: [{
                            shaderLocation: 0,
                            format: 'float32x3',
                            offset: 0
                        }]
                    }
                ],
                module: device.createShaderModule({
                    code: shader
                }),
                entryPoint: "vs_main",
            },
            fragment: {
                module: device.createShaderModule({
                    code: shader
                }),
                entryPoint: "fs_main",
                targets: [
                    {
                        format: format
                    }
                ]
            },
            primitive: {
                topology: 'triangle-list'
            },
            layout: 'auto'
        });
        const bindGroup = device.createBindGroup({
            layout: pipeline.getBindGroupLayout(0),
            entries: [
                {
                    binding: 0,
                    resource: {
                        buffer: scaleBuffer
                    }
                },
                {
                    binding: 1,
                    resource: {
                        buffer: rotateBuffer
                    }
                }
            ]
        })

        let angle: number = 0;

        const renderFrame = () => {
            angle += 0.01;
            const rotateArray: Float32Array = new Float32Array([
                Math.cos(angle), Math.sin(angle), 0.0, 0.0,
                -Math.sin(angle), Math.cos(angle), 0.0, 0.0,
                0.0, 0.0, 1.0, 0.0,
                0, 0, 0, 1.0
            ])
            device.queue.writeBuffer(rotateBuffer, 0, rotateArray);

            const commandEncoder: GPUCommandEncoder = device.createCommandEncoder();

            const renderPass: GPURenderPassEncoder = commandEncoder.beginRenderPass({
                colorAttachments: [{
                    view: context.getCurrentTexture().createView(),
                    storeOp: 'store',
                    loadOp: 'clear',
                    clearValue: { r: 0.5, g: 0.5, b: 0.5, a: 1.0 }
                }]
            })

            renderPass.setPipeline(pipeline);
            renderPass.setVertexBuffer(0, vertexBuffer);
            renderPass.setBindGroup(0, bindGroup);

            renderPass.draw(12);
            renderPass.end();

            const commandBuffer: GPUCommandBuffer = commandEncoder.finish();

            device.queue.submit([commandBuffer]);
        }

        const render = () => {
            renderFrame();
            requestAnimationFrame(render);
        }

        render();
    }
    init();
}
</script>

<template>
    <canvas id="webgpu" width="500" height="500"></canvas>
</template>

<style scoped></style>

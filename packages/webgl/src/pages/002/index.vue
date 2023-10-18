<script setup lang="ts">
import { onMounted, ref } from 'vue';

import { initWebGLContext } from '@src/utils/platform';
import vertexShader from './shader/vertex.glsl?raw';
import fragmentShader from './shader/fragment.glsl?raw';
import { createProgram } from '@src/utils/platform';

const canvasRef = ref<HTMLCanvasElement | null>(null);
const webGLContext = ref<WebGLRenderingContext | WebGL2RenderingContext | null>(null);
const webGLProgram = ref<WebGLProgram | null>(null);
onMounted(() => {
    const canvas = canvasRef.value;
    if (canvas) {
        webGLContext.value = initWebGLContext(canvas);
    }
    webGLProgram.value = createProgram(webGLContext.value!, vertexShader, fragmentShader);
    webGLContext.value!.useProgram(webGLProgram.value!);

    webGLContext.value!.clearColor(1.0, 1.0, 1.0, 1.0);

})
</script>

<template>
    <div class="w-125 h-125 flex flex-row justify-center flex-items-center">
        <canvas ref="canvasRef" width="500" height="500"></canvas>
    </div>
</template>
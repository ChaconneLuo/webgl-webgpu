<script setup lang="ts">
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
  }
  init();
}
</script>

<template>
  <canvas id="webgpu" width="500" height="500"></canvas>
</template>

<style scoped></style>

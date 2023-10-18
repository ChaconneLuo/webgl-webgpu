<script setup lang="ts">
const gpuSupport = navigator.gpu ? true : false;
</script>

<template>
  <div class="w-125 h-125 flex flex-row justify-center flex-items-center">
    <h3 v-if="gpuSupport">WebGPU Check:&nbsp;WebGPU is supported!</h3>
    <h1 v-else>WebGPU Check:&nbsp;WebGPU is not supported!</h1>
  </div>
</template>

<style scoped></style>

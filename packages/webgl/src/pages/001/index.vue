<script setup lang="ts">
import { WebGLSupport, WebGL2Support } from '@src/utils/platform';
</script>

<template>
  <div class="w-125 h-125 flex flex-row justify-center flex-items-center">
    <h3 v-if="WebGL2Support()">WebGL2 Check:&nbsp;WebGL2 is supported!</h3>
    <h3 v-else-if="WebGLSupport()">WebGL Check:&nbsp;WebGL is supported!</h3>
    <h1 v-else>WebGL Check:&nbsp;WebGL is not supported!</h1>
  </div>
</template>

<style scoped></style>

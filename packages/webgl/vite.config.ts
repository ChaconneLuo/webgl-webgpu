import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import Pages from 'vite-plugin-pages';
import UnoCSS from 'unocss/vite';
import path from "path";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    UnoCSS(),
    Pages()
  ],
  resolve: {
    alias: {
      "@src": path.resolve(__dirname, './src')
    }
  }
})

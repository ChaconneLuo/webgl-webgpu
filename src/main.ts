import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import { createRouter, createWebHistory } from 'vue-router';

import routes from '~pages';
import extraRoute from './router';

const router = createRouter({
    history: createWebHistory(),
    routes: [...extraRoute, ...routes],
})
createApp(App).use(router).mount('#app')

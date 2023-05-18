import { createRouter, createWebHashHistory } from "vue-router";

const router = createRouter({
    history: createWebHashHistory(),
    routes: [
        {
            path: '/',
            name: 'WebGPU',
            component: () => import('../App.vue'),
            children: [
                {
                    path: '/test',
                    name: 'init',
                    component: () => import('../components/Test/Test.vue')
                },
                {
                    path: '/test01',
                    name: 'vertex pipeline',
                    component: () => import('../components/Vertex/Vertex.vue')
                }
            ]
        }]
});
export default router;
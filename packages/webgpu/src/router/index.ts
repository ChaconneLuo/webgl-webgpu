import { RouteRecordRaw } from "vue-router"

const extraRoute: RouteRecordRaw[] = [
    {
        path: '/',
        name: 'Home',
        redirect: '/001'
    }
]

export default extraRoute;
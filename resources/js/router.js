import { createRouter, createWebHistory } from "vue-router";

import AppLayout from './Layouts/AppLayout.vue';
import FeedbackForm from './Components/Feedback/Form.vue';
import FeedbackList from './Components/Feedback/Index.vue';
import FeedbackView from './Components/Feedback/View.vue';
import Unauthorized from './Pages/Unauthorized.vue';
import Login from './Pages/Auth/Login.vue';
import Register from './Pages/Auth/Register.vue';

import store from './Store/index.js';


const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: '/login',
            component: Login,
            meta: {
                title: 'IKONIC | Login',
                name: 'login',
            },
        },
        {
            path: '/register',
            component: Register,
            meta: {
                title: 'IKONIC | Register',
                name: 'register',
            },
        },
        {
            path: '/',
            component: FeedbackForm,
            meta: {
                title: 'IKONIC | Submit Feedback',
                requiresAuth: true
            },
        },
        {
            path: '/feedback/create',
            component: FeedbackForm,
            meta: {
                title: 'IKONIC | Submit Feedback',
                requiresAuth: true
            },
        },
        {
            path: '/feedback',
            component: FeedbackList,
            meta: {
                title: 'IKONIC | Feedback List',
                requiresAuth: true
            },
        },
        {
            path: '/feedback/:id',
            component: FeedbackView,
            meta: {
                title: 'IKONIC | View Feedback & Comment',
                requiresAuth: true
            },
        },
        {
            path: '/unauthorized',
            component: Unauthorized,
            meta: {
                title: 'IKONIC | Unauthorized'
            },
        }
    ]
});

router.beforeEach(function (to, _, next) {
    if (to.meta.requiresAuth && !store.getters.isAuthenticated) {
        next('/login');
    } else if (to.meta.requiresUnAuth && store.getters.isAuthenticated) {
        next('/feedback/create');
    } else if ((to.meta.name === 'login' || to.meta.name === 'register') && store.getters.isAuthenticated) {
        next('/');
    } else {
        next();
    }
});

export default router;
import { createApp } from 'vue';
import router from './router';
import MainApp from './Layouts/AppLayout.vue';
import store from "./Store/index.js";
import ToastPlugin from 'vue-toast-notification';
import 'vue-toast-notification/dist/theme-bootstrap.css';


const app = createApp(MainApp).use(router);
app.use(store);

app.use(ToastPlugin, {
    position: 'top-right',
    duration: 5000,
    dismissible: true,
    pauseOnHover: true,
});

const metaTag = document.querySelector('meta[name="csrf-token"]');
app.config.globalProperties.$csrfToken = metaTag ? metaTag.getAttribute('content') : null;

app.config.globalProperties.$baseUrl = window.location.origin;

app.mount('#app');
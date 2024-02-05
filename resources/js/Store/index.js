import { createStore } from "vuex";
import authModule from './auth/index.js';
import feedbackModule from './feedback/index.js';
import createPersistedState from 'vuex-persistedstate';

const store = createStore({
    modules:{
        auth: authModule,
        feedback: feedbackModule,
    },
    plugins: [createPersistedState()],
});
export default store;
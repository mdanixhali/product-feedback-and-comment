import csrfToken from "./csrfToken";
import store from '../Store/index.js';
import router from '../router';

export default {
    async send(url, method, toast, body = null) {
        let headers = {
            'Content-Type': 'application/json',
        };

        if (url.match('login')) {
            const token = await csrfToken.refreshCSRFToken();
            headers['X-CSRF-Token'] = token;
        }else if(['POST', 'PUT', 'DELETE'].includes(method)){
            const metaTag = document.querySelector('meta[name="csrf-token"]');
            headers['X-CSRF-Token'] = metaTag ? metaTag.getAttribute('content') : null;
        }

        try {
            const response = await fetch(url, {
                method,
                headers,
                body: body ? JSON.stringify(body) : null,
            });
            const responseData = await response.json();
            if(responseData && responseData.message === "Unauthenticated."){
                store.commit('setUser', {
                    token: null,
                    user: null,
                });
                toast.default('Session expired. Login again to continue.');
                router.push('/login')
                return { success: false, sessionExpired: true};
            }
            if(method !== 'GET'){
                if(responseData.success){
                    toast.success(responseData.message);
                }else{
                    toast.error(responseData.message);
                }
            }
            return responseData;
        } catch (error) {
            console.error(error);
        }
    }
}

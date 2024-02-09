import csrfToken from "./csrfToken";

export default {
    async send(url, method, toast, body = null) {
        let headers = {
            'Content-Type': 'application/json',
        };
        if (['POST', 'PUT', 'DELETE'].includes(method)) {
            const token = await csrfToken.refreshCSRFToken();
            headers['X-CSRF-Token'] = token;
        }
        try {
            const response = await fetch(url, {
                method,
                headers,
                body: body ? JSON.stringify(body) : null,
            });
            const responseData = await response.json();
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

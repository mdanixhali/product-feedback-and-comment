import csrfToken from "./csrfToken";

export default {
    async send(url, method, toast, body = null) {
        const msg = 'Something went wrong. Please try again.';
        let headers = {
            'Content-Type': 'application/json',
        };
        if (['POST', 'PUT', 'DELETE'].includes(method)) {
            const token = await csrfToken.refreshCSRFToken();
            headers['X-CSRF-Token'] = token.csrfToken;
        }
        try {
            const response = await fetch(url, {
                method,
                headers,
                body: body ? JSON.stringify(body) : null,
            });
            const responseData = await response.json();
            if(method !== 'GET') toast.success(responseData.message || msg);
            return responseData;
        } catch (error) {
            toast.error(msg);
        }
    }
}

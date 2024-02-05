export default {
    t: null,
    async refreshCSRFToken() {
    const url = window.location.origin + '/api/refresh-csrf-token'
    const response = await fetch(url, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    });
    const responseData = await response.json();
    if (!response.ok) {
        this.$toast.success(responseData.message || 'Failed to generate token!');
    }
    var csrfMetaTag = document.querySelector('meta[name="csrf-token"]');
    if (csrfMetaTag) {
        csrfMetaTag.setAttribute('content', responseData.csrfToken);
    } else {
        console.error('CSRF token meta tag not found');
    }
    this.t = responseData.csrfToken;
  },
}
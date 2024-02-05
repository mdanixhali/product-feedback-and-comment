<template>
  <div class="container-fluid contact py-5 mt-10">
    <div class="row py-5 justify-content-center">
      <div class="col-lg-5 p-5 bg-light rounded">
        <div class="row g-4">
          <div class="col-12">
            <div class="text-center mx-auto" style="max-width: 700px;">
              <h1 class="text-primary">Login</h1>
              <p class="mb-4">Effortless access to your personalized world with a seamless login experience.</p>
            </div>
          </div>
          <form @submit.prevent="submitForm">

            <input v-model="email" type="email" class="w-100 form-control border-0 py-3 mb-4" placeholder="Your Email">
            <input v-model="password" type="password" class="w-100 form-control border-0 py-3 mb-4"
              placeholder="Your Password">
            <div class="col-12">
              <div class="form-check text-start mb-3">
                <input type="checkbox" class="form-check-input bg-primary border-0" id="remember" name="remember"
                  v-model="remember">
                <label class="form-check-label" for="remember">Remember Me</label>
              </div>
            </div>
            <button class="w-100 btn form-control border-secondary py-3 bg-white text-primary"
              type="submit">Login</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import csrfToken from '../../Common/csrfToken.js';
export default {
  data() {
    return {
      email: null,
      password: null,
      remember: false,
      formIsValid: true,
      url: this.$baseUrl + '/api/auth/login',
    }
  },
  methods: {
    async submitForm() {
      this.validateForm();
      if (!this.formIsValid) {
        this.$toast.error('A valid email address and/or password is missing.');
        return;
      }

      const response = await fetch(this.url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken.t,
        },
        body: JSON.stringify({
          email: this.email,
          password: this.password,
          remember: this.remember,
        })
      });
      try {
        const responseData = await response.json();

        if (!response.ok) {
          this.$toast.error(responseData.message);
          return;
        }

        this.$store.commit('setUser', {
          token: responseData.accessToken,
          user: responseData.user,
        });

        this.$toast.success('Sign in successfully.');
        this.$router.push('/feedback/create');
      } catch (error) {
        csrfToken.refreshCSRFToken();
        this.$toast.error('Something went wrong. Please check your credentials and try again.');
      }
    },
    validateForm() {
      this.formIsValid = true;
      if ((!this.email || !this.validateEmail()) || !this.password) {
        this.formIsValid = false;
      }
    },
    validateEmail() {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      return emailRegex.test(this.email);
    },
  },
  mounted() {
    csrfToken.refreshCSRFToken();
  }
}
</script>
<style scoped>
.mt-10 {
  margin-top: 5rem;
}
</style>
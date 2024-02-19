<template>
  <Preloader :loading="loading" />

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
import validation from '../../Common/validation.js';
import httpRequest from '../../Common/httpRequest.js';
import Preloader from '../../Common/Preloader.vue';
import csrfToken from "../../Common/csrfToken.js";
export default {
  components:{
      Preloader,
  },
  data() {
    return {
      email: null,
      password: null,
      remember: false,
      formIsValid: true,
      loading: false,
      url: this.$baseUrl + '/api/auth/login',
    }
  },
  methods: {
    async submitForm() {
      const validatedResult = validation.validate('login', {email: this.email, passowrd: this.password});
      if (typeof validatedResult === 'object') {
        this.$toast.error('A valid email address and/or password is missing.');
        return;
      }
      this.loading = true;
      const body = {
        email: this.email,
        password: this.password,
        remember: this.remember,
      };
      const responseData = await httpRequest.send(this.url, 'POST', this.$toast, body);
      if(responseData.success){
        this.$store.commit('setUser', {
          token: responseData.accessToken,
          user: responseData.user,
        });
        this.loading = false;
        csrfToken.refreshCSRFToken();
        this.$router.push('/feedback/create');
      }
      this.loading = false;
    },
    validateEmail() {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      return emailRegex.test(this.email);
    },
  },
}
</script>
<style scoped>
.mt-10 {
  margin-top: 5rem;
}
</style>
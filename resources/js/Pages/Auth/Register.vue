<template>
    <Preloader :loading="loading" />
    
    <div class="container-fluid contact py-5 mt-10">
        <div class="row py-5 justify-content-center">
            <div class="col-lg-5 p-5 bg-light rounded">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="text-center mx-auto" style="max-width: 700px;">
                            <h1 class="text-primary">Register yourself</h1>
                            <p class="mb-4">Streamline your experience with a quick and secure account registration process.
                            </p>
                        </div>
                    </div>
                    <form @submit.prevent="submitForm">
                        <input v-model="form.name" type="text" class="w-100 form-control border-0 py-3"
                            placeholder="Your Name">
                        <em class="text-danger" v-if="errors.name" v-html="errors.name"></em>

                        <input v-model="form.email" type="email" class="w-100 form-control border-0 py-3 mt-4"
                            placeholder="Enter Your Email">
                        <em class="text-danger" v-if="errors.email" v-html="errors.email"></em>

                        <input v-model="form.password" type="password" class="w-100 form-control border-0 py-3 mt-4"
                            placeholder="Your Password">
                        <em class="text-danger" v-if="errors.password" v-html="errors.password"></em>

                        <input v-model="form.password_confirmation" type="password"
                            class="w-100 form-control border-0 py-3 mt-4" placeholder="Comfirm Password">
                        <em class="text-danger" v-if="errors.password_confirmation"
                            v-html="errors.password_confirmation"></em>

                        <button class="w-100 btn form-control border-secondary py-3 bg-white text-primary mt-4"
                            type="submit">Register</button>
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
export default {
    components:{
        Preloader,
    },
    data() {
        return {
            form: {
                name: '',
                email: '',
                password: '',
                password_confirmation: '',
            },
            errors: {},
            url: this.$baseUrl + '/api/auth/register',
            loading: false,
        }
    },
    methods: {
        async submitForm() {
            const validatedResult = validation.validate('register', this.form);
            if (typeof validatedResult === 'object') {
                this.$toast.error('Please review the form and fix the errors before submitting.');
                this.errors = validatedResult;
                return;
            }
            this.loading = true;
            const responseData = await httpRequest.send(this.url, 'POST', this.$toast, this.form);
            if(responseData.sessionExpired) return;
            if (!responseData.success) {
                this.errors = responseData.errors;
                this.loading = false;
                return;
            }
            this.loading = false;
            this.$router.push('/login');
        },
        resetForm() {
            this.form = {
                name: '',
                email: '',
                password: '',
                password_confirmation: '',
            };
            this.errors = {};
        },
    },
}

</script>

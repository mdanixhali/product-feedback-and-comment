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
            formIsValid: true,
            errors: {},
            url: this.$baseUrl + '/api/auth/register',
            loading: false,
        }
    },
    methods: {
        async submitForm() {
            let msg = 'Please review the form and fix the errors before submitting.';
            this.validateForm();
            if (!this.formIsValid) {
                this.$toast.error(msg);
                return;
            }
            this.loading = true;
            const body = {
                name: this.form.name,
                email: this.form.email,
                password: this.form.password,
                password_confirmation: this.form.password_confirmation,
            };
            const responseData = await httpRequest.send(fullUrl, 'POST', this.$toast, body);
            if (!response.ok) {
                this.errors = responseData.errors;
                this.loading = false;
                return;
            }
            this.loading = false;
            this.$router.push('/login');
        },
        validateForm() {
            this.formIsValid = true;
            this.errors = {};
            if (!this.form.name) {
                this.formIsValid = false;
                this.errors.name = 'Name field is required';
            }
            if (!this.form.email || !this.validateEmail()) {
                this.formIsValid = false;
                this.errors.email = 'A valid email address is required';
            }
            if (!this.form.password || !this.validatePassword()) {
                this.formIsValid = false;
                this.errors.password = 'Invalid password. Must be 8-16 characters with at least one lowercase, one uppercase, and one numeric digit.';
            }
            if (this.form.password_confirmation !== this.form.password) {
                this.formIsValid = false;
                this.errors.password_confirmation = 'Please enter the same password again.';
            }
        },
        validateEmail() {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(this.form.email);
        },
        validatePassword() {
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,16}$/;
            return passwordRegex.test(this.form.password);
        },
        resetForm() {
            this.form = {
                name: '',
                email: '',
                password: '',
                password_confirmation: '',
            };
            this.formIsValid = true;
            this.errors = {};
        },
    },
}

</script>

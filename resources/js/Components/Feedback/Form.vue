<template>
    <div v-if="loading" id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>

    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">Product Feedback</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item active text-white">Submit Feedback</li>
        </ol>
    </div>
    <!-- Single Page Header End -->

    <!-- Contact Start -->
    <div class="container-fluid contact py-5">
        <div class="container py-5">
            <div class="p-5 bg-light rounded">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="text-center mx-auto" style="max-width: 700px;">
                            <h1 class="text-primary">Get in touch with feedback</h1>
                            <p class="mb-4">Share your thoughts – your feedback matters! Help us improve your shopping
                                experience by sharing your valuable insights on our products.</p>
                        </div>
                    </div>
                    <div class="col-lg-7">
                        <form @submit.prevent="submitForm">
                            <input type="text" v-model="form.title" class="w-100 form-control border-0 py-3"
                                placeholder="Title">
                            <em class="text-danger" v-if="errors.title" v-html="errors.title"></em>

                            <select v-model="form.category"
                                class="w-100 form-control form-select bg-white border-0 py-3 mt-4">
                                <option value="">Select Category</option>
                                <option value="Bug Report">Bug Report</option>
                                <option value="Feature Request">Feature Request</option>
                                <option value="Improvement">Improvement</option>
                            </select>
                            <em class="text-danger" v-if="errors.category" v-html="errors.category"></em>

                            <textarea v-model="form.description" class="w-100 form-control border-0 mt-4" rows="5" cols="10"
                                placeholder="Your Message"></textarea>
                            <em class="text-danger" v-if="errors.description" v-html="errors.description"></em>
                            <button class="w-100 btn form-control border-secondary py-3 bg-white text-primary mt-4"
                                type="submit">Submit</button>
                        </form>
                    </div>
                    <div class="col-lg-5">
                        <div class="d-flex p-4 rounded mb-4 bg-white">
                            <i class="fa fa-eye fa-2x text-primary me-4"></i>
                            <div>
                                <h4>Customer Insight</h4>
                                <p class="mb-2">Understanding Preferences</p>
                            </div>
                        </div>
                        <div class="d-flex p-4 rounded mb-4 bg-white">
                            <i class="fa fa-wrench fa-2x text-primary me-4"></i>
                            <div>
                                <h4>Quality Improvement</h4>
                                <p class="mb-2">Identifying Areas for Enhancement</p>
                            </div>
                        </div>
                        <div class="d-flex p-4 rounded bg-white">
                            <i class="fa fa-thumbs-up fa-2x text-primary me-4"></i>
                            <div>
                                <h4>Customer Engagement</h4>
                                <p class="mb-2">Building Trust</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Contact End -->
</template>
<script>
import csrfToken from '../../Common/csrfToken.js';
export default {
    data() {
        return {
            form: {
                category: '',
                title: null,
                description: null,
            },
            url: this.$baseUrl + '/api/feedback',
            formIsValid: true,
            errors: {},
            msg: 'Something went wrong. Please refresh the page and try again.',
            loading: false,
        }
    },
    methods: {
        async submitForm() {
            let msg = 'Please review the form and fix the errors before submitting.';
            this.errors = {};
            this.validateForm();
            if (!this.formIsValid) {
                this.$toast.error(msg);
                return;
            }
            this.loading = true;
            const response = await fetch(this.url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': csrfToken.t,
                },
                body: JSON.stringify(this.form)
            });
            try {
                const responseData = await response.json();

                if (!response.ok) {
                    this.$toast.error(responseData.message || this.msg);
                    this.errors = responseData.errors;
                    this.loading = false;
                    return;
                }
                this.$toast.success(responseData.message);
                this.loading = false;
                this.resetForm();
            } catch (error) {
                this.$toast.error(this.msg);
            }
        },
        validateForm() {
            this.formIsValid = true;
            if (!this.form.title || this.countWords(this.form.title) > 100) {
                this.formIsValid = false;
                this.errors.title = 'Title field is required (max. 100 characters).';
            }
            if (!this.form.description || this.countWords(this.form.description) > 500) {
                this.formIsValid = false;
                this.errors.description = 'The description field is required (max. 500 characters).';
            }
            if (!this.form.category) {
                this.formIsValid = false;
                this.errors.category = 'The category field is required.';
            }
        },
        countWords(text) {
            return text.length;
        },
        resetForm() {
            this.form = {
                category: '',
                title: null,
                description: null,
            };
            this.formIsValid = true;
            this.loading = false;
            this.errors = {};
        },   
    },
    mounted() {
        csrfToken.refreshCSRFToken();
    }
}
</script>
<template>
    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">401 Unauthorized</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><router-link to="/login">Login</router-link></li>
            <li class="breadcrumb-item active text-white">Unauthorized</li>
        </ol>
    </div>
    <!-- Single Page Header End -->

    <div class="container-fluid py-5">
        <div class="container py-5 text-center">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <i class="bi bi-exclamation-triangle display-1 text-secondary"></i>
                    <h1 class="display-1">401</h1>
                    <h1 class="mb-4">Unauthorized</h1>
                    <p class="mb-4">Oops! You're not authorized to access this page. Please login and try again.</p>
                    <router-link class="btn border-secondary rounded-pill py-3 px-5" to="/login">Go Back To Login</router-link>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {

        }
    }
}
</script>
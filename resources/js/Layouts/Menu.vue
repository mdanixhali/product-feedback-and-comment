<template>
    <!-- Navbar start -->
    <div class="container-fluid fixed-top shadow main-navigation">
        <div class="container topbar bg-primary d-none d-lg-block">
            <div class="d-flex justify-content-between">
                <div class="top-info ps-2">
                    <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a
                            href="javascript:void(0)" class="text-white">Miami, Florida</a></small>
                    <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="javascript:void(0)"
                            class="text-white">info@ikonicsolution.com</a></small>
                </div>
                <div class="top-link pe-2">
                    <a href="javascript:void(0)" class="text-white"><small class="text-white mx-2">Privacy
                            Policy</small>/</a>
                    <a href="javascript:void(0)" class="text-white"><small class="text-white mx-2">Terms of Use</small>/</a>
                    <a href="javascript:void(0)" class="text-white"><small class="text-white ms-2">Sales and
                            Refunds</small></a>
                </div>
            </div>
        </div>
        <div class="container px-0">
            <nav class="navbar navbar-light bg-white navbar-expand-xl">
                <a href="https://ikonicsolution.com/" class="navbar-brand" target="blank">
                    <h1 class="text-primary display-6">IKONIC</h1>
                </a>
                <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-primary"></span>
                </button>
                <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                    <div class="navbar-nav mx-auto" v-if="isAuthenticated">
                        <router-link to="/feedback/create" class="nav-item nav-link" :class="routePath === '/feedback/create' ? 'active' : ''">Submit Feedback</router-link>
                        <router-link to="/feedback" class="nav-item nav-link" :class="routePath === '/feedback' || pageName === 'view' ? 'active' : ''">Feedback</router-link>
                    </div>
                    <div class="nav-item dropdown" v-if="isAuthenticated">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">{{ name }}</a>
                        <div class="dropdown-menu m-0 bg-secondary rounded-0" @click="logout">
                            <a href="javascript:void(0)" class="dropdown-item">Logout</a>
                        </div>
                    </div>
                    <div class="d-flex m-3 me-0" :class="!isAuthenticated ? 'mx-auto' : null">
                        <router-link to="/register" class="nav-item nav-link" v-if="pageName === 'login'">Register</router-link>
                        <router-link to="/login" class="nav-item nav-link" v-if="pageName === 'register'">Login</router-link>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->
</template>
<script>
export default {
    computed: {
        name() {
            return this.$store.getters.isAuthenticated ? this.$store.getters.user.name : null;
        },
        isAuthenticated() {
            return this.$store.getters.isAuthenticated;
        },
        pageName() {
            return this.$route.meta.name;
        },
        routePath(){
            return this.$route.path;
        }
    },
    data() {
        return {
            url: this.$baseUrl + '/api/auth/logout',
        }
    },
    methods: {
        async logout() {
            const response = await fetch(this.url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
            });
            const responseData = await response.json();

            if (!response.ok) {
                this.$toast.info('Something went wrong. Please try again.');
            }

            this.$store.commit('setUser', {
                token: null,
                user: null,
            });

            this.$toast.default('Sign out successfully.');
            this.$router.push('/login');
        }
    }
}
</script>
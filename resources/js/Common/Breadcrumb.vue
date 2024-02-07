<template>
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">{{ breadcrumb.title }}</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item" :class="row.active ? 'active' : ''" v-for="(row, index) in breadcrumb.navigation"
                :key="index">
                <router-link :class="row.active ? 'text-white' : ''" :to="row.route">{{ row.title }}</router-link>
            </li>
        </ol>
    </div>
</template>
<script>
export default {
    props: ['title'],
    data() {
        return {
            breadcrumb: {
                navigation: [],
                title: null,
            },
            breadcrumbData: {
                navigation: [
                    {
                        title: 'Submit Feedback',
                        route: '/feedback/create',
                        active: false,
                    },
                    {
                        title: 'Feedback',
                        route: '/feedback',
                        active: false,
                    },
                    {
                        title: 'View Feedback',
                        route: '',
                        active: true,
                    },
                ]
            }
        }
    },
    methods: {
        generateBreadcrumb(currentComponent) {

            let breadcrumbTrail = [];
            let foundCurrentComponent = false;

            for (const crumb of this.breadcrumbData.navigation) {
                if (crumb.title === currentComponent) {
                    crumb.active = true;
                    foundCurrentComponent = true;
                } else {
                    crumb.active = false;
                }

                breadcrumbTrail.push({
                    title: crumb.title,
                    route: crumb.route,
                    active: crumb.active
                });

                if (foundCurrentComponent) {
                    break;
                }
            }
            this.breadcrumb.navigation = breadcrumbTrail;
            this.breadcrumb.title = this.title;
        }
    },
    created(){
        this.generateBreadcrumb(this.title);
    }
}
</script>
<template>
    <div v-if="loading" id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>

    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">Product Feedback</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><router-link to="/feedback/create">Home</router-link></li>
            <li class="breadcrumb-item active text-white">Feedback</li>
        </ol>
    </div>
    <!-- Single Page Header End -->


    <div class="container-fluid contact py-5">
        <div class="container">
            <div class="p-5 bg-light rounded">
                <div v-if="feedbacks.length">
                    <div class="d-flex" v-for="(feedback, index) in feedbacks" :key="index">
                        <img :src="avatarLink" class="img-fluid rounded-circle p-3" style="width: 100px; height: 100px;"
                            alt="">
                        <div class="w-100 mt-2">
                            <p class="mb-2" style="font-size: 14px;">{{ feedback.created_at }}</p>
                            <div class="d-flex justify-content-between">
                                <h5>{{ feedback.user.name }}</h5>
                                <p>{{ feedback.category }}</p>
                            </div>
                            <div class="d-flex">
                                <h5>{{ feedback.title }}</h5>
                            </div>
                            <p class="m-0">{{ feedback.description }}</p>
                            <div class="d-flex font-sm">
                                <p class="border-bottom mr-1"><a class="pointer" data-toggle="modal"
                                        @click="hideShowModal(true, feedback.id)">Delete</a></p>
                                <p class="border-bottom mr-1"><a class="pointer" @click="viewFeedback(feedback)">Comments</a></p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-center" v-if="!loading && !feedbacks.length">
                    <h2>No feedback added yet!</h2>
                </div>
                <div class="d-flex justify-content-center" v-if="loading">
                    <h2>Loading...</h2>
                </div>
            </div>
        </div>
        <div class="col-12" v-if="!loading">
            <div class="pagination d-flex justify-content-center mt-5">
                <a class="rounded pointer" @click="changePage(1)" :class="{ 'disabled': currentPage === 1 }">&laquo;</a>
                <a class="rounded pointer" v-for="page in totalPages" :key="page" @click="changePage(page)"
                    :class="{ 'active': currentPage === page }">{{ page }}</a>
                <a class="rounded pointer" @click="changePage(totalPages)"
                    :class="{ 'disabled': currentPage === totalPages }">&raquo;</a>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="deleteFeedback" tabindex="-1" role="dialog" aria-labelledby="deleteFeedbackLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Confirmation</h5>
                    <button class="btn btn-md rounded-circle bg-light border" @click="hideShowModal(false)">
                        <i class="fa fa-times text-danger"></i>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this feedback? If so, this action will also remove associated comments.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" @click="hideShowModal(false)">Close</button>
                    <button type="button" class="btn btn-danger" @click="deleteFeedback">Delete</button>
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
            feedbacks: [],
            url: this.$baseUrl + '/api/feedback',
            loading: false,
            currentPage: 1,
            totalRecords: 1,
            perPage: 10,
            feedbackId: null,
            msg: 'Something went wrong. Please refresh the page and try again.',
        }
    },
    computed: {
        avatarLink() {
            return this.$baseUrl + '/img/avatar.jpg';
        },
        totalPages() {
            return Math.ceil(this.totalRecords / this.perPage);
        },
    },
    methods: {
        async getFeedbacks() {
            this.loading = true;
            let fullUrl = this.url + '?page=' + this.currentPage;
            const response = await fetch(fullUrl, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                },
            });
            try {
                const responseData = await response.json();
                this.feedbacks = responseData.data;
                this.currentPage = responseData.current_page;
                this.totalRecords = responseData.total;
                this.loading = false;
            } catch (error) {
                this.loading = false;
                this.$toast.error(this.msg);
            }
        },
        changePage(page) {
            if(this.currentPage == page) return;
            this.currentPage = page;
            this.getFeedbacks();
        },
        async deleteFeedback() {
            this.loading = true;
            let fullUrl = this.url + '/' + this.feedbackId;
            const response = await fetch(fullUrl, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': csrfToken.t,
                },
            });
            try {
                const responseData = await response.json();
                this.$toast.success(responseData.message || this.msg);
                this.removeFeedbackById(this.feedbackId);
                this.currentPage = 1;
                this.getFeedbacks();
            } catch (error) {
                this.loading = false;
                this.$toast.error(this.msg);
            }
            $('#deleteFeedback').modal('hide');
        },
        removeFeedbackById(feedbackId) {
            const indexToRemove = this.feedbacks.findIndex(feedback => feedback.id === feedbackId);
            if (indexToRemove !== -1) {
                this.feedbacks.splice(indexToRemove, 1);
            }
        },
        viewFeedback(feedback) {
            this.$store.commit('setFeedback', {feedback});
            this.$router.push('/feedback/' + feedback.id)
        },
        hideShowModal(i, id = null) {
            if (i) {
                this.feedbackId = id;
                $('#deleteFeedback').modal('show');

                const bodyElement = document.body;
                if (bodyElement.classList.contains('modal-open')) {
                    bodyElement.style.overflow = '';
                    bodyElement.style.paddingRight = '';
                    bodyElement.style.overflowY = 'scroll';
                }
                const navigationElement = document.querySelector('.main-navigation');
                if (navigationElement) {
                    navigationElement.style.paddingRight = '';
                }
            }
            else $('#deleteFeedback').modal('hide');
        }
    },
    created() {
        this.getFeedbacks();
    },
    mounted() {
        csrfToken.refreshCSRFToken();
    }
}
</script>
<style scoped>
.font-sm {
    font-size: 0.75rem;
}

.mr-1 {
    margin-right: 1rem;
}

.pointer {
    cursor: pointer;
}
</style>
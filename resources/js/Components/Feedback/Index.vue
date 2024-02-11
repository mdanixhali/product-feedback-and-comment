<template>
    <Preloader :loading="loading" />
    <Breadcrumb :title="'Feedback'" />
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
    <ConfirmationModal 
        v-if="shouldShowModal" 
        :shouldShowModal="shouldShowModal" 
        @hideShowModal="hideShowModal" 
        @deleteFeedback="deleteFeedback" 
    />
</template>
<script>
import httpRequest from '../../Common/httpRequest.js';
import Preloader from '../../Common/Preloader.vue';
import Breadcrumb from '../../Common/Breadcrumb.vue';
import ConfirmationModal from '../../Common/ConfirmationModal.vue';
export default {
    components:{
        Preloader,
        Breadcrumb,
        ConfirmationModal,
    },
    data() {
        return {
            feedbacks: [],
            url: this.$baseUrl + '/api/feedback',
            loading: false,
            currentPage: 1,
            totalRecords: 1,
            perPage: 10,
            feedbackId: null,
            shouldShowModal: false,
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
            const responseData = await httpRequest.send(fullUrl, 'GET', this.$toast);
            if(responseData.sessionExpired) return;
            this.feedbacks = responseData.data;
            this.currentPage = responseData.current_page;
            this.totalRecords = responseData.total;
            this.loading = false;
        },
        changePage(page) {
            if(this.currentPage == page) return;
            this.currentPage = page;
            this.getFeedbacks();
        },
        async deleteFeedback() {
            this.loading = true;
            let fullUrl = this.url + '/' + this.feedbackId;
            await httpRequest.send(fullUrl, 'DELETE', this.$toast);
            this.removeFeedbackById(this.feedbackId);
            this.currentPage = 1;
            this.getFeedbacks();
            $('#deleteFeedback').modal('hide');
            this.shouldShowModal = false;
            this.feedbackId = null;
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
            this.shouldShowModal = i;
            this.feedbackId = id;
        }
    },
    created() {
        this.getFeedbacks();
    },
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
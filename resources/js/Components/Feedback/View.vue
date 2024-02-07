<template>
    <Preloader :loading="loading" />
    <Breadcrumb :title="'View Feedback'" />

    <!-- Contact Start -->
    <div class="container-fluid contact py-5">
        <div class="container">
            <div class="bg-light rounded p-5 pb-3" ref="mainInputAreaRef">
                <div class="d-flex" v-if="feedback">
                    <img :src="avatarLink" class="img-fluid rounded-circle p-3" style="width: 100px; height: 100px;" alt="">
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
                            <p class="border-bottom mr-1"><a class="pointer" @click="hideShowModal(true)">Delete</a></p>
                            <p class="border-bottom mr-1"><a class="pointer" @click="getComments">Comments</a></p>
                            <p class="border-bottom"><a class="pointer" @click="hideShowInput(true)">Add Comment</a></p>
                        </div>

                        <div class="container px-4">
                            <div class="d-flex overflow-hidden">
                                <img :src="avatarLink" class="rounded-circle mr-1" style="width: 50px; height: 50px;" alt=""
                                    v-if="shouldAddComment" />
                                <fieldset ref="commentEditorRef" @input="handleInput" v-if="shouldAddComment"
                                    placeholder="Your Comment" class="form-control mr-1" id="commentEditor"
                                    contenteditable="true" @keydown="handleKeyDown">
                                    Your Comment...
                                </fieldset>
                                <div class="user-list" v-if="showMentionList">
                                    <div class="user-item p-2" v-for="user in mentionList" :key="user.id"
                                        @click="mentionUser(user)">
                                        <img :src="avatarLink" style="width: 40px; height: 40px;" class="rounded-circle" />
                                        <span>{{ user.name }}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="font-sm mr-2 text-end mt-1" v-if="shouldAddComment">
                                <button class="btn border-secondary bg-white text-primary me-1" type="button"
                                    @click="hideShowInput(false)">Cancel</button>
                                <button class="btn btn-primary border-secondary text-white text-primary" type="button"
                                    @click="addComment">Submit</button>
                            </div>
                        </div>

                        <div class="container px-4 mb-4 mt-3" :class="comments.length ? 'comment-scrollable' : ''"
                            v-if="shouldShowComments">
                            <div v-if="feedback && comments.length">
                                <div class="d-flex" v-for="(comment, index) in comments" :key="index">
                                    <img :src="avatarLink" class="img-fluid rounded-circle p-3"
                                        style="width: 80px; height: 80px;" alt="">
                                    <div class="">
                                        <p class="mb-2" style="font-size: 12px;" v-if="comment && comment.created_at">{{
                                            comment.created_at }}</p>
                                        <div class="d-flex justify-content-between" v-if="comment && comment.user">
                                            <b>{{ comment.user.name }}</b>
                                        </div>
                                        <p class="f13px m-0" v-if="comment && comment.comment" v-html="comment.comment"></p>
                                        <div class="d-flex font-sm">
                                            <p class="border-bottom mr-1"><a class="pointer"
                                                    @click="editComment(comment, index)">Edit</a></p>
                                            <p class="border-bottom"><a class="pointer"
                                                    @click="deleteComment(comment.id, index)">Delete</a></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-center" v-else>
                                <h5>No comments added yet!</h5>
                            </div>
                        </div>
                    </div>
                </div>
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
    emits: ['deleteFeedback', 'hideShowModal'],
    components:{
        Preloader,
        Breadcrumb,
        ConfirmationModal,
    },
    data() {
        return {
            url: this.$baseUrl + '/api/comment/' + this.$route.params.id,
            feedback: {},
            comments: [],
            comment: null,
            loading: false,
            shouldShowComments: false,
            shouldAddComment: false,
            shouldLoadUsers: false,
            user: this.$store.getters.user,
            showMentionList: false,
            mentionList: [],
            updateData: null,
            typingTimer: null,
            doneTypingInterval: 500,
            shouldShowModal: false,
        }
    },
    methods: {
        async getComments() {
            this.loading = true;
            this.commments = [];
            const responseData = await httpRequest.send(this.url, 'GET', this.$toast);
            this.comments = responseData;
            this.loading = false;
        },
        hideShowInput(i) {
            this.shouldAddComment = i;
        },
        async addComment() {
            this.loading = true;
            let url = this.$baseUrl + '/api/comment';
            let method = 'POST';
            if (this.updateData && this.updateData.isUpdate) {
                url += `/${this.updateData.commentId}`;
                method = 'PUT';
            }
            const body = {
                comment: this.$refs.commentEditorRef.innerHTML,
                feedback_id: this.feedback.id,
            };
            const responseData = await httpRequest.send(url, method, this.$toast, body);
            this.loading = false;
            this.shouldShowComments = true;
            this.$refs.commentEditorRef.innerHTML = 'Your comment...';
            this.updateComments(responseData.comment);
            this.updateData = null;
        },
        updateComments(comment) {
            comment.user = {
                id: this.user.id,
                name: this.user.name,
            };
            if (this.updateData && this.updateData.isUpdate) {
                this.comments[this.updateData.index] = comment;
                return;
            }
            this.comments.unshift(comment);
        },
        handleKeyDown(event) {
            if (event.ctrlKey && event.shiftKey && event.key.toLowerCase() === 'k') {
                event.preventDefault();

                var htmlObject = document.createElement('code');
                let selectedContent = window.getSelection().toString();
                htmlObject.innerHTML = selectedContent.replace(/</g, '&lt;').replace(/>/g, '&gt;');

                var sel, range;
                if (window.getSelection) {
                    sel = window.getSelection();
                    if (sel.rangeCount) {
                        range = sel.getRangeAt(0);
                        range.deleteContents();
                        range.insertNode(htmlObject);
                    }
                } else if (document.selection && document.selection.createRange) {
                    range = document.selection.createRange();
                    range.insertNode(htmlObject);
                }
            }
        },
        handleInput() {
            let fieldsetValue = this.$refs.commentEditorRef.textContent.trim();
            const lastWord = fieldsetValue.split(' ').pop();
            if (lastWord.startsWith('@')) {
                clearTimeout(this.typingTimer);
                this.typingTimer = setTimeout(() => {
                    this.filterUsers(lastWord.slice(1));
                }, this.doneTypingInterval);
            } else {
                this.showMentionList = false;
            }
        },
        async filterUsers(word) {
            if(!word) return;
            this.loading = true;
            let url = this.$baseUrl + '/api/user?keyword=' + word;
            const responseData = await httpRequest.send(url, 'GET', this.$toast);
            this.showMentionList = true;
            this.loading = false;
            this.mentionList = responseData;
        },
        mentionUser(user) {
            this.$nextTick(() => {
                let fieldsetValue = this.$refs.commentEditorRef.innerText.trim();
                const tempElement = document.createElement('span');
                tempElement.style.color = '#0663C1';
                tempElement.style.fontWeight = 'bold';
                tempElement.innerHTML = user.name;

                this.$refs.commentEditorRef.innerText = fieldsetValue.replace(/@([^\s]*)/g, '');
                this.$refs.commentEditorRef.appendChild(tempElement);
                this.showMentionList = false;
            });
        },
        async deleteComment(id, index) {
            this.loading = true;
            let url = this.$baseUrl + '/api/comment/' + id;
            const body = {
                comment_id: id,
            };
            await httpRequest.send(url, 'DELETE', this.$toast, body);
            this.loading = false;
            this.comment = null;
            this.shouldShowComments = true;
            this.comments.splice(index, 1);
        },
        editComment(comment, index) {
            this.$nextTick(() => {
                this.shouldAddComment = true;
                setTimeout(() => {
                    this.$refs.commentEditorRef.innerHTML = comment.comment;
                }, 300);
            });
            this.updateData = { commentId: comment.id, isUpdate: true, index: index };
            const targetDiv = this.$refs.mainInputAreaRef;
            targetDiv.scrollIntoView({
                behavior: "smooth",
                block: "start",
            });
        },
        async deleteFeedback() {
            this.loading = true;
            let url = this.$baseUrl + '/api/feedback/' + this.feedback.id;
            await httpRequest.send(url, 'DELETE', this.$toast);
            $('#deleteFeedback').modal('hide');
            this.$router.push('/feedback');
        },
        hideShowModal(i) {
            this.shouldShowModal = i;
        }
    },
    computed: {
        avatarLink() {
            return this.$baseUrl + '/img/avatar.jpg'
        }
    },
    created() {
        this.feedback = this.$store.getters.feedback;
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

.f13px {
    font-size: 13px;
}

.comment-input {
    height: 3rem;
}

.comment-scrollable {
    max-height: 400px;
    overflow-y: scroll;
}

.mr-2 {
    margin-right: 1rem;
}

.user-list {
    position: absolute;
    z-index: 1;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    max-height: 150px;
    overflow-y: auto;
    width: 40%;
    margin-top: 3.1rem;
    margin-left: 4.3rem;
}

.user-item {
    cursor: pointer;
    display: flex;
    align-items: center;
}

.user-item:hover {
    background-color: #f1f1f1;
}

.user-item img {
    width: 75px;
    height: 75px;
    border-radius: 50%;
    margin-right: 10px;
}

.loader {
    border: 4px solid #f3f3f3;
    border-top: 4px solid #3498db;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    animation: spin 1s linear infinite;
    display: none;
}

.pointer {
    cursor: pointer;
}

fieldset {
    width: 790px;
}

fieldset .mention-user {
    color: red !important;
}</style>
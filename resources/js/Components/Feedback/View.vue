<template>
    <div v-if="loading" id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>

    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">View Feedback</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><router-link to="/feedback/create">Home</router-link></li>
            <li class="breadcrumb-item"><router-link to="/feedback">Feedback</router-link></li>
            <li class="breadcrumb-item active text-white">View</li>
        </ol>
    </div>
    <!-- Single Page Header End -->


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
            msg: 'Something went wrong. Please refresh the page and try again.',
            typingTimer: null,
            doneTypingInterval: 500,
        }
    },
    methods: {
        async getComments() {
            this.loading = true;
            this.shouldShowComments = false;
            this.commments = [];
            const response = await fetch(this.url, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                },
            });
            try {
                const responseData = await response.json();
                this.comments = responseData;
                this.loading = false;
                this.shouldShowComments = true;
            } catch (error) {
                this.loading = false;
                this.$toast.error(this.msg);
            }
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
            const response = await fetch(url, {
                method: method,
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': csrfToken.t,
                },
                body: JSON.stringify({
                    comment: this.$refs.commentEditorRef.innerHTML,
                    feedback_id: this.feedback.id,
                }),
            });
            try {
                const responseData = await response.json();
                this.loading = false;
                this.$toast.success(responseData.message || this.msg);
                this.shouldShowComments = true;
                this.$refs.commentEditorRef.innerHTML = 'Your comment...';
                this.updateComments(responseData.comment);
            } catch (error) {
                this.loading = false;
                this.$toast.error(msg);
            }
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
            const response = await fetch(url, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                },
            });
            try {
                const responseData = await response.json();
                this.showMentionList = true;
                this.loading = false;
                this.mentionList = responseData;
            } catch (error) {
                this.loading = false;
                this.$toast.error(msg);
            }
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
            const response = await fetch(url, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': csrfToken.t,
                },
                body: JSON.stringify({
                    comment_id: id,
                }),
            });
            try {
                const responseData = await response.json();
                this.loading = false;
                this.$toast.success(responseData.message || this.msg);
                this.comment = null;
                this.shouldShowComments = true;
                this.comments.splice(index, 1);
            } catch (error) {
                this.loading = false;
                this.$toast.error(msg);
            }
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
            let fullUrl = this.$baseUrl + '/api/feedback/' + this.feedback.id;
            let msg = 'Something went wrong. Please try again.';
            const response = await fetch(fullUrl, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': csrfToken.t,
                },
            });
            try {
                const responseData = await response.json();
                this.$toast.success(responseData.message);
                $('#deleteFeedback').modal('hide');
                this.$router.push('/feedback');
            } catch (error) {
                this.loading = false;
                this.$toast.error(msg);
            }
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
    computed: {
        avatarLink() {
            return this.$baseUrl + '/img/avatar.jpg'
        }
    },
    created() {
        this.feedback = this.$store.getters.feedback;
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
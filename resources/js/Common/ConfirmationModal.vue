<template>
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
                    <button type="button" class="btn btn-danger" @click="emitDeleteFeddback">Delete</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: ['shouldShowModal'],
    emits: ['hideShowModal', 'deleteFeedback'],
    data() {
        return {

        }
    },
    methods: {
        hideShowModal(i) {
            if(!i){
                $('#deleteFeedback').modal('hide');
                this.$emit('hideShowModal', i);
                return;
            }
            if (this.shouldShowModal) {
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
        },
        emitDeleteFeddback(){
            this.$emit('deleteFeedback');
        }
    },
    mounted(){
        this.hideShowModal(this.shouldShowModal);
    }
}
</script>
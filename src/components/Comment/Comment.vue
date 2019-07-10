<template>
    <div class="cmt-container">
        <div class="cmt-content">
            <div class="cmt-content-wrapper">
                <el-timeline style="padding:30px 40px">
                    <el-timeline-item
                        :timestamp="item.commentDate | getTime(item.commentUserId) "
                        placement="top"
                        v-for="(item,i) in commentList"
                        :key="i"
                    >
                        <el-card>
                            <span>{{item.commentContent}}</span>
                        </el-card>
                    </el-timeline-item>
                </el-timeline>
                <div v-if="!commentList" style="text-align:center; color:#f25d8e; padding:30px 0; font-size:18px">
                    <span>这本书暂时还没有买家评论……</span>
                </div>
            </div>
        </div>
    </div>
</template>


<script>
export default {
    data() {
        return {
            commentList: []
        };
    },
    created() {
        this.getAllComment();
    },
    methods: {
        getAllComment() {
            this.$axios
                .post("/comment/getAllCommentByBid", {
                    commentBookId: this.$route.query.bookId
                })
                .then(resp => {
                    // console.log(resp.data.data);
                    this.commentList = resp.data.data;
                });
        }
    },
    filters: {
        getTime(t, uid) {
            var _time = new Date(t);
            var year = _time.getFullYear();
            var month = _time.getMonth() + 1;
            var date = _time.getDate();
            var hour = _time.getHours();
            var minute = _time.getMinutes();
            var second = _time.getSeconds();
            return (
                year +
                "年" +
                month +
                "月" +
                date +
                "日   " +
                hour +
                ":" +
                minute +
                ":" +
                second +
                "-------" +
                "评论用户:" +
                uid
            );
        }
    }
};
</script>


<style lang="less" scoped>
.cmt-container {
    .cmt-content {
        margin: 0 auto;
        width: 1160px;
        background-color: #fff;
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;
    }
}
</style>

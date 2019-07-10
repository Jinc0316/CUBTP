<template>
    <div class="book-info-container">
        <!-- <nav-header></nav-header> -->
        <div class="book-info-content">
            <div class="bread">
                <el-breadcrumb separator-class="el-icon-arrow-right">
                    <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item>书籍列表</el-breadcrumb-item>
                    <el-breadcrumb-item>书籍详情</el-breadcrumb-item>
                    <el-breadcrumb-item>{{bookInfo.bookName}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>

            <div class="book-detail-info-wrapper">
                <div class="book-detail-img" :style="imgUrl"></div>

                <div class="book-detail-content">
                    <div class="book-title">《{{bookInfo.bookName}}》</div>
                    <div class="book-desc-list">
                        <div class="book-desc-1">
                            <div class="book-author book-detail-item">
                                <span>作者：</span>
                                {{bookInfo.bookAuthor}}
                            </div>
                            <div class="book-press book-detail-item">
                                <span>出版社：</span>
                                {{bookInfo.bookPress}}
                            </div>
                            <div class="book-type book-detail-item">
                                <span>书籍类型：</span>
                                {{bookInfo.bookType}}
                            </div>
                            <div class="book-subject book-detail-item">
                                <span>书籍学科：</span>
                                {{bookInfo.bookSubject}}
                            </div>
                        </div>
                        <div class="book-desc-2">
                            <div class="book-seller book-detail-item">
                                <span>卖家：</span>
                                {{bookInfo.bookSellerId}}
                            </div>
                            <div class="book-degree book-detail-item">
                                <span>书籍成色：</span>
                                {{bookInfo.bookDegree}}
                            </div>
                            <div class="book-num book-detail-item">
                                <span>所剩数量：</span>
                                {{bookInfo.bookNum != 0 ? bookInfo.bookNum : "已售完，待补货"}}
                            </div>
                            <div class="book-upload-date book-detail-item">
                                <span>上传时间：</span>
                                {{bookInfo.bookUploadDate | getTime}}
                            </div>
                        </div>
                    </div>
                    <div class="book-desc-item">
                        <span>书籍描述：</span>
                        {{bookInfo.bookDesc}}
                    </div>
                    <div class="choose-num">
                        <span>选择数量：</span>
                        <el-input-number
                            v-model="buyNum"
                            :min="bookInfo.bookNum != 0 ? 1 : 0"
                            :max="bookInfo.bookNum"
                            size="medium"
                        ></el-input-number>
                    </div>
                    <div class="book-buy">
                        <el-button type="danger" class="buy-btn" @click="buy(bookInfo.bookSellerId)">购买</el-button>
                    </div>
                </div>
            </div>
        </div>
        <div class="book-info-cmt">
            <div class="cmt-list-header">
                <h3>该书籍的所有评论</h3>
            </div>
            <comment-box></comment-box>
        </div>
    </div>
</template>


<script>
// import Header from "./Header/Header";
import Comment from "../Comment/Comment";
import { mapState, mapGetters, mapActions } from "vuex";

export default {
    data() {
        return {
            // bookId: null,
            bookInfo: {},
            imgUrl: {},
            buyNum: 1
        };
    },
    created() {
        this.getBookInfo();
    },

    methods: {
        ...mapActions("order", [
            //order是指modules文件夹下的user.js
            "setBookInfo", //order.js文件中的actions里的方法.
            "setBuyNum"
        ]),
        ...mapGetters("user", ["getUserInfo"]),

        getBookInfo() {
            // this.bookId = this.$route.query.bookId;
            this.$axios
                .get("/book/getBookInfo?bookId=" + this.$route.query.bookId)
                .then(resp => {
                    console.log(resp.data.data);

                    this.bookInfo = resp.data.data;
                    this.imgUrl = {
                        backgroundImage:
                            "url(" +
                            require("@/assets/images/book_cover_img/" +
                                this.bookInfo.bookCover) +
                            ")"
                    };
                    if (this.bookInfo.bookNum == 0) {
                        this.buyNum = 0;
                    }
                });
        },
        buy(bookSellerId) {
            if (this.buyNum == 0) {
                this.$alert("该书籍已售罄，无法购买", "提示", {
                    confirmButtonText: "确定",
                    callback: () => {}
                });
            }else if (this.getUserInfo().userId ===bookSellerId) {
                this.$alert("您不能购买自己上传的书籍", "提示", {
                    confirmButtonText: "确定",
                    callback: () => {}
                });
            } else {
                this.setBookInfo(this.bookInfo);
                this.setBuyNum(this.buyNum);
                this.$router.push({
                    name: "ConfirmOrder"
                });
            }
        }
    },
    components: {
        // "nav-header": Header,
        "comment-box": Comment
    },
    filters: {
        getTime(t) {
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
                second
            );
        }
    }
};
</script>

<style lang="less" scoped>
.book-info-container {
    .book-info-content {
        background-color: #fff;
        // box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2);
        .bread {
            padding-top: 20px;
            width: 1160px;
            margin: 0 auto;
        }
        .book-detail-info-wrapper {
            margin-top: 30px !important;
            // padding-top: 50px;
            background: #fff;
            width: 1160px;
            margin: 0 auto;
            display: -ms-flexbox;
            display: flex;
            .book-detail-img {
                margin-right: 40px;
                width: 300px;
                height: 400px;
                background-repeat: no-repeat;
                background-size: 100% 100%;
                box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.5),
                    0 4px 8px 0 rgba(0, 0, 0, 0.4);
                border-radius: 4px;
            }
            .book-detail-content {
                width: 820px;
                font-size: 16px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                .book-title {
                    font-size: 2rem;
                    padding-bottom: 15px;
                    border-bottom: 1px dashed #ccc;
                }
                .book-desc-list {
                    width: 60%;
                    display: flex;
                    justify-content: space-between;
                    margin-bottom: 15px;

                    .book-detail-item {
                        line-height: 40px;
                        white-space: nowrap;
                        width: 20em;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        span {
                            margin-right: 10px;
                            color: rgb(126, 123, 123);
                        }
                    }
                }
                .book-desc-item {
                    line-height: 40px;
                    border-top: 1px dashed #ccc;
                    margin-bottom: 15px;
                    span {
                        color: #f25d8e;
                    }
                }
                .choose-num {
                    border-top: 1px dashed #ccc;
                    padding-top: 15px;
                    span {
                        color: #f25d8e;
                    }
                }
                .book-buy {
                    padding-top: 35px;
                    padding-left: 83px;
                    padding-bottom: 50px;
                    .buy-btn {
                        width: 250px;
                        height: 50px;
                        background-image: linear-gradient(
                            -48deg,
                            #ff6a9c,
                            #fe8574
                        );
                    }
                }
            }
        }
    }

    .book-info-cmt {
        margin-top: 30px;

        .cmt-list-header {
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            width: 1120px;
            padding: 10px 20px;
            margin: 0 auto;
            background-color: #fff;
            color: rgb(187, 72, 135);
        }
    }
}
</style>


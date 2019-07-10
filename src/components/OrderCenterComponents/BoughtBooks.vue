<template>
    <div class="boughtBooks-container">
        <div class="boughtBooks-content">
            <div class="orderCenter-content-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>商品</th>
                            <!---->
                            <th>单价</th>
                            <th>数量</th>
                            <!---->

                            <th>交易状态</th>
                            <th>交易金额</th>
                            <th>订单日期</th>
                            <th>交易操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="item in orderInfo" :key="item.orderId">
                            <td>
                                <div class="order-content">
                                    <div class="content-left">
                                        <img
                                            :src="require('../../assets/images/book_cover_img/'+item.book.bookCover)"
                                            width="86"
                                            height="114"
                                        >
                                    </div>
                                    <div class="content-right">
                                        <p>{{item.book.bookName}}</p>
                                        <p>{{item.book.bookAuthor}}</p>
                                        <p class="order-book-name">
                                            <span title="7788">{{item.book.bookPress}}</span>
                                        </p>
                                        <!---->
                                        <div class="book-degree">
                                            <span>{{item.book.bookDegree}}</span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <!---->
                            <td>
                                <div>￥{{item.book.bookPrice}}</div>
                            </td>
                            <td>
                                <div>{{item.orderNum}}</div>
                            </td>
                            <td>
                                <div>{{item.orderStatus == "未完成" ? item.orderStatus +"("+ ( item.orderSendStatus=="未发货" ? item.orderSendStatus : item.orderReceiveStatus) +")": item.orderStatus}}</div>
                            </td>

                            <!---->
                            <td class="total">
                                <p>￥{{item.orderPrice}}</p>
                            </td>
                            <td>
                                <div>{{item.orderDate | getTime}}</div>
                            </td>
                            <td>
                                <div>
                                    <span
                                        v-if="item.orderStatus != '未完成'"
                                        @click="deleteOrder(item.orderId)"
                                    >删除订单记录</span>
                                    <span v-else @click="cancelOrder(item)">取消订单</span>
                                </div>
                                <div
                                    v-show="item.orderStatus == '未完成' && item.orderReceiveStatus == '待收货' "
                                    @click="confirmOrder(item)"
                                >确认收货</div>
                                <el-button
                                    type="text"
                                    size="mini"
                                    @click="commentOrder(item.book.bookId)"
                                    v-show="item.orderStatus == '已完成' "
                                >评论</el-button>
                            </td>
                        </tr>
                        <!---->
                    </tbody>
                </table>
                <div
                    v-if="!orderInfo"
                    style="text-align:center; color:#f25d8e; padding:30px 0; font-size:18px"
                >
                    <span>您的订单中心空空如也，快去购买几本书籍吧！！</span>
                </div>
            </div>
        </div>

        <!-- 评论弹窗 -->
        <!-- 评论弹窗 -->
        <!-- 评论弹窗 -->

        <el-dialog title="评论" :visible.sync="dialogVisible" width="40%">
            <div class="comment-content" style="margin:-20px 0" v-if="commentList.length !=0">
                <div style="text-align:center;font-size:12px">
                    <span>以往评论</span>
                </div>
                <el-timeline class="comment-content-wrapper">
                    <el-timeline-item
                        :timestamp="item.commentDate | getDate"
                        placement="top"
                        v-for="(item,i) in commentList"
                        :key="i"
                    >
                        <el-card>
                            <span>{{item.commentContent}}</span>
                        </el-card>
                    </el-timeline-item>
                </el-timeline>
            </div>
            <div v-else style="text-align:center;font-size:12px;color:#f25d8e;">
                <span>您还未对该书进行评论……！</span>
            </div>

            <div class="border" style="border-top:1px solid #ccc;margin:15px 0;"></div>
            <el-input
                type="textarea"
                :autosize="{ minRows: 3, maxRows: 4}"
                placeholder="请输入内容"
                v-model="commentContent"
                resize="none"
                max="120"
                style="margin-top:5px"
            ></el-input>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="addComment">提 交</el-button>
            </span>
        </el-dialog>
        <!---->
        <!---->
        <!---->
    </div>
</template>

<script>
import { mapState, mapGetters, mapActions } from "vuex";
export default {
    inject: ["reload"],
    data() {
        return {
            dialogVisible: false,
            orderInfo: [],
            orderStatus: "",
            commentList: [],
            commentContent: "",
            bookId: 0
        };
    },
    created() {
        this.getOrderList();
    },
    methods: {
        ...mapGetters("user", ["getUserInfo"]),

        //获取所有订单
        getOrderList() {
            this.$axios
                .get(
                    "/order/getOrderByuserId?userId=" +
                        this.getUserInfo().userId
                )
                .then(resp => {
                    // console.log(resp.data.data);
                    this.orderInfo = resp.data.data;
                });
        },
        //删除订单记录
        deleteOrder(orderId) {
            console.log("删除订单");

            this.$confirm("确定删除该订单记录吗?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning"
            })
                .then(() => {
                    this.$axios
                        .get("/order/deleteOrder?orderId=" + orderId)
                        .then(resp => {
                            if (resp.data.msg == "success") {
                                this.$message({
                                    type: "success",
                                    message: "删除成功!"
                                });

                                this.reload();
                            } else {
                                this.$message.error("删除失败！");
                            }
                        });
                })
                .catch(() => {
                    this.$message({
                        type: "info",
                        message: "已取消删除"
                    });
                });
        },

        //取消订单
        cancelOrder(item) {
            console.log("取消订单");

            if (item.orderSendStatus == "未发货") {
                this.$confirm("确定取消该订单？", "提示", {
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    type: "warning"
                })
                    .then(() => {
                        let params = item;
                        params.orderStatus = "已取消";
                        this.$axios
                            .post("/order/cancelOrder", params)
                            .then(resp => {
                                if (resp.data.msg == "success") {
                                    this.$message({
                                        type: "success",
                                        message: "取消订单成功!"
                                    });

                                    this.reload();
                                } else {
                                    this.$message.error("取消订单失败！");
                                }
                            });
                    })
                    .catch(() => {
                        this.$message({
                            type: "info",
                            message: "已取消该操作!"
                        });
                    });
            } else {
                this.$alert("该书籍商家已发货，无法取消", "提示", {
                    confirmButtonText: "确定",
                    callback: () => {}
                });
            }
        },

        //确认收货
        confirmOrder(item) {
            console.log("确认收货");

            if (item.orderSendStatus === "未发货") {
                this.$message.error("商家未发货，无法确认收货！");
            } else {
                this.$confirm("确定收货后无法更改，是否继续？", "提示", {
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    type: "warning"
                })
                    .then(() => {
                        let params = item;
                        params.orderStatus = "已完成";
                        params.orderReceiveStatus = "已收货";

                        this.$axios
                            .post("/order/confirmOrder", params)
                            .then(resp => {
                                if (resp.data.msg == "success") {
                                    this.$message({
                                        type: "success",
                                        message: "确认收货成功!"
                                    });

                                    this.reload();
                                } else {
                                    this.$message.error("确认收货失败！");
                                }
                            });
                    })
                    .catch(() => {
                        this.$message({
                            type: "info",
                            message: "已取消该操作"
                        });
                    });
            }
        },

        //渲染评论
        commentOrder(bookId) {
            this.dialogVisible = true;
            this.bookId = bookId;
            let params = {
                commentUserId: this.getUserInfo().userId,
                commentBookId: this.bookId
            };
            console.log(params);

            this.$axios
                .post("/comment/getAllCommentByUidAndBid", params)
                .then(resp => {
                    console.log(resp.data.data);
                    if (resp.data.data != null) {
                        this.commentList = resp.data.data;
                    } else {
                        this.commentList = [];
                    }
                });
        },
        //添加评论
        addComment() {
            let params = {
                commentUserId: this.getUserInfo().userId,
                commentBookId: this.bookId,
                commentContent: this.commentContent,
                commentDate: new Date()
            };

            if (
                params.commentContent !== "" &&
                params.commentContent.length <= 140
            ) {
                this.$axios.post("/comment/addComment", params).then(resp => {
                    console.log(resp.data.msg);
                    if (resp.data.msg === "success") {
                        this.$message({
                            type: "success",
                            message: "评论成功！"
                        });
                        this.commentContent = "";
                        this.commentList.unshift(params);
                    } else {
                        this.$message.error("评论失败");
                    }
                });
            } else {
                this.$message.error("评论内容不能为空且不超过140个字符");
            }
        }
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
        },
        getDate(t) {
            var _time = new Date(t);
            var year = _time.getFullYear();
            var month = _time.getMonth() + 1;
            var date = _time.getDate();
            var hour = _time.getHours();
            var minute = _time.getMinutes();
            var second = _time.getSeconds();
            return (
                year +
                "-" +
                month +
                "-" +
                date +
                "    " +
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
.boughtBooks-container {
    .boughtBooks-content {
        margin-top: 20px;
        .orderCenter-content-wrapper {
            table {
                width: 100%;
                border-spacing: 0;
                border-collapse: collapse;
                thead {
                    tr:first-child {
                        background: #f4f5f7;
                    }
                    tr {
                        th {
                            border: 1px solid #f4f5f7;
                            padding: 15px 0;
                            line-height: 24px;
                            font-size: 14px;
                            font-weight: 400;
                            color: #6d757a;
                        }

                        th:first-child {
                            width: 406px;
                        }
                        th:nth-child(2) {
                            width: 107px;
                        }
                        th:nth-child(3) {
                            width: 80px;
                        }
                        th:nth-child(4) {
                            width: 137px;
                        }
                        th:nth-child(5) {
                            width: 107px;
                        }
                        th:last-child {
                            width: 115px;
                        }
                    }
                }

                tbody {
                    text-align: center;
                    tr {
                        td {
                            border: 1px solid #f1f1f1;
                            padding: 15px 0;
                        }

                        td:first-child {
                            padding-left: 15px;
                            text-align: left;
                            .order-content {
                                display: flex;
                                justify-content: flex-start;
                                .content-right {
                                    margin-left: 35px;
                                }
                            }
                        }

                        // td:nth-child(2) {
                        //     // text-align: left;
                        //     // width: 290px;
                        // }

                        // td:nth-child(3) {
                        //     // text-align: right;
                        //     // width: 115px;
                        // }

                        td:last-child {
                            div {
                                margin-bottom: 5px;
                            }

                            div:first-child {
                                color: rgb(255, 0, 0);
                                cursor: pointer;
                            }
                            div:nth-child(2) {
                                color: rgb(21, 207, 77);
                                cursor: pointer;
                            }
                            div:last-child {
                                color: rgb(26, 82, 204);
                                cursor: pointer;
                            }
                        }
                    }
                }
            }
        }
    }
}
</style>

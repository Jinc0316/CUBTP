<template>
    <div class="soldBooks-container">
        <div class="soldBooks-content">
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
                        <th>购买用户&nbsp;|&nbsp;收货地址</th>
                        <th>交易操作</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="item in soldOrderList" :key="item.orderId">
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
                        <td><div>{{item.orderUserId}}</div><hr style="border-color:#f1f1f1;border-width:0 0 1px 0"><div>{{item.orderAddress}}</div></td>
                        <td>
                            <div v-if=" item.orderStatus != '已取消'">
                                <span
                                    v-if="item.orderSendStatus == '未发货'"
                                    @click="sendOutGoods(item)"
                                >发货</span>
                                <span v-else @click="cancelSendOutGoods(item)">取消发货</span>
                            </div>
                            <div v-show="item.orderStatus == '未完成'" @click="refund(item)">退款</div>
                            <div
                                v-if="item.orderStatus != '未完成'"
                                class="deleteRecord"
                            >交易已结束</div>
                        </td>
                    </tr>
                    <!---->
                </tbody>
            </table>
            <div
                v-if="!soldOrderList"
                style="text-align:center; color:#f25d8e; padding:30px 0; font-size:18px"
            >
                <span>您的书籍暂时无人问津，请耐心等待吧！！</span>
            </div>
        </div>
    </div>
</template>

<script>
import { mapState, mapGetters, mapActions } from "vuex";
export default {
    inject: ["reload"],
    data() {
        return {
            soldOrderList: []
        };
    },
    created() {
        this.getSoldOrderList();
    },
    methods: {
        ...mapGetters("user", ["getUserInfo"]),
        getSoldOrderList() {
            this.$axios
                .get(
                    "/order/getSoldOrderByUserId?userId=" +
                        this.getUserInfo().userId
                )
                .then(resp => {
                    console.log(resp.data.data);
                    this.soldOrderList = resp.data.data;
                });
        },
        //发货
        sendOutGoods(item) {
            console.log("发货");

            this.$confirm("确定发货吗？", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning"
            })
                .then(() => {
                    let params = item;
                    params.orderSendStatus = "已发货";
                    this.$axios
                        .post("/order/confirmOrder", params)
                        .then(resp => {
                            if (resp.data.msg == "success") {
                                this.$message({
                                    type: "success",
                                    message: "发货成功"
                                });

                                this.reload();
                            } else {
                                this.$message.error("发货失败！");
                            }
                        });
                })
                .catch(() => {
                    this.$message({
                        type: "info",
                        message: "已取消该操作!"
                    });
                });
        },
        //取消发货
        cancelSendOutGoods(item) {
            this.$confirm("确定取消发货吗？", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning"
            })
                .then(() => {
                    let params = item;
                    params.orderSendStatus = "未发货";
                    this.$axios
                        .post("/order/confirmOrder", params)
                        .then(resp => {
                            if (resp.data.msg == "success") {
                                this.$message({
                                    type: "success",
                                    message: "取消发货成功"
                                });

                                this.reload();
                            } else {
                                this.$message.error("取消发货失败！");
                            }
                        });
                })
                .catch(() => {
                    this.$message({
                        type: "info",
                        message: "已取消该操作!"
                    });
                });
        },
        //退款
        refund(item) {
            console.log("退款");

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
                                        message: "退款成功"
                                    });

                                    this.reload();
                                } else {
                                    this.$message.error("退款失败！");
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
                this.$alert("您已发货，请先取消发货，再退款", "提示", {
                    confirmButtonText: "确定",
                    callback: () => {}
                });
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
.soldBooks-container {
    .soldBooks-content {
        margin-top: 20px;
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
                        width: 306px;
                    }
                    th:nth-child(2) {
                        width: 107px;
                    }
                    th:nth-child(3) {
                        width: 80px;
                    }
                    th:nth-child(4) {
                        width: 107px;
                    }
                    th:nth-child(5) {
                        width: 107px;
                    }
                    th:nth-child(6) {
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
                        .deleteRecord {
                            color: rgb(21, 207, 77) !important;
                            cursor: pointer;
                        }
                        div:first-child {
                            color: rgb(255, 0, 0);
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
</style>
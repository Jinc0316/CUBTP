<template>
    <div class="order-container">
        <div class="order-wrapper">
            <h1>订单信息</h1>

            <div class="order-info">
                <table>
                    <tbody>
                        <tr>
                            <th>商品</th>
                            <!---->
                            <th>单价</th>
                            <th>数量</th>
                            <!---->
                            <th>合计</th>
                        </tr>
                        <tr>
                            <td>
                                <div class="order-content">
                                    <div class="content-left">
                                        <img :src="imgUrl" width="100%" height="100%">
                                    </div>
                                    <div class="content-right">
                                        <h1>{{bookInfo.bookName}}</h1>
                                        <p>{{bookInfo.bookPress}}</p>
                                        <p class="order-book-name">
                                            <span
                                                :title="bookInfo.bookAuthor"
                                            >{{bookInfo.bookAuthor}}</span>
                                        </p>
                                        <!---->
                                        <div class="book-degree">
                                            <span class="ticket">{{bookInfo.bookDegree}}</span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <!---->
                            <td>
                                <div>￥{{bookInfo.bookPrice}}</div>
                            </td>
                            <td>
                                <div>{{buyNum}}</div>
                            </td>
                            <!---->
                            <td class="total">
                                <p>￥{{bookInfo.bookPrice * buyNum}}</p>
                                <!-- <p>(不含运费)</p> -->
                            </td>
                        </tr>
                        <!---->
                    </tbody>
                </table>
            </div>

            <div class="order-address">
                <h1>
                    收货地址
                    <span>（必填）</span>
                </h1>
                <div class="addressinfo-container">
                    <el-form ref="form" :model="addres" label-width="100px">
                        <el-form-item label="收货人姓名">
                            <el-input v-model="addres.name" style="width:500px" placeholder="请输入姓名"></el-input>
                        </el-form-item>
                        <el-form-item label="手机号码">
                            <el-input
                                v-model="addres.tel"
                                style="width:500px"
                                placeholder="请输入手机号码"
                            ></el-input>
                        </el-form-item>
                        <el-form-item label="收货地址">
                            <el-input
                                v-model="addres.building"
                                style="width:500px"
                                placeholder="例如(28-702)"
                            ></el-input>
                        </el-form-item>

                        <el-form-item label="备注">
                            <el-input
                                type="textarea"
                                v-model="addres.remarks"
                                style="width:500px;"
                                maxlength="120"
                                placeholder="不能超出120个字"
                                :rows="6"
                                resize="none"
                            ></el-input>
                        </el-form-item>
                    </el-form>
                </div>
            </div>
            <div class="order-amount">
                <div class="total-container">
                    <div>
                        商品总额
                        <span>￥{{bookInfo.bookPrice * buyNum}}</span>
                    </div>
                    <!---->
                    <!---->
                    <!---->
                    <!---->
                    <div>
                        运费
                        <span>快递到付</span>
                    </div>
                    <!---->
                    <div>
                        应付金额
                        <span class="amount">￥{{bookInfo.bookPrice * buyNum}}</span>
                    </div>
                </div>
            </div>

            <div class="order-pay">
                <div class="confirm-bottom">
                    <div class="confirm-paybtn">
                        <el-button
                            type="primary"
                            @click="orderSubmit"
                            style="width:200px;height:50px;background-image: linear-gradient(-48deg, #ff6a9c, #fe8574) ;border:none;font-size:1.5em"
                        >支&nbsp;&nbsp;&nbsp;&nbsp;付</el-button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>


<script>
import { mapState, mapGetters, mapActions } from "vuex";
export default {
    data() {
        return {
            bookInfo: {},
            imgUrl: "",
            buyNum: 0,
            addres: {
                name: "",
                tel: "",
                building: "",
                remarks: ""
            }
        };
    },
    created() {
        this.getOrderInfo();
    },
    methods: {
        ...mapGetters("order", [
            //order是指modules文件夹下的user.js
            "getBookInfo", //order.js文件中的actions里的方法.
            "getBuyNum"
        ]),
        ...mapGetters("user", ["getUserInfo"]),

        getOrderInfo() {
            this.bookInfo = this.getBookInfo();
            this.buyNum = this.getBuyNum();
            this.imgUrl = require("@/assets/images/book_cover_img/" + this.bookInfo.bookCover);
        },
        orderSubmit() {
            let params = {
                orderUserId: this.getUserInfo().userId,
                orderBookId: this.bookInfo.bookId,
                orderPrice: this.bookInfo.bookPrice * this.buyNum,
                orderNum: this.buyNum,
                orderAddress: this.addres.building,
                orderUserName: this.addres.name,
                orderUserTel: this.addres.tel,
                orderUserRemark: this.addres.remarks,
                orderSendStatus: "未发货",
                orderReceiveStatus: "待收货",
                orderStatus: "未完成",
                orderDate: ""
            };

            this.$axios.post("/order/addOrder", params).then(resp => {
                if (resp.data.msg === "fail") {
                    this.$message.error("购买失败！");
                }

                this.$message({
                    type: "success",
                    message: "购买成功！"
                });
                //两秒后跳转到订单中心
                setTimeout(() => {
                    this.$router.push({
                        name: "OrderCenter"
                    });
                }, 2000);
            });
        }
    }
};
</script>

<style lang="less" scoped>
.order-container {
    .order-wrapper {
        width: 1160px;
        background-color: #fff;
        margin: 0 auto;
        margin-top: 40px;
        padding: 40px;

        .order-info {
            margin-bottom: 20px;
            border-bottom: 1px dashed #e7e7e7;

            table {
                width: 100%;
                border-collapse: collapse;
                border-spacing: 0;

                .order-content {
                    .content-left {
                        float: left;
                        width: 86px;
                        height: 114px;
                        margin: 5px 0;
                    }
                    .content-right {
                        padding: 5px 5px 5px 96px;
                        h1 {
                            max-height: 40px;
                            margin-top: 0;
                            margin-bottom: 15px;
                            font-weight: 400;
                            overflow: hidden;
                            line-height: 20px;
                            font-size: 14px;
                            color: #222;
                        }
                        p {
                            font-size: 12px;
                            color: #6d757a;
                        }
                    }
                }

                tr {
                    display: -ms-flexbox;
                    display: flex;
                    display: -webkit-flex;
                    -ms-flex-pack: justify;
                    justify-content: space-between;
                    width: 100%;
                    padding-right: 15px;
                    font-size: 12px;
                    color: #222;
                    box-sizing: border-box;
                }
                tr:first-child {
                    background: #f4f5f7;
                }

                th {
                    padding: 15px 0;
                    line-height: 24px;
                    font-size: 14px;
                    font-weight: 400;
                    color: #6d757a;
                }

                th:first-child {
                    width: 310px;
                }
                th:nth-child(2) {
                    text-align: left;
                    width: 290px;
                }
                th:nth-child(3) {
                    text-align: right;
                    width: 115px;
                }
                th:last-child {
                    text-align: right;
                    width: 115px;
                }

                td {
                    padding: 15px 0;
                }

                td:first-child {
                    padding-left: 15px;
                    text-align: left;
                    width: 295px;
                }

                td:nth-child(2) {
                    text-align: left;
                    width: 290px;
                }

                td:nth-child(3) {
                    text-align: right;
                    width: 115px;
                }

                td:last-child {
                    text-align: right;
                    width: 115px;
                    p {
                        margin: 0;
                    }
                }

                td.total {
                    font-size: 16px;
                    color: #fb7299;
                }
            }
        }

        .order-amount {
            .total-container {
                margin-top: 30px;
                background: #f4f5f7;
                padding: 20px 15px 5px;

                div {
                    text-align: right;
                    margin-bottom: 15px;
                    font-size: 14px;
                    line-height: 16px;
                    color: #6d757a;

                    span {
                        float: right;
                        min-width: 130px;
                        color: #222;
                        &.amount {
                            line-height: 22px;
                            font-size: 22px;
                            color: #ff66a2;
                        }
                    }
                }
            }
        }

        .order-pay {
            .confirm-bottom {
                margin-top: 25px;
                margin-bottom: 50px;
                display: flex;
                justify-content: flex-end;
                .confirm-paybtn {
                    width: 200px;
                }
            }
        }
    }
}
</style>


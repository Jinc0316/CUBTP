<template>
    <div class="notCheckedBook-container">
        <div class="notCheckedBook-content">
            <table>
                <thead>
                    <tr>
                        <th>商品</th>
                        <!---->
                        <th>单价&nbsp;&nbsp;|&nbsp;&nbsp;数量</th>

                        <!---->

                        <th>类型&nbsp;&nbsp;|&nbsp;&nbsp;科目</th>
                        <th>描述</th>
                        <th>上传用户</th>
                        <th>上传日期</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="item in unCheckedBookList" :key="item.orderId">
                        <td>
                            <div class="order-content">
                                <div class="content-left">
                                    <img
                                        :src="require('../../assets/images/book_cover_img/'+item.bookCover)"
                                        width="86"
                                        height="114"
                                    >
                                </div>
                                <div class="content-right">
                                    <p>{{item.bookName}}</p>
                                    <p>{{item.bookAuthor}}</p>
                                    <p class="order-book-name">
                                        <span title="7788">{{item.bookPress}}</span>
                                    </p>
                                    <!---->
                                    <div class="book-degree">
                                        <span>{{item.bookDegree}}</span>
                                    </div>
                                </div>
                            </div>
                        </td>

                        <td>
                            <div>
                                <span style="color:red">￥{{item.bookPrice}}&nbsp;&nbsp;</span> /
                                <span style="color:blue">&nbsp;&nbsp;{{item.bookNum}}</span>
                            </div>
                        </td>
                        <td>
                            <div>{{item.bookType}}&nbsp;&nbsp;/&nbsp;&nbsp;{{item.bookSubject}}</div>
                        </td>
                        <td>
                            <div>{{item.bookDesc}}</div>
                        </td>

                        <td>
                            <p style="color:red">{{item.bookSellerId}}</p>
                        </td>
                        <td>
                            <div>{{item.bookUploadDate | getTime}}</div>
                        </td>
                        <td>
                            <div @click="passCheck(item)">通过</div>
                            <div @click="inputReason(item)">不通过</div>
                        </td>
                    </tr>
                    <!---->
                </tbody>
            </table>
            <div class="noDataShow" v-if="unCheckedBookList == null">
                <div>暂时没有需要审核的书籍!!!</div>
                <img src="../../assets/images/default_img/404.jpg" alt="nothing">
            </div>
        </div>
        <!-- 对话框 -->
        <!-- 对话框 -->
        <!-- 对话框 -->
        <el-dialog
            title="编辑理由"
            :visible.sync="dialogVisible"
            width="30%"
            :before-close="handleClose"
        >
            <el-input
                type="textarea"
                :rows="4"
                placeholder="请输入内容"
                v-model="reasonContent"
                resize="none"
                style="margin:-20px 0"
            ></el-input>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="unPassCheck">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
export default {
    inject: ["reload2"],
    data() {
        return {
            unCheckedBookList: null,
            dialogVisible: false,
            temp: {},
            reasonContent: ""
        };
    },
    created() {
        this.getUnCheckedBookList();
    },
    methods: {
        handleClose(done) {
            this.$confirm("确认关闭？")
                .then(_ => {
                    done();
                })
                .catch(_ => {});
        },
        getUnCheckedBookList() {
            this.$axios.get("/book/getAllNotcheckedBook").then(resp => {
                console.log(resp.data.data);
                this.unCheckedBookList = resp.data.data;
            });
        },
        //审核通过
        passCheck(item) {
            let params = item;
            params.bookStatus = 1;
            this.$axios.post("/book/updateBookInfo", params).then(resp => {
                console.log(resp.data.msg);
                if (resp.data.msg == "fail") {
                    this.$message.error("操作失败！请重试");
                }
                this.reload2();
            });
        },
        //审核不通过
        unPassCheck() {
            let params = this.temp;
            params.bookStatus = 2;
            params.bookNotes = this.reasonContent;
            this.$axios.post("/book/updateBookInfo", params).then(resp => {
                console.log(resp.data.msg);
                if (resp.data.msg == "fail") {
                    this.$message.error("操作失败！请重试");
                } else {
                    this.$message({
                        message: "操作成功！",
                        type: "success"
                    });
                }
                this.dialogVisible = false;
                this.reload2();
            });
        },
        //输入不通过理由
        inputReason(item) {
            this.dialogVisible = true;
            this.temp = item;
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
        }
    }
};
</script>


<style lang="less" scoped>
.notCheckedBook-container {
    .notCheckedBook-content {
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
                        width: 120px;
                    }
                    th:nth-child(3) {
                        width: 120px;
                    }
                    th:nth-child(4) {
                        width: 137px;
                    }
                    th:nth-child(5) {
                        width: 130px;
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
                            margin-bottom: 15px;
                        }

                        div:first-child {
                            color: rgb(26, 82, 204);
                            cursor: pointer;
                        }
                        div:last-child {
                            color: rgb(255, 0, 0);
                            cursor: pointer;
                        }
                    }
                }
            }
        }

        .noDataShow {
            position: relative;
            div {
                position: absolute;
                color: rgb(207, 53, 53);
                font-size: 2rem;
                top: 30px;
                left: 33.7%;
            }
        }
    }
}
</style>
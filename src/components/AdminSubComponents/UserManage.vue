<template>
    <div class="userManage-container">
        <div class="userManage-content">
            <table>
                <thead>
                    <tr>
                        <th>用户头像</th>
                        <!---->
                        <th>用户名</th>

                        <!---->

                        <th>用户电话</th>
                        <th>用户邮箱</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="item in userList" :key="item.userId">
                        <td>
                            <div class="user-headImg">
                                <div class="content-left">
                                    <img
                                        :src="require('../../assets/images/user_head_img/'+item.userHeadImg)"
                                        width="50"
                                        height="50"
                                        style="border-radius: 50%"
                                    >
                                </div>
                            </div>
                        </td>

                        <td>
                            <div>
                                <span>{{item.userId}}</span>
                                
                            </div>
                        </td>
                        <td>
                            <div>{{item.userTel}}</div>
                        </td>
                        <td>
                            <div>{{item.userEmail}}</div>
                        </td>
                        <td>
                            <div @click="deleteUser(item.userId)">删除用户</div>
                        </td>
                    </tr>
                    <!---->
                </tbody>
            </table>
            <div class="noDataShow" v-if="userList.length == 0">
                <div>w(ﾟДﾟ)w&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本平台居然一个用户都没有，不可饶恕！！！</div>
                <img src="../../assets/images/default_img/404.jpg" alt="nothing">
            </div>
        </div>
    </div>
</template>

<script>
export default {
    inject: ["reload"],
    data() {
        return {
            userList:[]
        }
    },
    created() {
        this.getUserList();
    },
    methods: {
        getUserList() {
            this.$axios.get("/user/getAllUser").then(resp=>{
                console.log(resp.data.data);
                if (resp.data.data) {
                    this.userList = resp.data.data;
                } else {
                    this.userList = [];
                }
            })
        },
        deleteUser(userId) {
            console.log(userId);
            
            this.$confirm("确定删除该用户？", "提示", {
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    type: "warning"
                })
                    .then(() => {
                        
                        this.$axios
                            .get("/user/deleteUser?userId="+userId)
                            .then(resp => {
                                if (resp.data.msg == "success") {
                                    this.$message({
                                        type: "success",
                                        message: "删除用户成功!"
                                    });

                                    this.reload();
                                } else {
                                    this.$message.error("删除用户失败！");
                                }
                            });
                    })
                    .catch(() => {
                        this.$message({
                            type: "info",
                            message: "已取消该操作!"
                        });
                    });
        }
    }
};
</script>


<style lang="less" scoped>

.userManage-container {
    .userManage-content {
        margin-top: 20px;
        min-height: 450px;
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
                        width: 142px;
                    }
                    th:nth-child(2) {
                        width: 262px;
                    }
                    th:nth-child(3) {
                        width: 262px;
                    }
                    th:nth-child(4) {
                        width: 262px;
                    }
                    th:last-child {
                        width: 232px;
                    }
                }
            }

            tbody {
                text-align: center;
                tr {
                    border: 1px solid #f1f1f1;
                    td {
                        // border: 1px solid #f1f1f1;
                        padding: 15px 0;
                    }

                    // td:first-child {
                    //     padding-left: 15px;
                    //     text-align: left;
                    //     .order-content {
                    //         display: flex;
                    //         justify-content: flex-start;
                    //         .content-right {
                    //             margin-left: 35px;
                    //         }
                    //     }
                    // }

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
                left: 20%;
            }
        }
    }
}
</style>
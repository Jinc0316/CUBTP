<template>
    <div class="userInfo-container">
        <!-- 面包屑 -->
        <div class="user-info-bread">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
                <el-breadcrumb-item>个人信息</el-breadcrumb-item>
                <el-breadcrumb-item>{{userInfo.userId}}</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="userInfo-wrap">
            <!-- 头像 -->
            <div class="user-head-img">
                <div class="user-head-img-wrap">
                    <div class="img" :style="headImgUrl"></div>
                    <div class="change-img">
                        <el-button type="text" size="mini" @click="changeImgEmit">修改头像>>></el-button>
                    </div>
                    <input type="file" style="display:none" ref="input" @change="changeImg">
                </div>
            </div>
            <!-- 中间线 -->
            <div class="midLine"></div>
            <!-- 用户信息 -->
            <div class="user-desc-content">
                <div class="user-desc-wrap">
                    <div class="user-desc-item">
                        <span>用户ID：</span>
                        <!-- <el-input
                            placeholder="请输入内容"
                            v-model="userInfo.userId"
                            clearable
                            :disabled="true"
                        ></el-input>-->
                        <div class="el-input">
                            <!---->
                            <input
                                type="text"
                                autocomplete="off"
                                placeholder="请输入内容"
                                v-model="userInfo.userId"
                                class="el-input__inner"
                                :readonly="true"
                            >
                            <!---->
                            <!---->
                            <!---->
                        </div>
                    </div>
                    <div class="user-desc-item">
                        <span>联系方式：</span>
                        <!-- <el-input placeholder="请输入内容" v-model="userInfo.userTel" clearable></el-input> -->
                        <div class="el-input">
                            <!---->
                            <input
                                type="text"
                                autocomplete="off"
                                placeholder="请输入内容"
                                v-model="userInfo.userTel"
                                :class="{'el-input__inner' : isChange,'el-input__inner2' : !isChange}"
                                :readonly="isChange"
                            >
                            <!---->
                            <!---->
                            <!---->
                        </div>
                    </div>
                    <div class="user-desc-item">
                        <span>Email：</span>
                        <!-- <el-input placeholder="请输入内容" v-model="userInfo.userEmail" clearable></el-input> -->
                        <div class="el-input">
                            <!---->
                            <input
                                type="text"
                                autocomplete="off"
                                placeholder="请输入内容"
                                v-model="userInfo.userEmail"
                                :class="{'el-input__inner' : isChange,'el-input__inner2' : !isChange}"
                                :readonly="isChange"
                            >
                            <!---->
                            <!---->
                            <!---->
                        </div>
                    </div>
                    <div class="user-desc-item">
                        <!-- <el-button type="text" @click="changePwd">修改密码>>></el-button> -->
                        <el-button type="text" @click="dialogVisible = true">修改密码>>></el-button>

                        <el-dialog
                            title="修改密码"
                            :visible.sync="dialogVisible"
                            width="30%"
                            :before-close="handleClose"
                        >
                            <el-input
                                placeholder="旧密码"
                                v-model="pwd0"
                                show-password
                                style="margin-bottom:15px"
                            ></el-input>
                            <el-input
                                placeholder="新密码"
                                v-model="pwd1"
                                show-password
                                style="margin-bottom:15px"
                            ></el-input>
                            <el-input placeholder="再次输入" v-model="pwd2" show-password></el-input>
                            <span slot="footer" class="dialog-footer">
                                <el-button @click="handleClose">取 消</el-button>
                                <el-button type="primary" @click="changePwd">确 定</el-button>
                            </span>
                        </el-dialog>
                    </div>
                </div>
            </div>
        </div>
        <div class="change-userInfo">
            <el-button type="primary" v-show="isChange" @click="updateUserInfo">修改资料</el-button>
            <el-button-group>
                <el-button type="primary" v-show="!isChange" @click="submit">保存修改</el-button>
                <el-button v-show="!isChange" @click="cancel">取消修改</el-button>
            </el-button-group>
        </div>
    </div>
</template>


<script>
import { mapState, mapGetters, mapActions } from "vuex";

export default {
    inject: ["reload"],
    data() {
        return {
            dialogVisible: false,
            userInfo: {
                userId: "",
                userTel: "",
                userEmail: ""
            },
            headImgUrl: {},
            isChange: true,
            formdata: new FormData(),
            pwd0: "",
            pwd1: "",
            pwd2: ""
        };
    },
    created() {
        this.getUser();
    },
    methods: {
        ...mapActions("user", [
            //user是指modules文件夹下的user.js
            "setUser" //user.js文件中的actions里的方法.
        ]),
        ...mapGetters("user", [
            //user是指modules文件夹下的user.js
            "getUserInfo" //user.js文件中的actions里的方法.
        ]),

        // 获取用户信息
        getUser() {
            this.userInfo = this.getUserInfo();

            this.headImgUrl = {
                backgroundImage:
                    "url(" +
                    require("@/assets/images/user_head_img/" + this.userInfo.userHeadImg) +
                    ")"
            };
        },

        //按钮事件开始
        updateUserInfo() {
            this.isChange = false;
        },
        submit() {
            // console.log("++++++++++");

            // console.log(this.userInfo);

            this.$axios.post("/user/updateUser", this.userInfo).then(resp => {
                if (resp.data.msg == "success") {
                    this.$message({
                        message: "修改成功！",
                        type: "success"
                    });
                } else {
                    this.$message.error("修改失败！");
                }

                this.setUser(this.userInfo);
                //刷新
                this.reload();
                // this.getUser();
            });
        },
        cancel() {
            this.isChange = true;

            // 刷新页面
            this.reload();
        },
        //按钮事件结束

        //修改头像事件开始
        changeImgEmit() {
            console.log(123);

            this.$refs.input.click();
        },
        changeImg(e) {
            if (e.target.files[0] == null) {
                return;
            }

            const isLt2M = e.target.files[0].size / 1024 / 1024 < 2;
            const isJPG =
                e.target.files[0].type === "image/jpeg" ||
                e.target.files[0].type === "image/png";
            if (!isJPG) {
                this.$message.error("上传头像图片只能是 JPG 格式!");
                return;
            }
            if (!isLt2M) {
                this.$message.error("上传头像图片大小不能超过 2MB!");
                return;
            }
            // let imgName = e.target.files[0].name;


            // let imgName = e.target.files[0].name;
            this.userInfo.userHeadImg = this.getUserInfo().userId + ".jpg";
            console.log(e.target.files[0]);
            
            let imgUrl = URL.createObjectURL(e.target.files[0]);
            this.headImgUrl = {
                backgroundImage: "url(" + imgUrl + ")"
            };
            this.formdata.append("file", e.target.files[0]);
            this.formdata.append("userId", this.userInfo.userId);

            //添加请求头
            let config = {
                //添加请求头
                headers: { "Content-Type": "multipart/form-data" }
                //添加上传进度监听事件
                // onUploadProgress: e => {
                //     var completeProgress =
                //         (((e.loaded / e.total) * 100) | 0) + "%";
                //     this.progress = completeProgress;
                // }
            };
            this.$axios
                .post("/user/updateHeadImage", this.formdata, config)
                .then(resp => {
                    if (resp.data.msg == "success") {
                        this.$message({
                            message: "修改成功！",
                            type: "success"
                        });
                    } else {
                        this.$message.error("修改失败！");
                    }

                    this.setUser(this.userInfo);
                });
        },
        //修改头像事件结束

        //修改密码
        handleClose(done) {
            this.dialogVisible = false;
        },
        changePwd() {
            if (this.pwd1 === this.pwd2) {
                this.$axios
                    .post("/user/changePwd", {
                        userId: this.userInfo.userId,
                        oldPwd: this.pwd0,
                        newPwd: this.pwd1
                    })
                    .then(resp => {
                        console.log(resp);
                        if (resp.data.msg == "success") {
                            this.$message({
                                type: "success",
                                message: "修改成功！"
                            });
                        } else {
                            this.$message.error("旧密码输入错误！");
                        }

                        this.dialogVisible = false;
                    });
            } else {
                this.$message({
                    type: "info",
                    message: "两次密码输入不一致"
                });
            }
        }
    }
};
</script>

<style lang="less" scoped>
.userInfo-container {
    background-color: #fff;

    .user-info-bread {
        padding-top: 20px;
        width: 1160px;
        margin: 0 auto;
    }
    .userInfo-wrap {
        width: 1160px;
        min-height: 450px;
        margin: 0 auto;
        padding-top: 50px;
        display: flex;
        justify-content: space-around;
        .user-head-img {
            width: 200px;

            .user-head-img-wrap {
                width: 400px;
                margin-top: 50px;
                .img {
                    width: 200px;
                    height: 200px;
                    background-repeat: no-repeat;
                    background-size: 100% 100%;
                    border-radius: 4px;
                    margin: 0 auto;
                }
                .change-img {
                    padding: 30px 0;
                    width: 50px;
                    margin: 0 auto;
                    cursor: pointer;
                }
            }
        }
        .midLine {
            border-left: 2px dashed #ccc;
        }
        .user-desc-content {
            width: 200px;
            height: 200px;
            .user-desc-wrap {
                margin-top: 50px;
                width: 400px;
                margin-left: -100px;

                .user-desc-item {
                    display: flex;
                    justify-content: space-between;
                    margin-bottom: 25px;
                    span {
                        width: 20%;
                        line-height: 40px;
                    }
                }
            }
        }
    }

    .change-userInfo {
        width: 1160px;
        text-align: center;
        padding: 30px 0;
        margin: 0 auto;
    }
}

.el-input__inner {
    -webkit-appearance: none;
    background-color: #fff;
    background-image: none;
    border-radius: none;
    border: none;
    -webkit-box-sizing: none;
    box-sizing: none;
    color: #606266;
    display: inline-block;
    font-size: inherit;
    height: 40px;
    line-height: 40px;
    // outline: 0;
    padding: 0 15px;
    -webkit-transition: border-color 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);
    transition: border-color 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);
    width: 100%;
    cursor: auto;
}
.el-input__inner2 {
    -webkit-appearance: none;
    background-color: #fff;
    background-image: none;
    border-radius: 4px;
    border: 1px solid #dcdfe6;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    color: #606266;
    display: inline-block;
    font-size: inherit;
    height: 40px;
    line-height: 40px;
    // outline: 0;
    padding: 0 15px;
    -webkit-transition: border-color 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);
    transition: border-color 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);
    width: 100%;
}
</style>


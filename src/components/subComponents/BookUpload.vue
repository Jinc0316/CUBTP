<template>
    <div class="upload-container">
        <!-- <nav-header></nav-header> -->
        <div class="upload-form">
            <h1 style="margin:0 0 40px 0;">书籍上传</h1>

            <div class="upload-form-content">
                <div class="upload-form-content-left">
                    <div class="avatar-uploader">
                        <h2>书籍封面</h2>
                        <div tabindex="0" class="el-upload el-upload--text" @click="emitInputEvent">
                            <img
                                :src="bookCoverImgUrl"
                                v-if="bookCoverImgUrl"
                                width="100%"
                                height="100%"
                                class="avatar"
                            >
                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                            <input
                                type="file"
                                name="file"
                                accept="image/png, image/gif, image/jpg, image/jpeg"
                                class="el-upload__input"
                                ref="bookCoverInput"
                                @change="bookCoverPreview"
                            >
                        </div>

                        <el-button
                            type="text"
                            size="mini"
                            style="margin-top:15px;cursor:pointer"
                            @click="emitInputEvent"
                        >点击修改>>></el-button>
                    </div>
                </div>

                <div class="upload-form-content-right">
                    <el-form
                        :label-position="labelPosition"
                        label-width="100px"
                        :model="bookForm"
                        class="upload-form-detail"
                    >
                        <el-form-item label="书籍名称">
                            <el-input v-model="bookForm.name" style="width:350px"></el-input>
                        </el-form-item>
                        <el-form-item label="书籍作者">
                            <el-input v-model="bookForm.author" style="width:350px"></el-input>
                        </el-form-item>
                        <el-form-item label="书籍出版社">
                            <el-input v-model="bookForm.press" style="width:350px"></el-input>
                        </el-form-item>
                        <el-form-item label="书籍原价">
                            <el-input-number
                                v-model="bookForm.oldPrice"
                                :precision="2"
                                :step="0.1"
                                style="width:250px"
                            ></el-input-number>
                        </el-form-item>
                        <el-form-item label="书籍售价">
                            <el-input-number
                                v-model="bookForm.price"
                                :precision="2"
                                :step="0.1"
                                style="width:250px"
                            ></el-input-number>
                        </el-form-item>
                        <el-form-item label="书籍数量">
                            <el-input-number
                                v-model="bookForm.num"
                                :min="1"
                                :max="100"
                                label="描述文字"
                                style="width:250px"
                            ></el-input-number>
                        </el-form-item>
                        <el-form-item label="书籍新旧程度">
                            <!-- <el-input v-model="bookForm.degree"></el-input> -->
                            <el-select
                                v-model="bookForm.degree"
                                placeholder="请选择"
                                size="medium"
                                style="width:250px"
                            >
                                <el-option
                                    v-for="item in degreeOptions"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value"
                                ></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="书籍类型">
                            <!-- <el-input v-model="bookForm.type"></el-input> -->
                            <el-select
                                v-model="bookForm.type"
                                placeholder="请选择"
                                style="width:250px"
                            >
                                <el-option
                                    v-for="item in typeOptions"
                                    :key="item.id"
                                    :label="item.bookType"
                                    :value="item.bookType"
                                ></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="书籍学科">
                            <!-- <el-input v-model="bookForm.subject"></el-input> -->
                            <el-select
                                v-model="bookForm.subject"
                                placeholder="请选择"
                                style="width:250px"
                            >
                                <el-option
                                    v-for="item in subjectOptions"
                                    :key="item.id"
                                    :label="item.bookSubject"
                                    :value="item.bookSubject"
                                ></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="书籍描述">
                            <el-input
                                type="textarea"
                                :autosize="{ minRows: 3, maxRows: 5}"
                                placeholder="请输入内容"
                                v-model="bookForm.desc"
                                style="width:350px"
                                resize="none"
                            ></el-input>
                        </el-form-item>
                    </el-form>
                </div>
            </div>
            <!-- 上传按钮 -->
            <div class="upload-book">
                <div class="upload-btn">
                    <el-button
                        style="width:200px;margin-top:30px"
                        type="primary"
                        @click="submitUpload"
                    >上传</el-button>
                </div>
            </div>
        </div>
    </div>
</template>


<script>
// import Header from "./Header/Header";
import { mapState, mapGetters, mapActions } from "vuex";

export default {
    inject: ["reload"],
    data() {
        return {
            labelPosition: "right",
            bookForm: {
                name: "",
                cover: "",
                author: "",
                press: "",
                oldPrice: 0,
                price: 0,
                num: 0,
                degree: "",
                type: "",
                subject: "",
                desc: ""
            },
            dialogImageUrl: "",
            formData: new FormData(),
            bookCoverImgUrl: require("../../assets/images/default_img/default-cover.png"),
            degreeOptions: [
                {
                    value: "十成新",
                    label: "十成新"
                },
                {
                    value: "九成新",
                    label: "九成新"
                },
                {
                    value: "八成新",
                    label: "八成新"
                },
                {
                    value: "七成新",
                    label: "七成新"
                },
                {
                    value: "六成新",
                    label: "六成新"
                },
                {
                    value: "五成新",
                    label: "五成新"
                },
                {
                    value: "四成新",
                    label: "四成新"
                },
                {
                    value: "三成新",
                    label: "三成新"
                },
                {
                    value: "二成新",
                    label: "二成新"
                },
                {
                    value: "一成新",
                    label: "一成新"
                }
            ],

            typeOptions: [
                {
                    value: "工具书",
                    label: "工具书"
                }
            ],

            subjectOptions: [
                {
                    value: "高数",
                    label: "高数"
                }
            ]
        };
    },
    created() {
        this.getAllBookSubject();
        this.getAllBookType();
    },
    methods: {
        ...mapGetters("user", [
            //user是指modules文件夹下的user.js
            "getUserInfo" //user.js文件中的actions里的方法.
        ]),

        //渲染书籍科目选项
        getAllBookSubject() {
            this.$axios.get("/other/getAllBookSubject").then(resp => {
                // console.log(resp.data.data);
                this.subjectOptions = resp.data.data;
            });
        },
        //渲染书籍类型选项
        getAllBookType() {
            this.$axios.get("/other/getAllBookType").then(resp => {
                // console.log(resp.data.data);
                this.typeOptions = resp.data.data;
            });
        },

        //触发input-file事件
        emitInputEvent(e) {
            // console.log(e.target.files);

            this.$refs.bookCoverInput.click(e);
        },

        //书籍封面预览
        bookCoverPreview(e) {
            // console.log(e.target.files[0]);

            if (e.target.files[0] == null) {
                return;
            }

            const isLt2M = e.target.files[0].size / 1024 / 1024 < 2;
            const isJPG =
                e.target.files[0].type === "image/jpeg" ||
                e.target.files[0].type === "image/png";
            if (!isJPG) {
                this.$message.error("上传封面图片只能是 JPG 格式!");
                return;
            }
            if (!isLt2M) {
                this.$message.error("上传封面图片大小不能超过 2MB!");
                return;
            }
            let imgName = e.target.files[0].name;

            this.bookForm.cover = imgName;
            let ImgUrl = URL.createObjectURL(e.target.files[0]);
            this.bookCoverImgUrl = ImgUrl;
            this.formData.set("file", e.target.files[0]);
            // console.log(this.formData.get("file"));
        },

        //书籍上传
        submitUpload() {
            // 获取上传用户的id
            // let value = this.$cookieStore.getCookie("userInfo");
            // console.log("Cookie是否存在：" + value);
            // let userInfo = JSON.parse(JSON.parse(value));
            // console.log(userInfo.userId);
            let userId = this.getUserInfo().userId;

            if (this.formData.get("file") == null) {
                this.$message.error("请选择书籍封面");
                return;
            }

            //将数据放入formData
            this.formData.append("bookName", this.bookForm.name);
            this.formData.append("bookCover", this.bookForm.cover);
            this.formData.append("bookAuthor", this.bookForm.author);
            this.formData.append("bookPress", this.bookForm.press);
            this.formData.append("bookPrice", this.bookForm.price);
            this.formData.append("bookOldPrice", this.bookForm.oldPrice);
            this.formData.append("bookNum", this.bookForm.num);
            this.formData.append("bookDegree", this.bookForm.degree);
            this.formData.append("bookType", this.bookForm.type);
            this.formData.append("bookSubject", this.bookForm.subject);
            this.formData.append("bookDesc", this.bookForm.desc);
            this.formData.append("bookSellerId", userId);
            // console.log(this.formData.get("file"));

            // 用户确认
            this.$confirm("确定上传吗?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning"
            })
                .then(() => {
                    submit();
                })
                .catch(() => {
                    this.$message({
                        type: "info",
                        message: "已取消上传"
                    });
                });

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

            //上传书籍函数
            let submit = () => {
                this.$axios
                    .post("/book/upload", this.formData, config)
                    .then(resp => {
                        if (resp.data.msg === "fail") {
                            this.$message.error("上传失败");
                        } else {
                            this.$message({
                                message: "上传成功,请耐心等待审核！",
                                type: "success"
                            });
                            // 刷新页面
                            this.reload();
                        }
                    });
            };
        }
    }
};
</script>

<style lang="less" scoped>
.upload-container {
    width: 1160px;
    margin: 0 auto;
    margin-top: 40px;
    .upload-form {
        width: 100%;
        background-color: #fff;
        padding: 40px;

        .upload-form-content {
            display: flex;
            justify-content: space-evenly;
            .upload-form-content-left {
                width: 300px;
                // padding-top: 100px;
                text-align: center;
                .avatar-uploader .el-upload {
                    border: 1px dashed #d9d9d9;
                    border-radius: 6px;
                    cursor: pointer;
                    position: relative;
                    overflow: hidden;
                }
                .avatar-uploader .el-upload:hover {
                    border-color: #409eff;
                }
                .avatar-uploader-icon {
                    font-size: 28px;
                    color: #8c939d;
                    width: 328px;
                    height: 448px;
                    line-height: 178px;
                    text-align: center;
                }
                .avatar {
                    width: 328px;
                    height: 448px;
                    display: block;
                }
            }
            .upload-form-content-right {
                width: 500px;
                .upload-form-detail {
                    width: 100%;
                    margin: 0 auto;
                }
            }
        }
        .upload-book {
            // margin: 0 auto;
            .upload-btn {
                width: 200px;
                margin: 0 auto;
            }
        }
    }
}
</style>


<template>
    <div class="myStore-container">
        <div class="myStore-wrapper">
            <h1 style="margin-bottom:30px">我的店铺</h1>
            <div class="myStore-list">
                <div class="myStore-list-item" v-for="item in myStoreBooks" :key="item.bookId">
                    <div class="book-img">
                        <img :src="require('@/assets/images/book_cover_img/' + item.bookCover)" alt>
                    </div>
                    <div class="book-name">
                        <div
                            :title="item.bookName"
                            style="white-space: nowrap;overflow: hidden;text-overflow:ellipsis;"
                        >{{item.bookName}}</div>
                        <!-- <br height=0> -->
                        <span
                            :style="{color:(item.bookStatus == 0?'#FF7F00':item.bookStatus == 1?'green':'red')}"
                            :title="item.bookStatus == 2?'点击查看理由':item.bookStatus == 0 ?'请耐心等待':'已通过审核'"
                            @click="open(item)"
                        >({{item.bookStatus == 0? '待审核':item.bookStatus == 1?'审核通过':'审核不通过'}})</span>
                    </div>
                    <div class="user-operation">
                        <el-button
                            type="primary"
                            icon="el-icon-edit"
                            title="编辑"
                            circle
                            size="small"
                            @click="editBookInfo(item.bookId)"
                        ></el-button>
                        <el-button
                            type="danger"
                            icon="el-icon-delete"
                            title="下架"
                            circle
                            size="small"
                            @click="deleteBook(item.bookId)"
                        ></el-button>
                    </div>
                </div>
            </div>
            <div class="noDataShow" v-show="myStoreBooks.length == 0">
                <div>w(ﾟДﾟ)w&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您的书铺空空如也，快去上传吧！！</div>
                <img src="../../assets/images/default_img/404.jpg" alt="nothing">
            </div>
        </div>
        <!-- 编辑弹窗 -->
        <!-- 编辑弹窗 -->
        <!-- 编辑弹窗 -->
        <el-dialog title="编辑" :visible.sync="dialogFormVisible" width="1000px">
            <div class="upload-container">
                <!-- <nav-header></nav-header> -->
                <div class="upload-form">
                    <!-- <h1 style="margin:0 0 40px 0;">编辑书籍</h1> -->

                    <div class="upload-form-content">
                        <div class="upload-form-content-left">
                            <div class="avatar-uploader">
                                <h2>书籍封面</h2>
                                <div
                                    tabindex="0"
                                    class="el-upload el-upload--text"
                                    @click="emitInputEvent"
                                >
                                    <img
                                        :src="bookCoverImgUrl"
                                        width="100%"
                                        height="100%"
                                        class="avatar"
                                    >

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
                                :model="bookInfo"
                                class="upload-form-detail"
                            >
                                <el-form-item label="书籍名称">
                                    <el-input v-model="bookInfo.bookName" style="width:350px"></el-input>
                                </el-form-item>
                                <el-form-item label="书籍作者">
                                    <el-input v-model="bookInfo.bookAuthor" style="width:350px"></el-input>
                                </el-form-item>
                                <el-form-item label="书籍出版社">
                                    <el-input v-model="bookInfo.bookPress" style="width:350px"></el-input>
                                </el-form-item>
                                <el-form-item label="书籍原价">
                                    <el-input-number
                                        v-model="bookInfo.bookOldPrice"
                                        :precision="2"
                                        :step="0.1"
                                        style="width:250px"
                                    ></el-input-number>
                                </el-form-item>
                                <el-form-item label="书籍售价">
                                    <el-input-number
                                        v-model="bookInfo.bookPrice"
                                        :precision="2"
                                        :step="0.1"
                                        style="width:250px"
                                    ></el-input-number>
                                </el-form-item>
                                <el-form-item label="书籍数量">
                                    <el-input-number
                                        v-model="bookInfo.bookNum"
                                        :min="1"
                                        :max="100"
                                        label="描述文字"
                                        style="width:250px"
                                    ></el-input-number>
                                </el-form-item>
                                <el-form-item label="书籍新旧程度">
                                    <el-select
                                        v-model="bookInfo.bookDegree"
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
                                    <el-select
                                        v-model="bookInfo.bookType"
                                        placeholder="请选择"
                                        style="width:250px"
                                    >
                                        <el-option
                                            v-for="item in typeOptions"
                                            :key="item.value"
                                            :label="item.label"
                                            :value="item.value"
                                        ></el-option>
                                    </el-select>
                                </el-form-item>
                                <el-form-item label="书籍学科">
                                    <el-select
                                        v-model="bookInfo.bookSubject"
                                        placeholder="请选择"
                                        style="width:250px"
                                    >
                                        <el-option
                                            v-for="item in subjectOptions"
                                            :key="item.value"
                                            :label="item.label"
                                            :value="item.value"
                                        ></el-option>
                                    </el-select>
                                </el-form-item>
                                <el-form-item label="书籍描述">
                                    <el-input
                                        type="textarea"
                                        :autosize="{ minRows: 3, maxRows: 5}"
                                        placeholder="请输入内容"
                                        v-model="bookInfo.bookDesc"
                                        style="width:350px"
                                        resize="none"
                                    ></el-input>
                                </el-form-item>
                            </el-form>
                        </div>
                    </div>
                </div>
            </div>

            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="submitEdit">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
// import BookUpload from "./BookUpload";
import { mapState, mapGetters, mapActions } from "vuex";

export default {
    inject: ["reload"],
    data() {
        return {
            dialogFormVisible: false,
            labelPosition: "right",
            bookInfo: {
                bookId: 0,
                bookName: "",
                bookCover: "",
                bookAuthor: "",
                bookPress: "",
                bookOldPrice: 0,
                bookPrice: 0,
                bookNum: 0,
                bookDegree: "",
                bookType: "",
                bookSubject: "",
                bookDesc: ""
            },
            formData: new FormData(),
            bookCoverImgUrl: "",
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
            ],

            myStoreBooks: []
        };
    },
    created() {
        this.getBookBySellerId();
    },
    methods: {
        ...mapGetters("user", [
            //user是指modules文件夹下的user.js
            "getUserInfo" //user.js文件中的actions里的方法.
        ]),
        open(item) {
            if (item.bookStatus == 2) {
                this.$alert(item.bookNotes, "不通过理由", {
                    confirmButtonText: "确定",
                    callback: action => {
                    }
                });
            } else {
                return
            }
        },

        //渲染所有已上传的书籍
        getBookBySellerId() {
            this.$axios
                .get(
                    "/book/getBookBySellerId?sellerId=" +
                        this.getUserInfo().userId
                )
                .then(resp => {
                    // console.log(resp.data.data);
                    this.myStoreBooks = resp.data.data;
                });
        },
        //下架已上传的书籍
        deleteBook(bookId) {
            this.$confirm("是否确定下架该书籍?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning"
            })
                .then(() => {
                    this.$axios
                        .get("/book/deleteBook?bookId=" + bookId)
                        .then(resp => {
                            if (resp.data.msg === "fail") {
                                this.$message.error("下架失败");
                            } else {
                                this.$message({
                                    message: "下架成功",
                                    type: "success"
                                });
                                this.reload();
                            }
                        });
                })
                .catch(() => {
                    this.$message({
                        type: "info",
                        message: "已取消下架"
                    });
                });
        },

        /*
         *
         * dialog中的事件处理函数 start
         *
         * */

        //弹窗渲染书籍信息
        editBookInfo(bookId) {
            this.dialogFormVisible = true;
            this.$axios.get("/book/getBookInfo?bookId=" + bookId).then(resp => {
                console.log(resp.data.data);
                let bookInfo = resp.data.data;
                this.bookInfo = bookInfo;
                this.bookCoverImgUrl = require("@/assets/images/book_cover_img/" +
                    this.bookInfo.bookCover);
            });
        },

        //触发input-file事件
        emitInputEvent() {
            this.$refs.bookCoverInput.click();
        },

        //书籍封面预览
        bookCoverPreview(e) {
            if (e.target.files[0] == null) {
                return;
            }

            const isLt2M = e.target.files[0].size / 1024 / 1024 < 2;
            const isJPG =
                e.target.files[0].type === "image/jpeg" ||
                e.target.files[0].type === "image/png";
            if (!isJPG) {
                this.$message.error("上传封面只能是 JPG或者PNG 格式!");
                return;
            }
            if (!isLt2M) {
                this.$message.error("上传封面大小不能超过 2MB!");
                return;
            }
            let imgName = e.target.files[0].name;

            let ImgUrl = URL.createObjectURL(e.target.files[0]);
            this.bookCoverImgUrl = ImgUrl;
            this.bookInfo.bookCover = imgName;
            this.formData.append("file", e.target.files[0]);
        },

        //书籍修改
        submitEdit() {
            // 获取上传用户的id
            let userId = this.getUserInfo().userId;
            console.log(this.formData.get("file"));

            //将数据放入formData
            this.formData.append("bookId", this.bookInfo.bookId);
            this.formData.append("bookName", this.bookInfo.bookName);
            this.formData.append("bookCover", this.bookInfo.bookCover);
            this.formData.append("bookAuthor", this.bookInfo.bookAuthor);
            this.formData.append("bookPress", this.bookInfo.bookPress);
            this.formData.append("bookOldPrice", this.bookInfo.bookOldPrice);
            this.formData.append("bookPrice", this.bookInfo.bookPrice);
            this.formData.append("bookNum", this.bookInfo.bookNum);
            this.formData.append("bookDegree", this.bookInfo.bookDegree);
            this.formData.append("bookType", this.bookInfo.bookType);
            this.formData.append("bookSubject", this.bookInfo.bookSubject);
            this.formData.append("bookDesc", this.bookInfo.bookDesc);
            this.formData.append("bookSellerId", userId);
            console.log(this.formData.get("bookCover"));
            console.log(this.formData.get("file"));

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

            this.$confirm("确认修改吗?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning"
            })
                .then(() => {
                    this.$axios
                        .post("/book/editBookInfo", this.formData, config)
                        .then(resp => {
                            if (resp.data.msg === "fail") {
                                this.$message.error("修改失败");
                            } else {
                                this.$message({
                                    message: "修改成功",
                                    type: "success"
                                });
                            }

                            // 刷新页面
                            this.reload();
                        });
                })
                .catch(() => {
                    this.$message({
                        type: "info",
                        message: "已取消修改"
                    });
                });
        }
    }
};
</script>




<style lang="less" scoped>
.myStore-container {
    .myStore-wrapper {
        width: 1160px;
        background-color: #fff;
        margin: 0 auto;
        margin-top: 40px;
        padding: 40px;
        min-height: 545px;
        .myStore-list {
            display: flex;
            justify-content: flex-start;
            flex-wrap: wrap;

            .myStore-list-item {
                margin-left: 40px;
                margin-bottom: 20px;
                width: 94px;
                .book-img {
                    width: 100%;
                    height: 124px;
                    margin-bottom: 5px;
                    img {
                        width: 100%;
                        height: 100%;
                    }
                }

                .book-name {
                    text-align: center;
                    padding: 5px;
                }
                .user-operation {
                    display: flex;
                    justify-content: space-around;
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

.upload-container {
    width: 960px;
    margin: 0 auto;
    // margin-top: 40px;
    .upload-form {
        width: 100%;
        background-color: #fff;
        // padding: 40px;

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

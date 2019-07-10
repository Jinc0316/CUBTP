<template>
    <div class="book-list-container">
        <div class="book-list-wrapper">
            <div class="book-list">
                <router-link
                    class="book-list-item"
                    :to="{path:'/home/bookinfo',query:{bookId:item.bookId}}"
                    tag="div"
                    v-for="(item,i) in (this.$store.getters['book/getBookList'])"
                    :key="i"
                >
                    <div
                        class="book-list-item-img"
                        :style="{backgroundImage: 'url(' + require('@/assets/images/book_cover_img/'+ item.bookCover) + ')' }"
                    ></div>
                    <div class="book-list-item-detail">
                        <div class="book-list-item-title">{{item.bookName}}</div>
                        <div class="book-list-item-text">作者：{{item.bookAuthor}}</div>
                        <div class="book-list-item-text">
                            <span class="icon time-icon"></span>
                            成色：{{item.bookDegree}}
                        </div>
                        <div class="book-list-item-text">
                            <span class="icon time-icon"></span>
                            书籍数量：{{item.bookNum}}
                        </div>
                        <div class="book-list-item-address">
                            <span class="icon address-icon"></span>
                            <!---->
                            <span class="venue-name-and-address">出版社：{{item.bookPress}}</span>
                        </div>
                        <div class="book-list-item-price">
                            <div class="not-free">
                                <span class="price-symbol">¥</span>
                                <span class="price">{{item.bookPrice}}</span>
                                <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                <!-- <span></span> -->
                                <span><s>¥&nbsp;{{item.bookOldPrice}}</s></span>
                            </div>
                        </div>
                    </div>
                </router-link>

                <div class="nullDataShow" style="text-align:center; color:#f25d8e; padding:50px 0; font-size:20px" v-if="!this.$store.getters['book/getBookList']">
                    <span>w(ﾟДﾟ)w&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;不好意思，没有您想要的！！！</span>
                </div>
            </div>
        </div>
        <div class="book-list-wrapper" style="padding-bottom:0">
            <el-pagination
                background
                layout="prev, pager, next"
                :total="this.$store.getters['book/getTotal']"
                @current-change="ChangePage"
                :style="{width:paginationWidth}"
            ></el-pagination>
        </div>
    </div>
</template>


<script>
import { mapState, mapGetters, mapActions } from "vuex";
export default {
    inject: ["reload"],
    data() {
        return {
            total: 0,
            currentPage: 0,
            bookList: [],
            pageSize: 0
        };
    },
    created() {
        this.ChangePage();
    },
    computed: {
        paginationWidth: function() {
            let page = Math.ceil( this.$store.getters['book/getTotal'] / this.getPageSize());
            // console.log(page);

            if (page <= 7) {
                return (page + 2) * 40 + "px";
            } else {
                return 11 * 40 + "px";
            }
        }
    },
    methods: {
        ...mapActions("book", [
            "setSContent",
            "setBList",
            "setAll",
            "setCPage",
            "setPSize"
        ]),
        ...mapGetters("book", [
            "getSearchContent",
            "getBookList",
            "getTotal",
            "getCurrentPage",
            "getPageSize"
        ]),
        ChangePage(currentPage) {
            // console.log(currentPage);
            if (currentPage == null) {
                currentPage = 1;
            }
            this.setCPage(currentPage);
            this.currentPage = this.getCurrentPage();
            this.pageSize = this.getPageSize();

            let searchContent = this.getSearchContent();
            let param1 = {
                ...searchContent,
                currentPage: this.currentPage,
                pageSize: this.pageSize
            };
            // console.log(param1);

            this.$axios.post("/book/searchBook", param1).then(resp => {
                this.setBList(resp.data.data);
                this.bookList = this.getBookList();
                // console.log(this.bookList);
            });

            //获取查询结果总数
            let param2 = {
                ...this.getSearchContent()
            };

            // console.log(param2);

            this.$axios.post("/book/getSearchBookCount", param2).then(resp => {
                this.setAll(resp.data.data.total);
                console.log(resp.data.data.total);
                
                this.total = this.getTotal();
                console.log(this.total);
                
            });   
        }
    }
};
</script>

<style lang="less" scoped>
.book-list-wrapper {
    width: 1160px;
    margin: 0 auto;
    overflow: hidden;
    padding-bottom: 55px;

    .book-list {
        width: 1160px;
        margin: 0 auto;
        .book-list-item {
            cursor: pointer;
            display: -ms-flexbox;
            display: flex;
            position: relative;
            margin-top: 60px;
            margin-left: 20px;
            margin-right: 20px;
            width: 540px;
            height: 237px;
            background: #fff;
            box-shadow: 0 0 15px 0 hsla(203, 6%, 45%, 0.09);
            border-radius: 8px;
            float: left;
            transition: transform 0.2s;

            &:hover {
                box-shadow: 0 15px 20px 0 hsla(203, 6%, 45%, 0.4);
            }

            .book-list-item-img {
                transition: transform 0.1s;
                background: #fff;
                box-shadow: 3px 3px 2px 0 hsla(203, 6%, 45%, 0.3);
                border-radius: 8px;
                left: 20px;
                bottom: 24px;
                position: absolute;
                width: 175px;
                height: 233px;
                background-repeat: no-repeat;
                background-size: 100% 100%;

                &:hover {
                    transform: translate3d(0, -10px, 0);
                }
            }

            .book-list-item-detail {
                margin-left: 223px;
                width: 305px;

                .book-list-item-title {
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    margin-top: 30px;
                    width: 100%;
                    height: 20px;
                    font-size: 18px;
                    color: #222;
                    letter-spacing: 0;
                    line-height: 24px;
                }

                .book-list-item-text {
                    width: 100%;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    margin-top: 10px;
                    display: -ms-flexbox;
                    display: flex;
                    -ms-flex-align: center;
                    align-items: center;
                    height: 17px;
                    font-size: 14px;
                    color: #999;
                }

                .book-list-item-address {
                    margin-top: 10px;
                    display: -ms-flexbox;
                    display: flex;
                    -ms-flex-align: center;
                    align-items: center;
                    height: 17px;
                    font-size: 14px;
                    color: #999;
                }

                .book-list-item-price,
                .book-list-item-price .not-free {
                    display: -ms-flexbox;
                    display: flex;
                    -ms-flex-align: end;
                    align-items: flex-end;
                    margin-top: 10px;
                    color: #f25d8e;

                    .price-symbol {
                        -ms-flex-item-align: end;
                        align-self: flex-end;
                        font-size: 18px;
                        line-height: 18px;
                    }
                    .price {
                        margin-left: 4px;
                        font-size: 28px;
                        letter-spacing: 1px;
                        line-height: 24px;
                    }
                }
            }
        }
    }

    .el-pagination {
        margin: 0 auto;
    }
}
</style>



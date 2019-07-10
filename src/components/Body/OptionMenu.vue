<template>
    <div class="option-menu-container">
        <div class="option-menu-list">
            <div class="book-type-option">
                <div class="book-type-option-title option-title">
                    <span>书籍类型</span>
                </div>
                <div class="book-type-option-content option-content">
                    <ul class="book-type-option-list option-list">
                        <li
                            class="book-type-option-item first-option-item"
                            :class="{optionActive:first1}"
                            @click="firstActive1"
                        >全部</li>
                        <li
                            class="book-type-option-item option-item"
                            :class="{optionActive:i==index1}"
                            v-for="(item,i) in typeOptions"
                            :key="i"
                            @click="active1(i,item.bookType)"
                        >{{item.bookType}}</li>
                    </ul>
                </div>
            </div>
            <div class="book-subject-option">
                <div class="book-subject-option-title option-title">
                    <span>书籍科目</span>
                </div>
                <div class="book-subject-option-content option-content">
                    <ul class="book-subject-option-list option-list">
                        <li
                            class="book-subject-option-item first-option-item"
                            :class="{optionActive:first2}"
                            @click="firstActive2"
                        >全部</li>
                        <li
                            class="book-subject-option-item option-item"
                            :class="{optionActive:i==index2}"
                            v-for="(item,i) in subjectOptions"
                            :key="i"
                            @click="active2(i,item.bookSubject)"
                        >{{item.bookSubject}}</li>
                    </ul>
                </div>
            </div>
            <div class="book-new-degree">
                <div class="book-new-degree-title option-title">
                    <span>新旧程度</span>
                </div>
                <div class="book-new-degree-content option-content">
                    <ul class="book-new-degree-list option-list">
                        <li
                            class="book-new-degree-item first-option-item"
                            :class="{optionActive:first3}"
                            @click="firstActive3"
                        >全部</li>
                        <li
                            class="book-new-degree-item option-item"
                            :class="{optionActive:i==index3}"
                            v-for="(item,i) in newDegreeOptions"
                            :key="i"
                            @click="active3(i,item.type)"
                        >{{item.type}}</li>
                    </ul>
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
            index1: -1,
            index2: -1,
            index3: -1,
            first1: true,
            first2: true,
            first3: true,
            typeOptions: [],
            subjectOptions: [],
            newDegreeOptions: [
                { id: 1, type: "一成新" },
                { id: 2, type: "二成新" },
                { id: 3, type: "三成新" },
                { id: 4, type: "四成新" },
                { id: 5, type: "五成新" },
                { id: 6, type: "六成新" },
                { id: 7, type: "七成新" },
                { id: 8, type: "八成新" },
                { id: 9, type: "九成新" },
                { id: 10, type: "十成新" }
            ]
        };
    },
    created() {
        this.getAllBookSubject();
        this.getAllBookType();
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

        getSearchResult() {
            let param1 = {
                ...this.getSearchContent(),
                currentPage: 1,
                pageSize: 10
            };
            console.log(param1);
            this.$axios.post("/book/searchBook", param1).then(resp => {
                // console.log(resp);
                this.setBList(resp.data.data);
                this.setCPage(1);
                this.setPSize(10);
            });

            let param2 = {
                ...this.getSearchContent()
            };

            this.$axios.post("/book/getSearchBookCount", param2).then(resp => {
                console.log(resp.data.data.total);
                this.setAll(resp.data.data.total);
            });
        },
        active1(i, type) {
            this.index1 = i;
            this.first1 = false;
            // console.log(this.index1);
            let searchContent = this.getSearchContent();

            console.log(searchContent);
            searchContent.content = null;
            searchContent.bookType = type;
            // searchContent.currentPage = 1;
            this.setSContent(searchContent);
            this.getSearchResult();
        },

        active2(i, subject) {
            this.index2 = i;
            this.first2 = false;
            // console.log(this.index2);
            let searchContent = this.getSearchContent();
            console.log(searchContent);
            searchContent.content = null;
            searchContent.bookSubject = subject;
            // searchContent.currentPage = 1;
            this.setSContent(searchContent);
            this.getSearchResult();
        },

        active3(i, degree) {
            this.index3 = i;
            this.first3 = false;
            // console.log(this.index3);
            let searchContent = this.getSearchContent();
            console.log(searchContent);
            searchContent.content = null;
            searchContent.bookDegree = degree;
            // searchContent.currentPage = 1;
            this.setSContent(searchContent);
            this.getSearchResult();
        },

        firstActive1() {
            this.index1 = -1;
            this.first1 = true;
            let searchContent = this.getSearchContent();
            console.log(searchContent);
            searchContent.content = null;
            searchContent.bookType = null;
            // searchContent.currentPage = 1;
            this.setSContent(searchContent);
            this.getSearchResult();
        },

        firstActive2() {
            this.index2 = -1;
            this.first2 = true;
            let searchContent = this.getSearchContent();
            console.log(searchContent);
            searchContent.content = null;
            searchContent.bookSubject = null;
            // searchContent.currentPage = 1;
            this.setSContent(searchContent);
            this.getSearchResult();
        },

        firstActive3() {
            this.index3 = -1;
            this.first3 = true;
            let searchContent = this.getSearchContent();
            console.log(searchContent);
            searchContent.content = null;
            searchContent.bookDegree = null;
            // searchContent.currentPage = 1;
            this.setSContent(searchContent);
            this.getSearchResult();
        },

        getAllBookSubject() {
            this.$axios.get("/other/getAllBookSubject").then(resp => {
                // console.log(resp.data.data);
                this.subjectOptions = resp.data.data;
            });
        },

        getAllBookType() {
            this.$axios.get("/other/getAllBookType").then(resp => {
                // console.log(resp.data.data);
                this.typeOptions = resp.data.data;
            });
        }
    }
};
</script>


<style lang="less" scoped>
.option-menu-container {
    background-color: #fff;
    .option-menu-list {
        width: 1160px;
        margin: 0 auto;
        .book-type-option,
        .book-subject-option,
        .book-new-degree {
            width: 100%;
            margin: 0 auto;
            display: inline-flex;
            justify-content: flex-start;
            border-bottom: 1px dashed #ccc;
            color: rgb(141, 137, 137);
        }
        .option-title {
            span {
                line-height: 50px;
            }
        }

        .option-list {
            list-style: none;
            display: flex;
            justify-content: flex-start;

            .optionActive {
                color: rgb(255, 86, 199);
            }

            .first-option-item {
                padding-top: 4px;
                width: 80px;
                cursor: pointer;
            }

            .option-item {
                padding-top: 4px;
                width: 90px;
                cursor: pointer;
            }
        }
    }
}
</style>


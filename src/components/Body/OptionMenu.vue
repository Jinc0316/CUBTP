<template>
    <div class="option-menu-container">
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
                        :class="{optionActive:a==index1}"
                        v-for="(item,a) in typeOptions"
                        :key="a"
                        @click="active1(a)"
                    >{{item.type}}</li>
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
                        @click="active2(i)"
                    >{{item.type}}</li>
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
                        @click="active3(i)"
                    >{{item.type}}</li>
                </ul>
            </div>
        </div>
    </div>
</template>


<script>
export default {
    data() {
        return {
            index1: -1,
            index2: -1,
            index3: -1,
            first1: true,
            first2: true,
            first3: true,
            typeOptions: [
                { id: 1, type: "教材" },
                { id: 2, type: "工具书" },
                { id: 3, type: "娱乐周刊" },
                { id: 4, type: "小说" }
            ],
            subjectOptions: [
                { id: 1, type: "高数" },
                { id: 2, type: "英语" },
                { id: 3, type: "语文" },
                { id: 4, type: "天文" }
            ],
            newDegreeOptions: [
                { id: 1, type: "一成新" },
                { id: 2, type: "二成新" },
                { id: 3, type: "三成新" },
                { id: 4, type: "四成新" }
            ]
        };
    },
    methods: {
        active1(a) {
            this.index1 = a;
            this.first1 = false;
            console.log(this.index1);
        },

        active2(i) {
            this.index2 = i;
            this.first2 = false;
            console.log(this.index2);
        },

        active3(i) {
            this.index3 = i;
            this.first3 = false;
            console.log(this.index3);
        },

        firstActive1() {
            this.index1 = -1;
            this.first1 = true;
        },

        firstActive2() {
            this.index2 = -1;
            this.first2 = true;
        },

        firstActive3() {
            this.index3 = -1;
            this.first3 = true;
        }
    }
};
</script>


<style lang="less" scoped>
.option-menu-container {

    background-color: #fff;

    .book-type-option,
    .book-subject-option,
    .book-new-degree {
        width: 1160px;
        display: inline-flex;
        justify-content: flex-start;
        border-bottom: 1px dashed #ccc;
        color: rgb(141, 137, 137);
    }
    .option-title {
        span {
            line-height: 40px;
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
            width: 140px;
            cursor: pointer;
        }

        .option-item {
            width: 90px;
            cursor: pointer;
        }
    }
}
</style>


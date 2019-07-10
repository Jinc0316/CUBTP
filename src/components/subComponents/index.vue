<template>
    <div class="index">
        <banner-box></banner-box>
        <option-menu></option-menu>
        <book-list></book-list>
    </div>
</template>


<script>

import Banner from "../Body/Banner";
import OptionMenu from "../Body/OptionMenu";
import BookList from "../Body/BookList";

export default {
    data() {
        return {
            
        };
    },
    methods: {},
    components: {
        "banner-box": Banner,
        "option-menu": OptionMenu,
        "book-list": BookList
    }
};
</script>


<style lang="less" scoped>
</style>


<template>
    <div class="home">
        <nav-header></nav-header>
        <banner-box></banner-box>
        <option-menu></option-menu>
        <book-list></book-list>
    </div>
</template>


<script>
import Header from "./Header/Header";
import Banner from "./Body/Banner";
import OptionMenu from "./Body/OptionMenu";
import BookList from "./Body/BookList";

export default {
    data() {
        return {
            
        };
    },
    methods: {},
    components: {
        "nav-header": Header,
        "banner-box": Banner,
        "option-menu": OptionMenu,
        "book-list": BookList
    }
};
</script>


<style lang="less" scoped>
</style>


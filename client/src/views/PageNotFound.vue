<template>
  <div class="">
    <top />
    <div class="not-data text-center">
      404 page
    </div>
  </div>
</template>

<script>
import top from "@/components/top";
export default {
  components: {
    top,
  },
  mounted() {
    this.callFunction();
  },
  methods: {
    callFunction: function() {
      let that = this;
      setTimeout(function() {
        that.goTo("/");
      }, 3000);
    },
    goTo(path) {
      this.$router.push(path);
    },
  },
};
</script>

<style lang="scss" scoped>
.not-data {
  font-size: 100px;
}
</style>

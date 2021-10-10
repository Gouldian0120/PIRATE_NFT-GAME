<template>
  <div>
    <div class="card">
      <div class="card-header text-center text-uppercase">
        <h6>{{ dataItem.title }}</h6>
        <p class="text-danger"><h6>{{ dataItem.bottomText }}</h6></p>
      </div>
      <div class="card-body">
        <img src="https://picsum.photos/400/200" style="padding:10px;" alt="" width="100%" class="img-fluid" />
        <div class="d-flex justify-content-between reward-div text-uppercase">
          <div class="reward">
            <p align="center "  >Rewards</p>
            <p align="center">0.00 Token</p>
          </div>
          <div>
            <p align="center">Success Rate</p>
            <p align="center">90%</p>
          </div>
        </div>
        <div class="d-flex justify-content-center">
          <button href="#" class="btn  m-2 text-white text-uppercase green-style">
            explore
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["dataItem"],
};
</script>

<style lang="scss" scoped>
.green-style {
  background-color: green !important;
  border: 1px solid greenyellow;
  border-radius: 0px;
}

.text-danger {
  font-weight: bold;
}

.reward-div {
  font-weight:500;
}
</style>

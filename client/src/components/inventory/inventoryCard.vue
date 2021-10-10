<template>
  <div>
    <div class="card">
      <div class="card-header">
        <h6 class=" text-center rounded p-1 idStyle" :class="getStyleClass">
          #{{ dataItem.id }}
        </h6>
      </div>
      <div class="card-body">
        <div class="row g-0">
            <img
            style="padding:10px;"
            src="https://picsum.photos/400/400"
            alt=""
            class="img-fluid col-md-10 col-10 col-lg-10"
          />
          <div class="col-md-2 col-2 col-lg-2">
            <div
              class="d-flex flex-column justify-content-center align-items-center"
            >
              <i class="fas fa-cart-plus m-2 "></i>
              <i class="fas fa-gift m-2 "></i>
              <i class="fas fa-trash m-2 "></i>
            </div>
          </div>
        </div>
        <div v-if=" this.subItem === 'Piratas'" class="text-center m-1 custom-border">
          <p>Contract Expires in 15 Days</p>
        </div>
        <div v-if=" this.subItem === 'Items'" class="text-center m-1 custom-border">
          <p>INCREASE DP + 2%</p>
        </div>
        <div
          v-if=" this.subItem === 'Ships' || this.subItem === 'Piratas'"
          class="d-flex justify-content-between reward-div text-uppercase mb-4"
        >
          <span v-if=" this.subItem === 'Ships'" class="custom-border">2 % DP</span>
          <span v-if=" this.subItem === 'Ships'" class="custom-border">1 PIRATAS</span>
          <span v-if=" this.subItem === 'Piratas'" class="custom-border">{{ dataItem.ap }}AP</span>
          <span v-if=" this.subItem === 'Piratas'" class="custom-border">{{ dataItem.midval }}</span>
          <span v-if=" this.subItem === 'Piratas'" class="custom-border">{{ dataItem.time }}</span>
         </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["dataItem", "subItem"],
  computed: {
    getStyleClass() {
      return this.dataItem.color + "-style";
    },
  },
};
</script>

<style lang="scss" scoped>
.green-style {
  background-color: green !important;
  border: 1px solid greenyellow;
  border-radius: 0px;
}

.cyan-style {
  background-color: cornflowerblue !important;
  border: 1px solid cyan;
  border-radius: 0px;
}

.pink-style {
  background-color: palevioletred !important;
  border: 1px solid pink;
  border-radius: 0px;
}

.idStyle {
  width: 80px;
  height: 30px;
  border-radius: 0px;
}
</style>

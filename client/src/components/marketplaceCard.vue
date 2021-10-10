<template>
  <div class="card">
    <div class="card-header">
      <h6
        class="bg-primary text-center rounded p-1 green-style "
        style="width:80px"
      >
        #00000
      </h6>
    </div>
    <div class="card-body">
      <img
        src="https://picsum.photos/400/400"
        alt=""
        style="padding:10px;"
        width="100%"
        class="img-fluid"
      />
      <div v-if=" this.subItem === 'Piratas'" class="text-center m-2 custom-border"> 
        <p>Contract Expires in 15 Days</p>
      </div>
      <div v-if=" this.subItem === 'Items'" class="text-center m-2 custom-border">
        <p>Increase AP + 20</p>
      </div>
      <div
        class=" d-flex justify-content-between reward-div text-uppercase"
      >
        <span v-if=" this.subItem === 'Ships'" class="custom-border">2% DP</span>
        <span v-if=" this.subItem === 'Ships'" class="custom-border">1 PIRATAS</span>
        <span v-if=" this.subItem === 'Piratas'" class="custom-border">250 AP</span>
        <span v-if=" this.subItem === 'Piratas'" class="custom-border text-center" style="width:30%">1</span>
      </div>
      <div class="d-flex justify-content-center">
        <button
          class=" text-white text-uppercase  green-style token-style"
        >
          <i class="fas fa-cart-plus m-2 p-1 "></i>0.00 TOKEN
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["dataItem", "subItem"],
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

.fas {
  border-style: none;
}
</style>

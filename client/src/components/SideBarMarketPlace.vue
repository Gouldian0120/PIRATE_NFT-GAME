<template>
  <div class="col-md-2 sidebar">
    <div class="ml-2 mb-4 d-flex align-items-center">
      <h6 class="text-white  mr-4">
        FILTER
      </h6>
      <button class="clearFilter text-white">
        Clear Filter
      </button>
    </div>
    <div class="ml-2 mb-4 d-flex align-items-center">
      <input
        type="text"
        class="clearFilter text-white"
        style="width: 100%;"
        placeholder="ID"
      />
    </div>
    <div class="ml-2 mb-4 d-flex align-items-center ">
      <select class="form-select text-white clearFilter" placeholder="ID">
        <option selected class="">Lowest Price</option>
        <option value="1" class=" text-black">One</option>
        <option value="2" class=" text-black">Two</option>
        <option value="3" class=" text-black">Three</option>
      </select>
    </div>
    <div class="ml-2 mb-4 d-flex align-items-center ">
      <h6 class="text-white">
        RARITY
      </h6>
    </div>
    <div class="ml-2 mb-4 d-flex align-items-center ">
      <button
        type="button"
        class="text-white"
        style="background-color: #4CAF50; padding:4px; width: 50%; font-size:14px"
      >
      &nbsp;&nbsp;Common&nbsp;&nbsp;
      </button>
      <button
        type="button"
        class="text-white ml-2"
        style="background-color: #00FFFF; padding:4px; width: 50%; font-size:14px"
      >
        Uncommon
      </button>
    </div>
    <div class="ml-2 mb-4 d-flex align-items-center ">
      <button
        type="button"
        class="text-white"
        style="background-color: #FFD700; padding:4px; width: 50%; font-size:14px"
      >
        Rare
      </button>
      <button
        type="button"
        class="text-white ml-2"
        style="background-color: #9370DB; padding:4px; width: 50%; font-size:14px"
      >
        Epic
      </button>
    </div>
    <div class="ml-2 mb-4 d-flex align-items-center ml-13">
      <button
        type="button"
        class="text-white "
        style="background-color: #FF00FF; padding:4px;  width: 100px;"
      >
        Legendary
      </button>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style lang="scss" scoped>
.form-select {
  background-color: transparent;
}
::placeholder {
  color: white;
}
.optionClass {
  background-color: red($color: #000000);
}
button.clearFilter {
  padding: 4px;
  position: relative;
  border: 1px solid #42465b;
  width:100%
}
</style>

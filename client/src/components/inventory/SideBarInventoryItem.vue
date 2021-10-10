<template>
  <div class="col-md-2 sidebar ">
    <div class="d-flex flex-column text-white sidebar-inner text-center">
      <h6 class="text-center text-uppercase mb-4 status">Your Stats</h6>
      <div class="attack">
        <p class="text-uppercase">
          Current Items
        </p>
        <p class="p-1 red-style">8 / 10</p>
      </div>
      <div class="attack">
        <p class="text-uppercase">
          Max Items
        </p>
        <p class="p-1 red-style">8 / 10</p>
      </div>
      <div class="attack">
        <p class="mt-4 text-uppercase">
          Increase Ships
        </p>
        <p class="p-1 red-style">+ 2</p>
      </div>
      <div class="attack">
        <p class="mt-4 text-uppercase">
          Increase Piratas
        </p>
        <p class="p-1 red-style">+ 2</p>
      </div>
      <div class="attack">
        <p class="mt-4 text-uppercase">
          Increase Attack Power
        </p>
        <p class="p-1 red-style">+ 100</p>
      </div>
      <div class="attack">
        <p class="mt-4 text-uppercase">
          Increase Defense Power
        </p>
        <p class="p-1 red-style">3 % DP</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style lang="scss" scoped>
.green-style {
  color: white !important;
  border: 1px solid greenyellow !important;
  background-color: green !important;
}

.pink-style {
  color: white !important;
  background-color: rgb(138, 73, 190) !important;
}

.red-style {
  color: white !important;
  background-color:#dc3545ed;
}

.attack {
  font-size: 14px;
}
</style>

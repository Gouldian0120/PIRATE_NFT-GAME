<template>
 <div class="col-md-2 sidebar">
    <div class="d-flex flex-column text-white sidebar-inner text-center">
      <h6 class="text-center text-uppercase mb-4 status">
        Your Status
      </h6>
      <div class="attack">
        <p>
          Current Attack Power
        </p>
        <span class="p-1 px-4 bg-danger">800AP</span>
      </div>
      <div class="attack">
        <p class="mt-4">
          Current Defence Power
        </p>
        <span class="p-1 px-4 bg-danger">800AP</span>
      </div>
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

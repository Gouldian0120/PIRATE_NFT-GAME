<template>
  <v-app>
    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
export default {
  name: "App",

  data: () => ({
    //
  }),
};
</script>
<style>
.sidebar {
  min-height: 100vh;
  background-color: #28293d;
}
.sidebar-inner {
  border: 1px solid #42465b;
  padding: 10px;
  margin-left: 5px;
}
.sidebar {
  border-right: 1px solid #42465b;
}
.sidebar {
  padding-left: 1.5rem;
  padding-top: 3rem !important;
}
</style>

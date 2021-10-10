import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "explore",
    component: () => import("@/views/module/explore.vue"),
  },
  {
    path: "/marketplace",
    name: "marketplace",
    component: () => import("@/views/module/marketplace.vue"),
  },
  {
    path: "/inventory",
    name: "inventory",
    component: () => import("@/views/module/inventory.vue"),
  },
  { path: "*", component: () => import("@/views/PageNotFound.vue") },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;

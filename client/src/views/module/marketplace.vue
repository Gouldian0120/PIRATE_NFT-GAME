<template>
  <body>
    <top :subItems="subItems" :updateSubitems="updateSubitems" />
    <div class="row">
      <side-bar-market-place />
      <div class="col-md-10 main p-4">
        <div class="row">
          <div class="col-md-3  mb-4" v-for="(item, i) in items" :key="i">
            <marketplace-card :dataItem="item" :subItem="getSelectedSubItem" />
          </div>
        </div>
      </div>
    </div>
  </body>
</template>
<script>
import top from "@/components/top";
import SideBarMarketPlace from "@/components/SideBarMarketPlace";
import marketplaceCard from "@/components/marketplaceCard";
export default {
  components: {
    top,
    SideBarMarketPlace,
    marketplaceCard
  },
  data: () => ({
    subItems: [
      { title: "Ships", active: false },
      { title: "Piratas", active: true },
      { title: "Items", active: false },
    ],
    items: [
      {
        title: "Lost Gold Ford",
        bottomText: "Require 100 app",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "Require 100 app",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "Require 100 app",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "Require 100 app",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "Require 100 app",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "Require 100 app",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "Require 100 app",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "Require 100 app",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "Require 100 app",
      },
    ],
  }),
  methods: {
    updateSubitems(localSubitems) {
      this.subItems = localSubitems;
    },
  },
  computed: {
    getSelectedSubItem() {
      let currentSubItem = "";
      this.subItems.forEach((x, i) => {
        if (x.active) {
          currentSubItem = x.title;
        }
      });
      return currentSubItem;
    },
  },
  mounted() {},
  created() {},
  watch: {
    length(val) {
      this.tab = val - 1;
    },
  },
};
</script>

<style type="text/css">
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}
.card-body {
  flex: 1 1 auto;
  padding: 0rem 0rem;
}

.main p,
h6 {
  margin: 0;
}
.btn-primary {
  text-transform: uppercase;
}
.card-header,
.card-body {
  background-color: #303549;
  color: white;
}
.reward-div {
  padding: 0 15px !important;
  margin-top: 15px;
}
.nav-right span {
  border: 1px solid #42465b;
  padding: 0 10px !important;
}

body {
  background-color: #28293d;
}
.btn-info {
  background-color: #52b326;
  color: white;
  border-radius: 0px;
  border: none !important;
}
.btn-info:hover {
  background-color: #349009;
  color: white;
  border-radius: 0px;
}
.power {
  background-color: red;
}

.card {
  border: 1px solid #42465b;
}
.custom-border {
  border: 1px solid #42465b;
  padding: 10px;
}
.status {
  padding: 10px;
  background-color: #28293d;
  position: relative;
  margin-top: -30px !important;
}
.clearFilter {
  padding: 4px;
  position: relative;
  border: 1px solid #42465b;
}
.green-style {
  background-color: green !important;
  border: 2px solid greenyellow;
  border-radius: 0px;
}
.token-style {
  height: 40px;
  width: 180px;
  margin-bottom: 10px;
  margin-top: 5px;
}
</style>

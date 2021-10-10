<template>
  <body>
    <div>
      <top :subItems="subItems" :updateSubitems="updateSubitems" />
      <div class="row">
        <side-bar-explorer />
        <div class="col-md-10 main p-4">
          <div class="row">
            <div class="col-md-3  mb-4" v-for="(item, i) in items" :key="i">
              <explore-card :dataItem="item" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</template>
<script>
import top from "@/components/top";
import SideBarExplorer from "@/components/SideBarExplorer";
import exploreCard from "@/components/exploreCard";
export default {
  components: {
    top,
    SideBarExplorer,
    exploreCard,
  },
  data: () => ({
    subItems: [{ title: "Islands", active: true }],

    items: [
      {
        title: "Lost Gold Ford",
        bottomText: "LEVEL 1 REQUIRED 100 AP",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "LEVEL 1 REQUIRED 100 AP",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "LEVEL 1 REQUIRED 100 AP",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "LEVEL 1 REQUIRED 100 AP",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "LEVEL 1 REQUIRED 100 AP",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "LEVEL 1 REQUIRED 100 AP",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "LEVEL 1 REQUIRED 100 AP",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "LEVEL 1 REQUIRED 100 AP",
      },
      {
        title: "Lost Gold Ford",
        bottomText: "LEVEL 1 REQUIRED 100 AP",
      },
    ],
  }),
  methods: {
    updateSubitems(localSubitems) {
      this.subItems = localSubitems;
    },
  },
  computed: {},
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
.status {
  padding: 10px;
  background-color: #28293d;
  border: 1px solid #42465b;
  position: relative;
  margin-top: -30px !important;
}
</style>

<template>
  <body>
    <div>
      <top :subItems="subItems" :updateSubitems="updateSubitems" />
      <div class="row">
        <component :is="getSelectedComponent" />
        <div class="col-md-10 main p-4">
          <div class="row">
            <div class="col-md-3  mb-4" v-for="(item, i) in items" :key="i">
              <inventory-card :dataItem="item" :subItem="getSelectedSubItem"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</template>

<script>
import top from "@/components/top";
import inventoryCard from "@/components/inventory/inventoryCard";
import SideBarInventoryItem from "@/components/inventory/SideBarInventoryItem";
import SideBarInventoryPirate from "@/components/inventory/SideBarInventoryPirate";
import SideBarInventoryShip from "@/components/inventory/SideBarInventoryShip";
export default {
  components: {
    top,
    inventoryCard,
    SideBarInventoryItem,
    SideBarInventoryPirate,
    SideBarInventoryShip,
  },
  data: () => ({
    subItems: [
      { title: "Ships", active: true, name: "SideBarInventoryShip" },
      { title: "Piratas", active: false, name: "SideBarInventoryPirate" },
      { title: "Items", active: false, name: "SideBarInventoryItem" },
    ],
    items: [
      {
        id: "00000",
        title: "Contract Expires in 15 Days",
        ap: "250",
        midval: "0",
        time: "07:13",
        color: "green",
      },
      {
        id: "00001",
        title: "Contract Expires in 15 Days",
        ap: "250",
        midval: "0",
        time: "07:13",
        color: "green",
      },
      {
        id: "00002",
        title: "Contract Expires in 15 Days",
        ap: "250",
        midval: "0",
        time: "07:13",
        color: "green",
      },
      {
        id: "00003",
        title: "Contract Expires in 15 Days",
        ap: "250",
        midval: "0",
        time: "07:13",
        color: "cyan",
      },
      {
        id: "00004",
        title: "Contract Expires in 15 Days",
        ap: "250",
        midval: "0",
        time: "07:13",
        color: "green",
      },
      {
        id: "00005",
        title: "Contract Expires in 15 Days",
        ap: "250",
        midval: "0",
        time: "07:13",
        color: "pink",
      },
    ],
  }),
  methods: {
    updateSubitems(localSubitems) {
      this.subItems = localSubitems;
    },
  },
  computed: {
    getSelectedComponent() {
      let currentComponent = "";
      this.subItems.forEach((x, i) => {
        if (x.active) {
          currentComponent = x.name;
        }
      });
      return currentComponent;
    },
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

<style>
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
.fas,
.custom-border {
  border: 1px solid #42465b;
  cursor: pointer;
  padding: 10px;
}
</style>

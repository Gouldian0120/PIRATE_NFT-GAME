<template>
  <div>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark text-white">
      <notification v-if="hasMessage"/>
      <div class="container">
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="true"
          @click="openHeaderMenu"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <!--  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
      </button> -->
        <!-- collapse navbar-collapse -->

        <div
          :class="
            isMobileMenuIcon
              ? 'navbar-collapse navigation collapse in '
              : 'navbar-collapse navigation collapse'
          "
          id="navbarSupportedContent"
        >
          <ul class="navbar-nav mx-auto  mb-4 mb-lg-0">
            <li
              class="nav-item nav-decor"
              :class="getStatus(item) ? 'current' : ''"
              v-for="(item, n) in items"
              :key="n"
            >
              <a
                class="nav-link "
                :class="getStatus(item) ? 'active ' : ''"
                aria-current="page"
                @click="goTo(item.link)"
              >
                {{ item.title }}
              </a>
            </li>
          </ul>
          <div class="Claimsec align-items-center nav-right mr-16 ">
            <span class="me-4 ">Claim reward 100 points</span>
          </div>
          <div class=" connectWalsec nav-right">
            <button v-if="!isMetaMaskConnected" class="btn btn-primary  connectWal " @click="connectWallet">Connect wallet</button>
            <button v-if="isMetaMaskConnected" class="btn btn-primary  connectWal " @click="lockMetamask">Connected Wallet</button>
          </div>
        </div>
      </div>
    </nav>
    <div class="subOptions d-flex align-items-center">
      <a
        v-for="(item, n) in subItemsLocal"
        :key="n"
        class="text-white ml-10 mr-10 subitems"
        :class="item.active ? 'selected' : ''"
        @click="selectSubitems(item)"
      >
        {{ item.title }}
      </a>
    </div>
  </div>
</template>

<script>
import Notification from '../components/notification.vue';
export default {
  components: {
      Notification
  },
  props: ["subItems", "updateSubitems"],
  data: () => ({
    subItemsLocal: [],
    isMobileMenuIcon: false,
    items: [
      {
        title: "Explore",
        link: "/",
      },
      {
        title: "Marketplace",
        link: "/marketplace",
      },
      {
        title: "Inventory",
        link: "/inventory",
      },
      {
        title: "Giuld",
        link: "/guild",
      },
    ],
  }),
  computed: {
    currentRouteName() {
      return this.$route.name;
    },
    isMetaMaskInstalled() {
        const { ethereum } = window;
        return Boolean(ethereum && ethereum.isMetaMask)
    },
    isMetaMaskConnected() {
        return this.$store.state.account!=null;
    },
    hasMessage() {
        return this.$store.state.messageContent!=null
    }
  },
  methods: {
    connectWallet() {                
        this.$store.dispatch("connect")              
    },
    lockMetamask() {
        this.$store.dispatch("disconnect")
    },
    openHeaderMenu: function() {
      console.log("hi");
      let _that = this;
      _that.isMobileMenuIcon = !_that.isMobileMenuIcon;
    },

    getStatus(item) {
      let link = item.link.toLowerCase();
      let path = this.$route.fullPath;
      return link === path;
    },
    goTo(path) {
      this.$router.push(path);
    },
    selectSubitems(item) {
      this.subItemsLocal.forEach((x, i) => (x.active = false));
      item.active = true;
      this.updateSubitems(this.subItemsLocal);
    },
  },
  watch: {
    subItems: {
      immediate: true,
      handler(value) {
        this.subItemsLocal = value;
      },
    },
  },
};
</script>

<style lang="scss" scoped>
.nav-decor {
  margin-left: 10px;
  margin-right: 10px;
}

.current {
  // font-size: 50px;
  // background-color: "#282A3D" !important;
  background-color: #303649 !important;
  padding-left: 10px;
  padding-right: 10px;
  // border: 1px solid white;
}

.selected {
  color: cyan !important;
  background-color: #303649 !important;
  padding-left: 20px;
  padding-right: 20px;
  padding-top: 5px;
  padding-bottom: 5px;
}

.subOptions {
  border-bottom: 1px solid #42465b;
  padding-left: 40px;
  text-transform: capitalize;
  padding: 1rem;
}
.connectWal {
  padding: 8px;
  font-size: 12px;
  /* font-style: bold; */
  height: auto;
}
.subitems {
  text-decoration: none;
  padding-left: 20px;
  padding-right: 20px;
  padding-top: 5px;
  padding-bottom: 5px;
}
.collapse.in {
  display: block;
}
.v-application ul,
.v-application ol {
  padding-left: 0px;
}

@media (max-width: 991px) {
  .nav-decor {
    margin-left: 0;
    margin-top: 10px;
  }
  .connectWalsec {
    display: inline-block;
    float: right;
  }
  .Claimsec {
    display: inline-flex;
  }
}
@media (max-width: 568px) {
  .connectWalsec {
    display: block;
    float: left;
    margin-top: 16px;
  }
}
</style>

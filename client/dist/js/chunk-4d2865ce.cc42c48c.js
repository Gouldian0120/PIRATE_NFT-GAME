(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-4d2865ce"],{"0860":function(t,e,n){"use strict";n("c13d")},1451:function(t,e,n){"use strict";var s=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",[n("nav",{staticClass:"navbar navbar-expand-lg navbar-dark bg-dark text-white"},[t.hasMessage?n("notification"):t._e(),n("div",{staticClass:"container"},[n("button",{staticClass:"navbar-toggler",attrs:{type:"button","data-bs-toggle":"collapse","data-bs-target":"#navbarSupportedContent","aria-controls":"navbarSupportedContent","aria-expanded":"true","aria-label":"Toggle navigation"},on:{click:t.openHeaderMenu}},[n("span",{staticClass:"navbar-toggler-icon"})]),n("div",{class:t.isMobileMenuIcon?"navbar-collapse navigation collapse in ":"navbar-collapse navigation collapse",attrs:{id:"navbarSupportedContent"}},[n("ul",{staticClass:"navbar-nav mx-auto  mb-4 mb-lg-0"},t._l(t.items,(function(e,s){return n("li",{key:s,staticClass:"nav-item nav-decor",class:t.getStatus(e)?"current":""},[n("a",{staticClass:"nav-link ",class:t.getStatus(e)?"active ":"",attrs:{"aria-current":"page"},on:{click:function(n){return t.goTo(e.link)}}},[t._v(" "+t._s(e.title)+" ")])])})),0),t._m(0),n("div",{staticClass:" connectWalsec nav-right"},[t.isMetaMaskConnected?t._e():n("button",{staticClass:"btn btn-primary  connectWal ",on:{click:t.connectWallet}},[t._v("Connect wallet")]),t.isMetaMaskConnected?n("button",{staticClass:"btn btn-primary  connectWal ",on:{click:t.lockMetamask}},[t._v("Connected Wallet")]):t._e()])])])],1),n("div",{staticClass:"subOptions d-flex align-items-center"},t._l(t.subItemsLocal,(function(e,s){return n("a",{key:s,staticClass:"text-white ml-10 mr-10 subitems",class:e.active?"selected":"",on:{click:function(n){return t.selectSubitems(e)}}},[t._v(" "+t._s(e.title)+" ")])})),0)])},a=[function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"Claimsec align-items-center nav-right mr-16 "},[n("span",{staticClass:"me-4 "},[t._v("Claim reward 100 points")])])}],i=(n("b0c0"),n("9911"),n("159b"),function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"notification-slot"})}),o=[],c={name:"notification",mounted:function(){this.$store.state.messageType&&this.$store.state.messageContent&&this.$toast[this.$store.state.messageType](this.$store.state.messageContent,{position:"top-right",timeout:5e3,closeOnClick:!0,pauseOnFocusLoss:!0,pauseOnHover:!0,draggable:!0,draggablePercent:.6,showCloseButtonOnHover:!1,hideProgressBar:!0,closeButton:!1,icon:!0,rtl:!1}),this.$store.state.messageType=null,this.$store.state.messageContent=null}},r=c,l=(n("9157"),n("2877")),u=Object(l["a"])(r,i,o,!1,null,"46f16d4d",null),d=u.exports,m={components:{Notification:d},props:["subItems","updateSubitems"],data:function(){return{subItemsLocal:[],isMobileMenuIcon:!1,items:[{title:"Explore",link:"/"},{title:"Marketplace",link:"/marketplace"},{title:"Inventory",link:"/inventory"},{title:"Giuld",link:"/guild"}]}},computed:{currentRouteName:function(){return this.$route.name},isMetaMaskInstalled:function(){var t=window,e=t.ethereum;return Boolean(e&&e.isMetaMask)},isMetaMaskConnected:function(){return null!=this.$store.state.account},hasMessage:function(){return null!=this.$store.state.messageContent}},methods:{connectWallet:function(){this.$store.dispatch("connect")},lockMetamask:function(){this.$store.dispatch("disconnect")},openHeaderMenu:function(){console.log("hi");var t=this;t.isMobileMenuIcon=!t.isMobileMenuIcon},getStatus:function(t){var e=t.link.toLowerCase(),n=this.$route.fullPath;return e===n},goTo:function(t){this.$router.push(t)},selectSubitems:function(t){this.subItemsLocal.forEach((function(t,e){return t.active=!1})),t.active=!0,this.updateSubitems(this.subItemsLocal)}},watch:{subItems:{immediate:!0,handler:function(t){this.subItemsLocal=t}}}},p=m,f=(n("394b"),Object(l["a"])(p,s,a,!1,null,"592e31c4",null));e["a"]=f.exports},"394b":function(t,e,n){"use strict";n("81a6")},"5f02":function(t,e,n){},"81a6":function(t,e,n){},9157:function(t,e,n){"use strict";n("5f02")},9911:function(t,e,n){"use strict";var s=n("23e7"),a=n("857a"),i=n("af03");s({target:"String",proto:!0,forced:i("link")},{link:function(t){return a(this,"a","href",t)}})},a5b5:function(t,e,n){"use strict";n.r(e);var s=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{},[n("top"),n("div",{staticClass:"not-data text-center"},[t._v(" 404 page ")])],1)},a=[],i=n("1451"),o={components:{top:i["a"]},mounted:function(){this.callFunction()},methods:{callFunction:function(){var t=this;setTimeout((function(){t.goTo("/")}),3e3)},goTo:function(t){this.$router.push(t)}}},c=o,r=(n("0860"),n("2877")),l=Object(r["a"])(c,s,a,!1,null,"2d439efa",null);e["default"]=l.exports},c13d:function(t,e,n){}}]);
//# sourceMappingURL=chunk-4d2865ce.cc42c48c.js.map
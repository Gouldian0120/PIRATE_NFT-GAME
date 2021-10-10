import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    account: null,
    messageContent: null,
    messageType: null,
  },
  mutations: {
    show_success(state,message) {
      state.messageContent = message
      state.messageType = 'success'
    },
    set_account(state,account) {
      state.account = account      
    },
  },
  actions: {
    connect({commit}) {
      window.ethereum.request({ 
        method: 'eth_requestAccounts' 
      }).then((accounts) => {
          if(accounts.length==0) {
              console.log("No connected");
          } else {
            window.ethereum.request({
              method: 'wallet_switchEthereumChain',
              params: [{ chainId: '0x61' }],
            }).then(() => {
              console.log("wallet_switchEthereumChain")
              const account = {
                address: accounts[0],
                //balance: BigNumber(balance,"ether")
              }
//            commit('show_success','Connected')
            commit('set_account',account)
            }).catch(error => {
              console.log("error:wallet_switchEthereumChain",error)
              if (error.code==4902 || error.code==-32603) {
                window.ethereum.request({
                  method: 'wallet_addEthereumChain',
                  params: [{ 
                    chainId: '0x61', 
                    chainName: 'Smart Chain - Testnet',
                    rpcUrls: ['https://data-seed-prebsc-1-s1.binance.org:8545/'],
                    blockExplorerUrls: ['https://testnet.bscscan.com'],
                    nativeCurrency: {
                      name: 'Smart Chain',
                      symbol: 'BNB',
                      decimals: 18
                    }
                  }],
                }).then(() => {
                  const account = {
                    address: accounts[0],
                    //balance: BigNumber(balance,"ether")
                  }
                }).catch(() => {
                  console.log("error:wallet_switchEthereumChain")
                });
              }
            });
          }
      }).catch((err) => {
        if (err.code === 4001) {
          console.log('Please connect to MetaMask.');
        } else {
          console.error(err);
        }
      });  
    },
    disconnect({state}) {
      state.account = null
    },
  },
  modules: {
  }
})

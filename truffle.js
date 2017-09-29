// Allows us to use ES6 in our migrations and tests.
require('babel-register')

const HDWalletProvider = require("truffle-hdwallet-provider")
let mnemonic = 'drum wedding snow tide elephant impose face around quote will clerk review'


module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },

    rinkeby: {
    	provider: new HDWalletProvider(mnemonic, "https://rinkeby.infura.io"),
    	network_id: "4",
    	gas: 4500000,
    	gasPrice: 25000000000
    }
  }
};

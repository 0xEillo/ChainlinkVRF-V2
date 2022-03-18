require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

// Go to https://www.alchemyapi.io, sign up, create
// a new App in its dashboard, and replace "KEY" with its key
const ALCHEMY_URL = process.env.ALCHEMY_URL;

// Replace this private key with your Ropsten account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Be aware of NEVER putting real Ether into testing accounts
const RINKEBY_PRIVATE_KEY = process.env.RINKEBY_PRIVATE_KEY;

module.exports = {
  solidity: "0.8.12",
  networks: {
    rinkeby: {
      url: ALCHEMY_URL,
      accounts: [`${RINKEBY_PRIVATE_KEY}`]
    }
  }
};
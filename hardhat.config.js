require("dotenv").config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("hardhat-test-utility")();
// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});
const { PRIVATE_KEY, INFURA_KEY, ETHERSCAN_KEY } = process.env;
const getHDWallet = () => {
  if (PRIVATE_KEY !== "") {
    return [PRIVATE_KEY]
  }
  throw Error("Private Key Not Set! Please set up .env");
}

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  networks: {
    rinkeby: { 
      url: "https://rinkeby.infura.io/v3/28b00c59a9334b749a81fbd27bd96343",
      accounts: ["1b40ed37e7bb55dfd5a929ef57458137c6ce6b6b978c508260432deca5be5580"],
    },
    ropsten: { 
      url: "https://ropsten.infura.io/v3/28b00c59a9334b749a81fbd27bd96343",
      accounts: ["1b40ed37e7bb55dfd5a929ef57458137c6ce6b6b978c508260432deca5be5580"],
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: `${ETHERSCAN_KEY}`
  },
  solidity: "0.8.7",
};

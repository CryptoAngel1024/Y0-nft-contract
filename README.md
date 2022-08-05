# This is NFT mint smart contract based on ERC721A

How to configurate ERC721A smart contract project in hardhat

1. Create a new hardhat project.
2. Install modules which need to run smart contract.(You can read hardhat doc to create new hardhat project.)
3. Please copy and past ERC721A.sol file to new project( You can get ERC721.sol file from online(Azuki NFT))
4. Build NFT smart contract using ERC721A.sol instead of ERC721.sol.
5. Make .env file to deploy smart contract on the testnet or mainnet
    - INFURA ID (https://infura.io/)
    - PRIVATE KEY (From your wallet)
    - BASE URI (You can use Pinata, IPFS, NFT.storage)
6. Configurate hardhat.config.js and deploy file
7. Deploy smart contract on Testnet or Mainnet using below command.
8. Verify Smart contract on Testnet or Mainnet Etherscan.(You can verify Etherscan or hardhat module)
9. Catch contact address and ABI file to integrate with frontend


Node command

    npm run deploy  // "npx hardhat run scripts/deploy.js --network rinkeby",
    npm run build   // "hardhat compile",


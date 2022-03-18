const CHAINLINK_SUBSCRIPTION_ID = process.env.CHAINLINK_SUBSCRIPTION_ID;

async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("Deploying contracts with the account:", deployer.address);
  
    console.log("Account balance:", (await deployer.getBalance()).toString());
  
    const RandomNumber = await ethers.getContractFactory("RandomNumber");
    const randomNumber = await RandomNumber.deploy(CHAINLINK_SUBSCRIPTION_ID);
  
    console.log("RandomNumber contract address:", randomNumber.address);

    await randomNumber.addConsumer(randomNumber.address);
    await randomNumber.getRandomNumbers();
    let randomNumberArray = await randomNumber.randomNumbers();
    console.log(randomNumberArray);
    

  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
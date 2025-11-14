const hre = require("hardhat");

async function main() {
  console.log("Deploying GuessTheNumber challenge...");
  
  const GuessTheNumber = await hre.ethers.getContractFactory("GuessTheNumberChallenge");
  
  const challenge = await GuessTheNumber.deploy({ 
    value: hre.ethers.parseEther("0.00001")
  });
  
  await challenge.waitForDeployment();
  
  const address = await challenge.getAddress();
  console.log("Challenge deployed to:", address);
  console.log("View on Etherscan:", `https://sepolia.etherscan.io/address/${address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
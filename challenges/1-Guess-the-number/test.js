const hre = require("hardhat");

async function main() {
  const challengeAddress = "0xC573eC98d4fB6C4297b69a0957c41163d2b3b335";
  
  console.log("Testing GuessTheNumber challenge...");
  console.log("Challenge address:", challengeAddress);
  
  const challenge = await hre.ethers.getContractAt("GuessTheNumberChallenge", challengeAddress);
  
  console.log("\nGuessing the number: 42");
  const tx = await challenge.guess(42, { 
    value: hre.ethers.parseEther("0.00001")
  });
  console.log("Transaction sent:", tx.hash);
  
  await tx.wait();
  console.log("Transaction confirmed!");
  
  const isComplete = await challenge.isComplete();
  console.log("Challenge complete:", isComplete);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
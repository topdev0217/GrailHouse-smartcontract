const hre = require("hardhat");

async function main() {
  const GrailHouse = await hre.ethers.getContractFactory("GrailHouse");
  const _GrailHouse = await GrailHouse.deploy();

  await _GrailHouse.deployed();

  console.log("GrailHouse deployed to:", _GrailHouse.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

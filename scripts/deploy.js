// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const { ethers } = require("hardhat");

async function main() {
  // Obtén la cuenta que desplegará el contrato
  const [deployer] = await ethers.getSigners();
  console.log("Desplegando el contrato con la cuenta:", deployer.address);

  // Compila el contrato
  const Contract = await ethers.getContractFactory("Messages");
  const contract = await Contract.deploy();

  await contract.waitForDeployment();

  // Imprime la dirección del contrato
  console.log("Contrato desplegado en la dirección: " + contract.target);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
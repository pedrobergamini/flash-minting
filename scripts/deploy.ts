// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";
import { FlashWETH__factory, FlashMinter__factory } from "../typechain";

async function main(): Promise<void> {

  const FlashWETH = (await ethers.getContractFactory("FlashWETH")) as FlashWETH__factory;
  const flashWeth = await FlashWETH.deploy();
  await flashWeth.deployed();

  console.log(`Flash Wrapped Ether deployed to: ${flashWeth.address}`);

  const FlashMinter = (await ethers.getContractFactory("FlashMinter")) as FlashMinter__factory;
  const flashMinter = await FlashMinter.deploy();

  console.log(`Flash Minter deployed to: ${flashMinter.address}`);

  const tx = await flashWeth.flashMint(flashMinter.address, ethers.BigNumber.from(ethers.utils.parseEther("100")), []);
  await tx.wait();

  const amountBorrowed = await flashMinter.totalBorrowed();

  console.log(`Flash minted amount: ${amountBorrowed}`);
}

main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });

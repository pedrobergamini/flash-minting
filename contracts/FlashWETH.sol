// SPDX-License-Identifier: MIT

pragma solidity 0.7.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./interfaces/IFlashMinter.sol";

contract FlashWETH is ERC20("Flash Wrapped Ether", "fWETH") {
    using SafeMath for uint256;

    receive() external payable {
        deposit();
    }

    function deposit() public payable {
        _mint(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        _burn(msg.sender, amount);
        msg.sender.transfer(amount);
    }

    function flashMint(
        address receiver,
        uint256 amount,
        bytes calldata data
    ) external {
        IFlashMinter flashMinter = IFlashMinter(receiver);
        // uint256 fee = amount.mul(.97e6).div(1e6);

        _mint(receiver, amount);
        flashMinter.onFlashMint(msg.sender, amount, data);
        // _burn(msg.sender, amount.add(fee));
        _burn(receiver, amount);
    }
}

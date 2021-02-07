// SPDX-License-Identifier: MIT

pragma solidity 0.7.4;

import "hardhat/console.sol";
import "./interfaces/IFlashMinter.sol";

contract FlashMinter is IFlashMinter {
    uint256 public totalBorrowed;
    address private immutable _controller;

    constructor() {
        _controller = msg.sender;
    }

    function onFlashMint(
        address sender,
        uint256 amount,
        bytes calldata data
    ) external override {
        require(sender == _controller);
        totalBorrowed += amount;
    }
}

// SPDX-License-Identifier: MIT

pragma solidity 0.7.4;

interface IFlashMinter {
    function onFlashMint(
        address sender,
        uint256 amount,
        bytes calldata data
    ) external;
}

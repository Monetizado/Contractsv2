// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MonetizadoLibrary {
    struct Content {
        string name;
        uint256 cost;
        uint256 sequenceId;
        address creator;
        uint256 amountAvailable;
        uint256 totalAmount;
        mapping(address => bool) subscribers;
    }
}
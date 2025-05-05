// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./MonetizadoLibrary.sol";

contract Monetizado {
    struct Content {
        string name;
        uint256 cost;
        uint256 sequenceId;
        address creator;
        uint256 amountAvailable;
        uint256 totalAmount;
    }

    mapping(address => MonetizadoLibrary.Content[]) private contents;

    function add(string memory name, uint256 cost) public returns (uint256) {
        uint256 qtyPages = contents[msg.sender].length;
        MonetizadoLibrary.Content[] storage ps = contents[msg.sender];
        MonetizadoLibrary.Content storage p = ps.push();
        p.name = name;
        p.cost = cost;
        p.sequenceId = qtyPages;
        p.creator = msg.sender;
        return qtyPages;
    }

    function getContentsCreator() public view returns (Content[] memory) {
        uint256 qtyPages = contents[msg.sender].length;
        Content[] memory ps = new Content[](qtyPages);
        for (uint256 i = 0; i < qtyPages; i++) {
            MonetizadoLibrary.Content storage p = contents[msg.sender][i];
            ps[i] = Content(p.name, p.cost, p.sequenceId, p.creator, p.amountAvailable, p.totalAmount);
        }
        return ps;
    }

    function getContent(address creator, uint256 sequenceId) public view returns (Content memory) {
        MonetizadoLibrary.Content storage p = contents[creator][sequenceId];
        Content memory ps = Content(p.name, p.cost, p.sequenceId, p.creator, p.amountAvailable, p.totalAmount);
        return ps;
    }

    function pay(address creator, uint256 sequenceId) external payable {
        MonetizadoLibrary.Content storage p = contents[creator][sequenceId];
        require(msg.value == p.cost, "Incorrect payment amount");
        p.subscribers[msg.sender] = true;
        p.totalAmount += msg.value;
        p.amountAvailable += msg.value;
    }

    function hasAccess(address creator, uint256 sequenceId) public view returns(bool) {
        return contents[creator][sequenceId].subscribers[msg.sender];
    }

    function withdraw(uint256 sequenceId, uint256 amount) external {
        require(contents[msg.sender][sequenceId].amountAvailable >= amount, "Insufficient balance");
        contents[msg.sender][sequenceId].amountAvailable -= amount;
        payable(msg.sender).transfer(amount);
    }
}
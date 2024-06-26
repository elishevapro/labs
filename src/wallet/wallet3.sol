//SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Collectors {
    // Array memory cost cheapper than mapping memory, cause array allocated in memory while mapping not stored directly there
    // loop in extremely expensive
    // get variable - from state variable is cheapper than from array/mapping
    // set variable - equal in mapping, array and state variable
    // since all of that, I decided to use 3 state variables instead of mapping/array
    address payable public owner;
    address public collector1;
    address public collector2;
    address public collector3;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier isOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    receive() external payable {
        require(msg.sender.balance - msg.value >= 0, "don't have enough amount");
    }

    function deposit() public payable {
        payable(address(this)).transfer(msg.value);
    }
    // if i use a parameter, i get an error(with msg.value), why??????????
    // what is the difference between parameter and msg.value?????????
    // i relized that for deposit- you need to use msg.value
    // and for withdraw - you need to use a parameter.
    // but I don't understand clearly why' and what is the differences between them.

    function withdraw(uint256 amount) external payable returns (uint256) {
        require(
            msg.sender == owner || msg.sender == collector1 || msg.sender == collector2 || msg.sender == collector3,
            "not allowed"
        );
        require(address(this).balance >= amount, "no money");
        payable(msg.sender).transfer(amount);
        return address(this).balance;
    }

    function addCollector(address newCollector) public isOwner returns (bool) {
        require(
            !(newCollector == collector1 || newCollector == collector2 || newCollector == collector3),
            "this collector is allowed yet"
        );
        bool success = false;
        if (collector1 == address(0)) {
            collector1 = newCollector;
            success = true;
        } else if (collector2 == address(0)) {
            collector2 = newCollector;
            success = true;
        } else if (collector3 == address(0)) {
            collector3 = newCollector;
            success = true;
        }
        require(success, "couldn't add collector");
        return success;
    }

    function removeCollector(address collector) public isOwner returns (bool) {
        bool success = false;
        if (collector1 == collector) {
            collector1 = address(0);
            success = true;
        } else if (collector2 == collector) {
            collector2 = address(0);
            success = true;
        } else if (collector3 == collector) {
            collector3 = address(0);
            success = true;
        }
        require(success, "couldn't remove collector");
        return success;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

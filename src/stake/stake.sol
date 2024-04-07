//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract Stake is ERC20{
    address public owner;
    uint public totalReward;
    uint public totalStaked;
    mapping(address=>uint) public stakedAmounts;
    mapping(address=>uint) public beginDates;
    constructor() {
        totalReward = 1000000;
        owner = msg.sender;
        // address(this).balance+=1000;??????????
    }
    receive() external payable {
        require(msg.sender.balance>=msg.value, "not enough money");
    }
    function stake() external payable{
        require(msg.value>0, "must be positive amount");
        stakedAmounts[msg.sender] += msg.value;
        beginDates[msg.sender] = block.timestamp;
        totalStaked+=msg.value;
        payable(address(this)).transfer(msg.value);
    }
    function withdraw() external {
        require(stakedAmounts[msg.sender]>0,"you didn't stake anything");
        uint beginDate = beginDates[msg.sender];
        uint dayPassed = (block.timestamp-beginDate)/60/60/24;
        require(dayPassed >= 7, string(abi.encodePacked("Your money is still locked.")));
        uint reward = totalReward * ( stakedAmounts[msg.sender]/totalStaked);
        payable(msg.sender).transfer(stakedAmounts[msg.sender]+reward);
    }
    function getBalance() public returns (uint) {
        return address(this).balance;
    }
    function stakedAmount() public returns (uint) {
        return stakedAmounts[msg.sender];
    }
}
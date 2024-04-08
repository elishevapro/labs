//SPDX-License-Idntifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/ERC20/ERC20.sol";
import "@openzeppelin/ERC20/extensions/ERC20Permit.sol";
contract MyERC20 is ERC20, ERC20Permit {
    address public owner;
    uint public totalReward;
    uint public totalStaked;
    mapping(address=>uint) public stakedAmounts;
    mapping(address=>uint) public beginDates;
    constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken")  {
        totalReward = 1000000000;
        owner = msg.sender;
        _mint(address(this), totalReward);
    }
    receive() external payable {
        require(msg.sender.balance>=msg.value, "not enough money");
    }
    function send(address to, uint amount) external {
        _mint(to, amount);
    }
    function stake() external payable{
        require(msg.value>0, "must be positive amount");
        stakedAmounts[msg.sender] += msg.value;
        beginDates[msg.sender] = block.timestamp;
        //console.log(block.timestamp);
        totalStaked+=msg.value;
        payable(address(this)).transfer(msg.value);
    }
    function withdraw() external {
        require(stakedAmounts[msg.sender]>0,"you didn't stake anything");
        uint beginDate = beginDates[msg.sender];
        uint dayPassed = (block.timestamp-beginDate)/60/60/24;
        require(dayPassed >= 7, string(abi.encodePacked("Your money is still locked.")));
        uint reward = totalReward * ( stakedAmounts[msg.sender]/totalStaked);
        _mint(address(this), reward);
        payable(msg.sender).transfer(stakedAmounts[msg.sender]+reward);
    }
    function getBalance() public returns (uint) {
        return address(this).balance;
    }
    function stakedAmount() public returns (uint) {
        return stakedAmounts[msg.sender];
    }
}
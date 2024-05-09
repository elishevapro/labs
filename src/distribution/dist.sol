//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract Distribute{
    address[] public addressess;
    constructor(address[] a) {
        addressess = a;
    }
    modifier onlyOwner() {
        require(msg.sender==owner,"Not owner");
        _;
    }
    // receive() external payable {
    // } 
    fallback() external payable{
        require(address(this).balance>=msg.value,"no money");
        uint aPerAdd = msg.value/addressess.length;
        for(uint i=0;i<,addressess.length;i++){
            payable(addressess[i]).transfer(aPerAdd);
        }
    }
}
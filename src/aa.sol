//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/ERC20/IERC20.sol"
contract Distribute{
    address[] public addressess;
    constructor(address[] a) {
        addressess = a;
    }
    modifier onlyOwner() {
        require(msg.sender==owner,"Not owner");
        _;
    }
    receive() external payable {
    } 
    function public distribution(uint amount, IERC20 token) onlyOwner{
        require(token.balanceOf(address(this))>=amount,"no money");
        uint aPerAdd = amount/addressess.length;
        for(uint i=0;i<,addressess.length;i++){
            token.transfer(addressess[i],aPerAdd);
        }
    }
}
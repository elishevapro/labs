//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/ERC20/IERC20.sol";

contract Distribute {
    address[] public addressess;
    address owner;
    // constructor(address[] a) {
    //     addressess = a;
    // }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    receive() external payable {}

    function distribution(uint256 amount, IERC20 token) public onlyOwner {
        require(token.balanceOf(address(this)) >= amount, "no money");
        uint256 aPerAdd = amount / addressess.length;
        for (uint256 i = 0; i < addressess.length; i++) {
            token.transfer(addressess[i], aPerAdd);
        }
    }
}

//SPDX-Lisence-Identifier: MIT
pragma solidity ^0.8.21;
import "@openzeppelin/ERC20/IERC20.sol";
contract AMM1{
    address public owner;
    IERC20 immutable public tokenA;
    IERC20 immutable public tokenB;
    uint public amountA;
    uint public amountB;
    modifier onlyOwner() {
        require(msg.sender == owner,"only owner");
        _;
    }
    constructor public(IERC20 tA, IERC20 tB, uint aA, uint aB){
        owner = msg.sender;
        tokenA = IERC20(tA);
        tokenB = IERC20(tB);
        initialize(aA,aB);
    }
    function initialize(uint initializeA, uint initializeB) private{
        amountA = initializeA;
        amountB = initializeB;
    } 
}
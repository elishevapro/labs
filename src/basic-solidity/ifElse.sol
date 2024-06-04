pragma solidity ^0.8.19;

contract IfElse {
    function foo(uint x) public pure returns (uint) {
        if (x < 10)
            return 1;
        else if (x < 20) 
            return 2;
        else
            return 3;
    }
    function ternary(uint x) public pure returns (uint) {
        return x > 10 ? 1 : 2;
    }
}
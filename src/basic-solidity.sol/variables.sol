pragma solidity ^0.8.19;

contract Variables {
    //state - stored to the blockchain
    string public text = "Hello";
    uint public num = 123;
    function doSomething() public {
        // local
        uint num1 = 34;
        // global - show info from the blockchain
        uint num2 = block.timestamp;
        address addr = msg.sender;
    }
}
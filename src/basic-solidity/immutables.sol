pragma solidity ^0.8.19;

contract Immutables {
    uint public immutable MY_UINT;
    address public immutable OWNER;
    constructor(uint myUint) {
        MY_UINT = myUint;
        OWNER = msg.sender;
    }
}
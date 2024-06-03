pragma solidity ^0.8.19;

contract SimpleStorage {
    uint private num = 123;

    function get() public view returns (uint) {
        return num;
    }
    function set(uint _num) public {
        num = _num;
    }
}
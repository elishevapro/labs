pragma solidity ^0.8.19;

contract DataLocations {
    // storage = in blockchain
    // memory  = exists while the function life
    // calldata = function arguments
    struct MyStruct {
        uint number;
    }
    uint[] public arr;
    mapping(uint=>address) public map;

    mapping(uint=>MyStruct) myStructs;

    function f() public {
        // call _f() with state variables
        _f(arr, map, myStructs[1]);
        // get a struct
        MyStruct storage s = myStructs[0];
        // create a struct in memory
        MyStruct memory m = myStructs[1];
    }
    function _f(uint[] storage arr, mapping(uint=>address) storage map, MyStruct storage myStruct) internal {}
    function g(uint[] memory arr) public returns (uint[] memory a) {}
    function h(uint[] calldata arr) public {}
}
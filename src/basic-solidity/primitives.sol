pragma solidity ^0.8.19;

contract Primitives {
    bool public boo = true;
    uint8 public u8 = 1;
    uint256 public u256 = 456;
    uint public u = 123;
    int8 public i8 = -2;
    int256 public i256 = 456;
    int256 public i = -234;
    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;
    address public addr = 0x0000000000000000000000000000000000001234;
    bytes1 public b1 = 0x56;
    bytes1 public b2 = 0xF3;
    bool public defaultBoo; // false
    uint8 public defaultU8;
    uint256 public defaultU256; //0
    int256 public defaultI256; //0
    address public defaultAddr; //0x0000000000000000000000000000000000000000
}
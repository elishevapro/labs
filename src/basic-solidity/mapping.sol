pragma solidity ^0.8.19;

contract Mapping {
    mapping(address=>uint) public map;
    function get(address addr) public returns (uint) {
        return map[addr];
    }
    function set(address addr, uint i) public {
        map[addr] = i;
    }
    function remove(address addr) public {
        delete map[addr];
    }
}
contract NestedMapping {
    mapping(address=>mapping(uint=>bool)) nested;
    function get(address addr, uint u) public returns (bool) {
        return nested[addr][u];
    }
    function set(address addr, uint u, bool b) public {
        nested[addr][u] = b;
    }
    function remove(address addr, uint u) public {
        delete nested[addr][u];
    }
}
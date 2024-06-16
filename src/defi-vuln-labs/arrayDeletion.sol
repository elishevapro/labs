//SPDX-Identifier-License: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract testArrayDeletion is Test {
    ArrayDeletionBug public arrDelBug;
    FixedArrayDeletion public fixedArrDel;
    function setUp() public {
        arrDelBug = new ArrayDeletionBug();
        fixedArrDel = new FixedArrayDeletion();
    }
    function testArrDelBug() public {
        arrDelBug.arr(1);
        arrDelBug.deleteElement(1);
        arrDelBug.arr(1);
        arrDelBug.arrayLen();
    }
    function testFixedArrDel() public {
        fixedArrDel.arr(1);
        fixedArrDel.deleteElement(1);
        fixedArrDel.arr(1);
        fixedArrDel.arrayLen();
    }
}
contract ArrayDeletionBug {
    uint[] public arr = [1, 2, 3, 4, 5];
    function deleteElement(uint index) public {
        require(index < arr.length , "out of bounds");
        delete arr[index];
    }
    function arrayLen() public view returns (uint) {
        return arr.length;
    }
}
contract FixedArrayDeletion {
    uint[] public arr = [1, 2, 3, 4, 5];
    function deleteElement(uint index) public {
        require(index < arr.length, "out of bounds");
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
    function arrayLen() public view returns (uint) {
        return arr.length;
    }
}
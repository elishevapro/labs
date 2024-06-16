pragma solidity ^0.8.19;

contract Array {
    uint[] arr;
    uint[] arr2 = [1,2,3];
    uint[10] fixedSizeArray;

    function get() public view returns (uint) {
        return arr[0];
    }
    function getArray() public returns (uint[] memory) {
        return arr;
    }
    function getLength() public returns (uint) {
        return arr.length;
    }
    function push(uint i) public {
        arr.push(i);
    }
    function pop() public {
        arr.pop();
    }
    function del(uint i) public {
        delete arr[i];
    }
    function examples() external {
        uint[] memory ar = new uint[](23);
    }

    function removeByShifting(uint i) public {
        require(i<arr.length, "index out of bounds");
        for(uint j=0; j<arr.length;j++) {
            arr[j] = arr[j+1];
        }
        arr.pop();
    }
    function testRemoveByShifting() public {
        arr = [1,2,3];
        removeByShifting(1);
        assert(arr[0] == 1);
        assert(arr[1] == 3);
        arr = [1];
        removeByShifting(0);
        assert(arr.length == 0);
    }
    function removeReplaceLast(uint i) public {
        require(i<arr.length, "out of bounds");
        arr[i] = arr[arr.length-1];
        arr.pop();
    }
    function testRemoveReplaceLast() public {
        arr = [1,2,3];
        removeReplaceLast(0);
        assert(arr[0] == 3);
        assert(arr[1] == 2);
        removeReplaceLast(1);
        removeReplaceLast(0);
        assert(arr.length == 0);
    }
}
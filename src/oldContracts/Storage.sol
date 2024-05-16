pragma solidity ^0.8.15;
/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */

contract Storage {
    uint256 number;

    /**
     * @dev Store value in a variable
     * @param num value to store
     */
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value
     * @return the 'number' value
     */
    function retrieve() public view returns (uint256) {
        return number;
    }
}

// SPDX-Identifier-License: UNLICENSE
pragma solidity ^0.8.19;
import "./enumDeclaration.sol";
contract Enum {
    enum Status {
        pending,
        shipping
    }
    Status public status;
    Type public _type;
    function get() public view returns (Status) {
        return status;
    }
    function set(Status _status) public {
        status = _status;
    }
    function ship() public {
        status = Status.shipping;
    }
    function remove() public {
        delete status;
        // set to default = first option
    }
}
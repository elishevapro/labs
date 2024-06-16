pragma solidity ^0.8.19;

interface Itest {
    function val() external returns (uint);
    function test() external;
}

contract Fallback {
    uint val;
    fallback() external {
        val = Itest(msg.sender).val();
    }
    function test(address target) external {
        Itest(target).test();
    }
}
contract TestStorage {
    uint val;
    function test() public {
        val = 123;
        bytes memory b = "";
        msg.sender.call(b);
    }
}
contract TestTransientStorage {
    bytes32 constant SLOT = 0;
    function test() external {
        assembly {
            tstore
        }
    }
}
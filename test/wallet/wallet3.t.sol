// SPDX-Licensew-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet3.sol";

contract CollectorsTest is Test {
    /// @dev Address of the Collectors contract
    Collectors public c;
    address public owner;
    address public collector1 = address(1);
    address public collector2 = address(2);
    address public collector3 = address(3);
    // OwnerUpOnly public upOnly;

    /// @dev initialize everything to the test
    function setUp() public {
        c = new Collectors();
        // c.collector1 = address(0);
        // why do we need this too??
        // address my_add = address(c);
        // upOnly = new OwnerUpOnly();
    }

    function testDeposit() public {
        assertEq(0, address(c).balance);
        uint value = 10;
        console.log(value);
        vm.prank(owner);
        uint256 x = c.deposit(10);
        assertEq(value, address(c).balance);
        assertEq(x, address(c).balance);
    }

    function testAddCollector() public {
        c.addCollector(collector1);
        assertEq( c.collector1(), collector1, "add new collector");
    }
    function testAddCollectorNoSpace() public {
        c.addCollector(collector1);
        c.addCollector(collector2);
        c.addCollector(collector3);
        collector1 = address(8);
        vm.expectRevert("couldn't add collector");
        c.addCollector(collector1);
    }
    function testAddExistCollector() public {
        c.addCollector(collector1);
        vm.expectRevert("this collector is allowed yet");
        c.addCollector(collector1);
    }
    function testRemoveCollector() public {
        c.addCollector(collector1);
        c.removeCollector(collector1);
        assertEq( c.collector1(), address(0),"remove an existing collector");
    }
    function testRemoveNotExistCollector() public {
        vm.expectRevert("couldn't remove collector");
        c.removeCollector(collector1);
    }
}

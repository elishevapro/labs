//SPDX-Licensew-Identifier: Unlicense
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
    address public randomAddress = address(4);
    uint val = 10;
    uint initialValue = 100;
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
        vm.startPrank(collector1);
        vm.deal(collector1, initialValue);
        c.deposit{value: val}();
        assertEq(val, address(c).balance);
        vm.stopPrank();
    }
    function testFailDeposit() public {
        vm.startPrank(randomAddress);
        vm.expectRevert("don't have enough amount");
        c.deposit{value: val}();
    }
    function testWithdraw() public {
        assertEq(0, address(c).balance);
        vm.startPrank(collector1);
        vm.deal(payable(address(c)),initialValue);
        console.log(address(this).balance);
        payable(address(c)).transfer(20);
        console.log(collector1.balance);
        console.log(address(c).balance);
        c.withdraw{value: val}();
        assertEq(initialValue-val, address(c).balance);
        assertEq(val, collector1.balance);
        vm.stopPrank();
    }
    function testfailAddCollector() public {
        vm.prank(address(123));
        vm.expectRevert("Not owner");
        c.addCollector(collector1);
    }
    function testfailRemoveCollector() public {
        vm.prank(address(123));
        vm.expectRevert("Not owner");
        c.addCollector(collector1);
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

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
    uint256 val = 10;
    uint256 initialValue = 100;
    // OwnerUpOnly public upOnly;

    /// @dev initialize everything to the tests
    function setUp() public {
        c = new Collectors();
        // c.collector1 = address(0);
        // why do we need this too??
        // address my_add = address(c);
        // upOnly = new OwnerUpOnly();
    }

    receive() external payable {}

    function testConstructor() public {
        console.log(address(this));
        console.log(address(c));
        console.log(msg.sender);
        // console.log();
        assertEq(c.owner(), address(this));
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
        //what is the difference between msg.sender and address(this)?
        assertEq(0, address(c).balance);
        vm.deal(payable(address(c)), initialValue);
        uint256 firstBalance = address(this).balance;
        console.log(firstBalance);
        c.withdraw(val);
        assertEq(initialValue - val, address(c).balance);
        assertEq(firstBalance + val, address(this).balance);
        vm.stopPrank();
    }

    function testWithdrawNotAllowed() public {
        vm.startPrank(randomAddress);
        vm.expectRevert("not allowed");
        c.withdraw(val);
    }

    function testWithdrawNoMoney() public {
        c.addCollector(collector1);
        vm.startPrank(collector1);
        vm.expectRevert("no money");
        c.withdraw(val);
    }

    function testfailAddCollectorNotOwner() public {
        vm.prank(address(123));
        vm.expectRevert("Not owner");
        c.addCollector(collector1);
    }

    function testRemoveCollectorNotOwner() public {
        vm.prank(address(123));
        vm.expectRevert("Not owner");
        c.addCollector(collector1);
    }

    function testAddCollector() public {
        c.addCollector(collector1);
        assertEq(c.collector1(), collector1, "add new collector");
    }

    function testAddCollectorNoSpace() public {
        c.addCollector(collector1);
        c.addCollector(collector2);
        c.addCollector(collector3);
        collector1 = randomAddress;
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
        assertEq(c.collector1(), address(0), "remove an existing collector");
    }

    function testRemoveNotExistCollector() public {
        vm.expectRevert("couldn't remove collector");
        c.removeCollector(collector1);
    }

    function testGetBalance() public {
        vm.deal(payable(address(c)), initialValue);
        uint256 balance = c.getBalance();
        assertEq(balance, initialValue);
    }
}

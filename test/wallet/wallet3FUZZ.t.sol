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
    address public collector1;
    address public collector2;
    address public collector3;
    address public randomAddress;

    /// @dev initialize everything to the tests
    function setUp() public {
        c = new Collectors();
    }
    receive() external payable {}
    function testFuzz_Constructor() public {
        console.log(address(this));
        console.log(address(c));
        console.log(msg.sender);
        assertEq(c.owner(), address(this));
    }
    function testFuzz_Deposit(uint initialValue, uint val) public {
        assertEq(0, address(c).balance);
        vm.startPrank(collector1);
        vm.deal(collector1, initialValue);
        c.deposit{value: val}();
        assertEq(val, address(c).balance);
        vm.stopPrank();
    }
    function testFuzz_FailDeposit(uint val) public {
        vm.startPrank(randomAddress);
        vm.expectRevert("don't have enough amount");
        c.deposit{value: val}();
    }
    function testFuzz_Withdraw(uint initialValue, uint val) public {
        //what is the difference between msg.sender and address(this)?
        assertEq(0, address(c).balance);
        vm.deal(payable(address(c)),initialValue);
        uint256 firstBalance = address(this).balance;
        console.log(firstBalance);
        c.withdraw(val);
        assertEq(initialValue-val, address(c).balance);
        assertEq(firstBalance+val, address(this).balance);
        vm.stopPrank();
    }
    function testFuzz_WithdrawNotAllowed(uint val) public {
        vm.startPrank(randomAddress);
        vm.expectRevert("not allowed");
        c.withdraw(val);
    }
    function testFuzz_WithdrawNoMoney(uint val) public {
        c.addCollector(collector1);
        vm.startPrank(collector1);
        vm.expectRevert("no money");
        c.withdraw(val);
    }
    function testFuzz_failAddCollectorNotOwner() public {
        vm.prank(address(123));
        vm.expectRevert("Not owner");
        c.addCollector(collector1);
    }
    function testFuzz_RemoveCollectorNotOwner() public {
        vm.prank(address(123));
        vm.expectRevert("Not owner");
        c.addCollector(collector1);
    }
    function testFuzz_AddCollector() public {
        c.addCollector(collector1);
        assertEq( c.collector1(), collector1, "add new collector");
    }
    function testFuzz_AddCollectorNoSpace() public {
        c.addCollector(collector1);
        c.addCollector(collector2);
        c.addCollector(collector3);
        collector1 = randomAddress;
        vm.expectRevert("couldn't add collector");
        c.addCollector(collector1);
    }
    function testFuzz_AddExistCollector() public {
        c.addCollector(collector1);
        vm.expectRevert("this collector is allowed yet");
        c.addCollector(collector1);
    }
    function testFuzz_RemoveCollector() public {
        c.addCollector(collector1);
        c.removeCollector(collector1);
        assertEq( c.collector1(), address(0),"remove an existing collector");
    }
    function testFuzz_RemoveNotExistCollector() public {
        vm.expectRevert("couldn't remove collector");
        c.removeCollector(collector1);
    }
    function testFuzz_GetBalance(uint initialValue) public {
        vm.deal(payable(address(c)), initialValue);
        uint balance = c.getBalance();
        assertEq(balance, initialValue);
    }
}

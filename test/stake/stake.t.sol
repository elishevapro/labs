//SPDX-Licenes-Identifier: MIT
pragma solidity ^0.8.20;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/stake/stake.sol";
contract TestStake is Test{
    Stake stake;
    address person1;
    address person2;
    address person3;
    // mapping(address=>uint) stakedAmounts;
    function setUp() public {
        stake = new Stake();
        person1 = address(123);
        person2 = address(456);
        person3 = address(789);
        console.log(stake.owner());
                // stakedAmounts = stake.stakedAmounts();
    }
    function testStake() public  {
        vm.startPrank(person1);
        vm.deal(person1, 11000);
        stake.stake{value: 5000}();
        // var stakedAmounts = stake.stakedAmounts();
// stake.stakedAmounts();
console.log(block.timestamp);
console.log(block.timestamp/60/60/24);
console.log(stake.beginDates(person1));
        assertEq(stake.stakedAmounts(person1),5000);
        assertEq(stake.beginDates(person1)/60/60/24, block.timestamp/60/60/24);
        
    }

    function testWithDraw() public {
    }
}
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract testERC20 is Test {
    ERC20 erc20contract;
    address alice = vm.addr(1);
    address eve = vm.addr(2);

    function testApproveScam() public {
        erc20contract = new ERC20();
        erc20contract.mint(1000);
        erc20contract.transfer(alice, 1000);
        vm.prank(alice);
        erc20contract.approve(eve, type(uint).max);
        console.log("eve balance before scam ", erc20contract.balanceOf(eve));
        vm.prank(eve);
        erc20contract.transferFrom(alice, eve, 1000);
        console.log("eve balance after scam", erc20contract.balanceOf(eve));
    }

    receive() external payable {}
}

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address addr) external returns (uint);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transfer(address reciepent, uint amout) external returns (bool);
    function transferFrom(address from, address spender, uint amount) external returns (bool);

    event Transfer(address indexed from, address indexed spender, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
}
contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping(address=>uint) public balances;
    mapping(address=>mapping(address=>uint)) public allowance;
    string public name = "test example";
    string public symbol = "test";
    uint8 public decimals = 18;
    function transfer(address spender, uint amount) public returns (bool) {
        balances[msg.sender] -= amount;
        balances[spender] += amount;
        emit Transfer(msg.sender, spender, amount);
        return true;
    }
    function approve(address spender, uint amount) public returns (bool) {
        allowance[msg.sender][spender] += amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    function transferFrom(address owner, address spender, uint amount) public returns (bool) {
        allowance[owner][spender] -= amount;
        balances[owner] -= amount;
        balances[spender] += amount;
        emit Transfer(owner, spender, amount);
        return true;
    }

    function mint(uint amount) public {
        balances[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }
    function burn(uint amount) public {
        balances[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
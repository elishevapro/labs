pragma solidity ^0.8.19;

contract EtherUnits {
    uint public oneWei = 1 wei;
    bool public isOneWei = oneWei == 1;
    uint public oneGwei = 1 gwei;
    bool public isOneGwei = (oneGwei == 1e9);
    uint public oneEther = 1 ether;
    bool public isOneEther = (oneEther == 1e18);
}
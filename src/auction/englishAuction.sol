//SPDX-License-Identifier: MIT
import "@openzeppelin/ERC721/ERC721.sol";
pragma solidity ^0.8.20;
contract Auction {
    mapping(address=>uint) public bids;
    address[] public addresses;
    address public immutable seller;
    bool public started;
    bool public ended;

    uint public endAt;

    address public highestBidder;
    uint public highestBid;

    ERC721 public NFT;

    event bid(address bidder, uint amount);
    event start(uint time, )

    constructor(address _NFT, uint startingBid, uint duration) {
        seller = msg.sender;
        started=false;
        initiate(_NFT, startingBid, duration);
    }
    function initiate(address _NFT, uint startingBid, uint duration) private {
        require(started==false, "auction started yet");
        NFT = ERC721(_NFT);
        require(NFT.tokenURI(), "seller not own the NFT");
        //transfer the NFT to the contract

        bids[msg.sender] = startingBid;
        addresses.push(msg.sender);
    }

}
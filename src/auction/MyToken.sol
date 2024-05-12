//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/ERC721/ERC721.sol";
contract MyToken is ERC721 {
    constructor() ERC721("NFT", "nft") {
     
    }

    function mint(address add, uint amount) public {
        _mint(add , amount);
    }
}
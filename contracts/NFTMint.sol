// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMint is ERC721, Ownable {

    uint public mintPrice = 0.05 ether;
    uint public totalSupply;
    uint public maxSupply;
    bool public isMintEnabled;

    mapping (address => uint) public mintedWallets;

    constructor() payable ERC721("NFTMint", "NFTMINT") {
        maxSupply = 2;
    }

    function toggleIsMintEnabled() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply(uint _maxSupply) external onlyOwner {
        maxSupply = _maxSupply;
    }

    function mint() external payable {
        require(isMintEnabled, "minting not enabled" );
        require(mintedWallets[msg.sender] < 1, "Exceeds max per wallet");
        require(msg.value == mintPrice, "wrong value");
        require(maxSupply > totalSupply, "sold out");

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
    }
    
}


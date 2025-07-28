// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//https://sepolia.etherscan.io/address/0x8EeEe9FB51dbEf4C4491F471E716B3a4c9960ad7
contract MyNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;
    
    constructor() ERC721("MyNFT", "MYNFT") Ownable(msg.sender) {}
    
    function mintNFT(address recipient, string memory tokenURI) public onlyOwner returns (uint256) {
        _tokenIds++;
        uint256 newItemId = _tokenIds;
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
        
        return newItemId;
    }
}

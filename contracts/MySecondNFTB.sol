// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MySecondNFTB is ERC721, ERC721URIStorage, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    string private _nftBaseURI;

    mapping(string => uint8) private _hashAssigned;

    Counters.Counter private _tokenIds;


    constructor(string memory theBaseURI) ERC721("My SecondNFTB", "NFTB2") {
        _nftBaseURI = theBaseURI;
    }

    //only the owner of the contract can mint items
    function awardItem(address recipient, string memory hash, string memory metadata) external onlyOwner returns (uint256)
    {
        //check whether the hash is assigned, if assigned, revert
        require(_hashAssigned[hash] != 1);

        //mark the hash as assigned
        _hashAssigned[hash] = 1;

        //increment the token Id by 1
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        //only 3 items can be minted, even by owner
        //If ownership renounced, no one can mint ever again
        require(newItemId < 3);
        
        //Mint and set the token id and metadata
        _mint(recipient, newItemId);  
        _setTokenURI(newItemId, metadata);
        return newItemId;
    }

    function tokenURI(uint256 tokenId) public view override(ERC721,ERC721URIStorage) returns (string memory) {
        return string(abi.encodePacked(_nftBaseURI,"/",super.tokenURI(tokenId)));
    }

    function _burn(uint256 tokenId) internal override(ERC721,ERC721URIStorage) {
        super._burn(tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

}
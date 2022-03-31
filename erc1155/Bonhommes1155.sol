// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


/**
* Goals : Mint 1 formator with hair, 185cm, unique - 2M parisians with hair, 180cm, hence not unique
* With : 
* Data on chain
* Metadata on IPFS
* Image on IPFS
* Counter from OpenZeppelin
* Royalties of 10%
*/
contract Bonhommes1155 is ERC1155, IERC2981, Ownable { 
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Bonhomme{
        uint256 height;
        bool hair;
    }
	Bonhomme[] bonhommes;

	uint256 public constant PARISIANS = 0;
    uint256 public constant FORMATOR = 1;

    constructor() ERC1155("https://game.example/api/item/{id}.json") {
        _mint(msg.sender, PARISIANS, 2*10**6, "");
        _mint(msg.sender, FORMATOR, 1, "");
    }

    function setURI(string memory _uri) public onlyOwner{
        _setURI(_uri);
    }

    function supportsInterface(bytes4 interfaceId){

    }

    function mintBonhommes(address player, uint256 _height, bool _hair){
        _tokenIds.increment();
        bonhommes.push(Bonhomme(_height,_hair));
        uint256 newItemId = _tokenIds.current();

        _mint(msg.sender, PARISIANS, 2*10**6, "");
        _mint(msg.sender, FORMATOR, 1, "");

        

    }

}
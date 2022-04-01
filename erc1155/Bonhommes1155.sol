// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


/**
* Goals : Mint 1 formator with hair, 185cm, unique - 2M parisians with hair, 180cm, hence not unique
* With : 
* Data on chain
* Metadata on IPFS
* Image on IPFS
* Counter from OpenZeppelin
* Royalties of 10%
*/
contract Bonhommes1155 is ERC1155, ERC2981, Ownable { 
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Bonhomme{
        string cls;
        uint256 height;
        bool hair;
    }
	Bonhomme[] bonhommes;

    constructor() ERC1155("https://game.example/api/item/{id}.json") {}

    function setURI(string memory _uri) public onlyOwner{
        _setURI(_uri);
    }

    function mintBonhommes(address player, uint256 _nb, string memory _cls, uint256 _height, bool _hair) private onlyOwner{
        _tokenIds.increment();
        bonhommes.push(Bonhomme(_cls,_height,_hair));
        uint256 newItemId = _tokenIds.current();
        
        _mint(msg.sender, newItemId, _nb, "");
        //Royalties to call
    }

    function deployMint() public onlyOwner{
        mintBonhommes(msg.sender, 2*10**6, "PARISIANS", 180, true);
        mintBonhommes(msg.sender, 1, "FORMATOR", 185, true); 
    }

}
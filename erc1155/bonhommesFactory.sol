// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract bonhommesFactory is ERC721URIStorage {
	using Counters for Counters.Counter;
	Counters.Counter private _tokenIds;

	struct Bonhomme {
		uint8 height;
		bool hair;
	}
	Bonhomme[] public bonhommes;

	constructor() ERC721("Bonhomme","BHM"){}

	function mintBonhomme(string memory tokenURI, uint8 _height, bool _hair) public returns(uint256){
		_tokenIds.increment();
		bonhommes.push(Bonhomme(_height,_hair));

		uint256 newId = _tokenIds.current();
		_mint(msg.sender,newId);
		_setTokenURI(newId, tokenURI);

		return newId;
	}
}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Bonhommes1155 is ERC1155{
	
	struct Bonhomme{
        uint256 height;
        bool hair;
    }
	
	uint256 public constant PARISIANS = 0;
    uint256 public constant FORMATOR = 1;

    constructor() ERC1155("https://game.example/api/item/{id}.json") {
        _mint(msg.sender, PARISIANS, 2*10**66, "");
        _mint(msg.sender, FORMATOR, 1, "");
    }

}
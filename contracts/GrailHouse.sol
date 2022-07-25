// SPDX-License-Identifier: MIT


pragma solidity ^0.8.4;

import "erc721a-upgradeable/contracts/ERC721AUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";

pragma solidity ^0.8.0;

contract GrailHouse is ERC721AUpgradeable, OwnableUpgradeable, ReentrancyGuardUpgradeable {  
    bool public MINTING_PAUSED;

    function initialize() initializerERC721A initializer public {
        __ERC721A_init("GrailHouse", "GRAILHOUSE");
        __Ownable_init();

        MINTING_PAUSED = true;
    }

    function setPauseMinting(bool _pause) public onlyOwner { 
        MINTING_PAUSED = _pause; 
    }

    function publicMint() external nonReentrant {
        require(!MINTING_PAUSED, "Minting is not active");       

        _mint(msg.sender, 1);
    }
}
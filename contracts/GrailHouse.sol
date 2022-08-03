// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "erc721a-upgradeable/contracts/ERC721AUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";

contract GrailHouse is ERC721AUpgradeable, OwnableUpgradeable, ReentrancyGuardUpgradeable {
    uint256 public constant MAX_ELEMENTS = 15;
    bool public MINTING_PAUSED;
    string public baseTokenURI;
    string public _contractURI;


    function initialize() initializerERC721A initializer public {
        __ERC721A_init("GrailHouse", "GRAILHOUSE");
        __Ownable_init();

        MINTING_PAUSED = true;
        _contractURI = "";
    }

    function setPauseMinting(bool _pause) public onlyOwner { 
        MINTING_PAUSED = _pause; 
    }

    function publicMint() external nonReentrant {
        require(!MINTING_PAUSED, "Minting is not active");
        require(totalSupply() < MAX_ELEMENTS, 'All tokens have been minted');

        _mint(msg.sender, 1);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    function setBaseURI(string calldata baseURI) public onlyOwner {
        baseTokenURI = baseURI;
    }

    function setContractURI(string calldata URI) external onlyOwner {
        _contractURI = URI;
    }

    function contractURI() public view returns (string memory) {
        return _contractURI;
    }
}
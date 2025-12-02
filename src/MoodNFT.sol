//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    error MoodNFT__You_are_notOwner();
    uint256 private s_tokenCounter;
    string private s_HappyImageURI;
    string private s_sadImageURI;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) s_tokenIdToMood;

    constructor(
        string memory _happyImageURI,
        string memory _sadImageURI
    ) ERC721("Mood NFT", "MNFT") {
        s_tokenCounter = 0;
        s_HappyImageURI = _happyImageURI;
        s_sadImageURI = _sadImageURI;
    }

    function mintNFT() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 _tokenId) public {
        if (!_isApprovedOrOwner(msg.sender, tokenId)) {
            revert MoodNFT__You_are_notOwner();
        }
        if (s_tokenIdToMood[_tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[_tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[_tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal view override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 _tokenID
    ) public view override returns (string memory) {
        string memory moodImageURI;

        if (s_tokenIdToMood[_tokenID] == Mood.HAPPY) {
            moodImageURI = s_HappyImageURI;
        } else {
            moodImageURI = s_sadImageURI;
        }

        bytes memory metadata = bytes(
            abi.encodePacked(
                "{",
                '"name": "',
                name(),
                '",',
                '"description": "A Mood NFT that changes based on your on-chain mood!",',
                '"image": "',
                moodImageURI,
                '",',
                '"attributes": [',
                '{ "trait_type": "mood", "value": "100" }',
                "]",
                "}"
            )
        );
        return string(abi.encodePacked(_baseURI(), Base64.encode(metadata)));
    }
}

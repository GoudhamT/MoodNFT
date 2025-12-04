//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    function run() external {}

    function svgToImageURI(
        string memory _svg
    ) public view returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory imageURI = Base64.encode(
            bytes(string(abi.encodePacked(_svg)))
        );
        return string(abi.encodePacked(baseURL, imageURI));
    }
}

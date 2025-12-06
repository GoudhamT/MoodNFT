//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;
import {Script} from "forge-std/Script.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {MoodNFT} from "../src/MoodNFT.sol";

contract DeployMoodNFT is Script {
    function run() external returns (MoodNFT) {
        string memory happySVG = vm.readFile("./img/happy.svg");
        string memory sadSVG = vm.readFile("./img/sad.svg");
        vm.startBroadcast();
        MoodNFT moodNFT = new MoodNFT(
            svgToImageURI(happySVG),
            svgToImageURI(sadSVG)
        );
        vm.stopBroadcast();
        return moodNFT;
    }

    function svgToImageURI(string memory _svg) public returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgURI = Base64.encode(
            bytes(string(abi.encodePacked(_svg)))
        );
        return string(abi.encodePacked(baseURI, svgURI));
    }
}

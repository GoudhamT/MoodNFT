//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;
import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testNFTNameisCorrect() public view {
        string memory expectedName = "Dogie";
        console.log("expectedName is ", expectedName);
        string memory NFTName = basicNFT.name();
        console.log("Name from NFT is ", NFTName);
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(NFTName))
        );
    }
}

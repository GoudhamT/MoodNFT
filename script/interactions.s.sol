//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTInteractions is Script {
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() public {
        // address recentlyDeployedAddress = DevOpsTools
        //     .get_most_recent_deployment("BasicNFT", block.chainid);
        address recentlyDeployedAddress = vm.envAddress("BASIC_NFT_ADDRESS");
        mintNFTOnAddress(recentlyDeployedAddress);
    }

    function mintNFTOnAddress(address _recentlyDeployed) public {
        vm.startBroadcast();
        BasicNFT(_recentlyDeployed).mintNFT(PUG_URI);
        vm.stopBroadcast();
    }
}

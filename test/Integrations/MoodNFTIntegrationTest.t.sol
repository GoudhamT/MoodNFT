//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;
import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNFT} from "../../script/DeployMoodNFT.s.sol";
import {MoodNFT} from "../../src/MoodNFT.sol";

contract MoodNFTIntegrationsTest is Test {
    DeployMoodNFT deployer;
    MoodNFT moodNFT;
    address USER = makeAddr("user");
    string public happyURI =
        "data:application/json;base64,eyJuYW1lIjogIk1vb2QgTkZUIiwiZGVzY3JpcHRpb24iOiAiQSBNb29kIE5GVCB0aGF0IGNoYW5nZXMgYmFzZWQgb24geW91ciBvbi1jaGFpbiBtb29kISIsImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjJhV1YzUW05NFBTSXdJREFnTWpBd0lESXdNQ0lnZDJsa2RHZzlJalF3TUNJZ2FHVnBaMmgwUFNJME1EQWlJSGh0Ykc1elBTSm9kSFJ3T2k4dmQzZDNMbmN6TG05eVp5OHlNREF3TDNOMlp5SStEUW9nSUNBZ1BHTnBjbU5zWlNCamVEMGlNVEF3SWlCamVUMGlNVEF3SWlCbWFXeHNQU0o1Wld4c2IzY2lJSEk5SWpjNElpQnpkSEp2YTJVOUltSnNZV05ySWlCemRISnZhMlV0ZDJsa2RHZzlJak1pSUM4K0RRb2dJQ0FnUEdjZ1kyeGhjM005SW1WNVpYTWlQZzBLSUNBZ0lDQWdJQ0E4WTJseVkyeGxJR040UFNJM01DSWdZM2s5SWpneUlpQnlQU0l4TWlJZ0x6NE5DaUFnSUNBZ0lDQWdQR05wY21Oc1pTQmplRDBpTVRJM0lpQmplVDBpT0RJaUlISTlJakV5SWlBdlBnMEtJQ0FnSUR3dlp6NE5DaUFnSUNBOGNHRjBhQ0JrUFNKdE1UTTJMamd4SURFeE5pNDFNMk11TmprZ01qWXVNVGN0TmpRdU1URWdOREl0T0RFdU5USXRMamN6SWlCemRIbHNaVDBpWm1sc2JEcHViMjVsT3lCemRISnZhMlU2SUdKc1lXTnJPeUJ6ZEhKdmEyVXRkMmxrZEdnNklETTdJaUF2UGcwS1BDOXpkbWMrIiwiYXR0cmlidXRlcyI6IFt7ICJ0cmFpdF90eXBlIjogIm1vb2QiLCAidmFsdWUiOiAiMTAwIiB9XX0=";

    function setUp() public {
        deployer = new DeployMoodNFT();
        moodNFT = deployer.run();
    }

    function testImage() public {
        vm.prank(USER);
        moodNFT.mintNFT();
        assert(
            keccak256(abi.encodePacked(moodNFT.tokenURI(0))) ==
                keccak256(abi.encodePacked(happyURI))
        );
    }

    function testFlipMood() public {
        vm.prank(USER);
        moodNFT.mintNFT();

        vm.prank(USER);
        moodNFT.flipMood(0);
        assert(
            keccak256(abi.encodePacked(happyURI)) !=
                keccak256(abi.encodePacked(moodNFT.tokenURI(0)))
        );
        console.log(moodNFT.tokenURI(0));
    }
}

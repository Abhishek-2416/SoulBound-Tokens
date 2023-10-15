// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Test} from "forge-std/Test.sol";
import {CollegeDAO} from "../src/SoulboundToken.sol";

contract TestSoulBoundToken is Test{
    CollegeDAO token;

    function setUp() external{
        token = new CollegeDAO();
    }

    function testburnCanBeCalledOnlyByOwner() public{
        token.safeMint(address(0x1),"nft");
        vm.prank(address(0x1));
        token.burn(0);
    }

    function testBurntoken() public{
        token.safeMint(address(0x1),"nft");
        assert(token.getTokenCount() == 1);
        vm.prank(address(0x1));
        token.burn(0);
        assert(token.ownerOf(token.getTokenCount()) == address(0));
    }
}
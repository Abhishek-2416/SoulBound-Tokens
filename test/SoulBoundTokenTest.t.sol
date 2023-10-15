// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Test} from "forge-std/Test.sol";
import {CollegeDAO} from "../src/SoulboundToken.sol";

contract TestSoulBoundToken is Test{
    CollegeDAO token;

    function setUp() external{
        token = new CollegeDAO();
    }

    function testIfTokenIdIncerementInSafeMint() public{
        token.safeMint(address(0x1),"nft");
        assertEq(token.getTokenCount(),1);

        token.safeMint(address(0x2),"nft2");
        assertEq(token.getTokenCount(),2);

        // vm.expectRevert();
        assert(token.getTokenCount() != 3);
    }

    function testSafeMintInSafeMint() public{
        token.safeMint(address(0x1),"nft");
        assertEq(token.ownerOf(0),address(0x1));
        assertEq(token.getTokenCount(),1);
    }

    function testSetTokenURIInSafeMint() public{
        token.safeMint(address(0x1),"nft");
        assertEq(token.ownerOf(0),address(0x1));
        assertEq(token.getTokenCount(),1);
        assertEq(token.tokenURI(0) ,"nft");
    }

    function testFailWhenAddressZeroCallsIt() public{
        token.safeMint(address(0),"nft");
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
        assert(token.balanceOf(address(0x1)) == 0);
    }

    function testRevoke() public {
        token.safeMint(address(0x1),"nft");
        vm.prank(address(this));
        token.revoke(0);
        assert(token.balanceOf(address(0x1)) == 0);
    }

    function testFailRevokeWhenNotCalledByOwner() public{
        vm.prank(address(0x1));
        token.revoke(0);
    }

    
}
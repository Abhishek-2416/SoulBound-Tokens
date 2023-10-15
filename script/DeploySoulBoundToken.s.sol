// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Script} from "forge-std/Script.sol";
import {CollegeDAO} from "../src/SoulboundToken.sol";

contract DeploySoulBoundToken is Script{
    function run() external{
        vm.startBroadcast();
        CollegeDAO token = new CollegeDAO();
        vm.stopBroadcast(); 
    }
}
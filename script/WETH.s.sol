// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {WETH} from "../src/WETH.sol";

contract WETHScript is Script {
    WETH public weth;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        weth = new WETH();
        vm.stopBroadcast();
    }
}

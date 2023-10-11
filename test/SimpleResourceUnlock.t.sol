// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Test, console2} from "forge-std/Test.sol";
import {SimpleResourceUnlock} from "../src/SimpleResourceUnlock.sol";

contract CounterTest is Test {
    SimpleResourceUnlock public recUnlock;

    function setUp() public {
        recUnlock = new SimpleResourceUnlock();
    }

    function test_GetResourceCost() public {
        uint256 cost = 1;
        string memory key = "testKey";
        recUnlock.setResource(key, "test", cost);
        assertEq(recUnlock.getCost(key), cost);
    }

}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {Test, console2} from "forge-std/Test.sol";
import {SimpleResourceUnlock} from "../src/SimpleResourceUnlock.sol";

contract CounterTest is Test {
    SimpleResourceUnlock public recUnlock;

    error InsufficientFunds();

    function setUp() public {
        recUnlock = new SimpleResourceUnlock();
    }

    function test_GetResourceCost() public {
        uint256 cost = 10;
        string memory key = "testKey";
        recUnlock.setResource(key, "test", cost);
        assertEq(recUnlock.getCost(key), cost);
    }

    function test_GetResource() public {
        uint256 cost = 10;
        string memory key = "testKey";
        string memory rec = "test";
        recUnlock.setResource(key, rec, cost);

        string memory result = recUnlock.getResource{value: cost}(key);
        assertEq(result, rec);
    }

    function test_RevertWhen_PayResourceCostTooLittle() public {
        uint256 cost = 10;
        string memory key = "testKey";
        recUnlock.setResource(key, "test", cost);
        vm.expectRevert(InsufficientFunds.selector);
        recUnlock.getResource{value: cost - 1}(key);
    }
}

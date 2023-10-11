// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

contract SimpleResourceUnlock {
    mapping(string => string) private _resourceVals;
    mapping(string => uint256) public resourceCosts;
    mapping(string => address) public resourceOwners;
    string[] public resourceDescriptions;

    error Unauthorized();
    error InsufficientFunds();

    function setResource(string memory key, string memory value, uint256 cost) public {
        if (resourceOwners[key] != address(0) && resourceOwners[key] != msg.sender) {
            revert Unauthorized();
        }
        _resourceVals[key] = value;
        resourceCosts[key] = cost;
        resourceOwners[key] = msg.sender;
        resourceDescriptions.push(key);
    }

    function getResourceDescriptions() public view returns (string[] memory) {
        return resourceDescriptions;
    }

    function getCost(string memory key) public view returns (uint256) {
        return resourceCosts[key];
    }

    function getResource(string memory key) public payable returns (string memory) {
        if (msg.value < resourceCosts[key]) {
            revert InsufficientFunds();
        }
        return _resourceVals[key];
    }
}

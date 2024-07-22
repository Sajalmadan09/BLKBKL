// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Oracle {
    struct Data {
        uint humidity;
        uint moistureContent;
        uint storageConditions;
    }

    mapping(address => Data) public data;

    function provide(address processorAddress, uint humidity, uint moistureContent, uint storageConditions) public {
        data[processorAddress] = Data(humidity, moistureContent, storageConditions);
    }

    function getData(address processorAddress) public view returns (uint humidity, uint moistureContent, uint storageConditions) {
        return (data[processorAddress].humidity, data[processorAddress].moistureContent, data[processorAddress].storageConditions);
    }
}

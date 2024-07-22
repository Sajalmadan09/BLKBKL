// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./FarmerProcessor.sol";

contract FarmerProcessorDelegate {
    FarmerProcessor public delegate;

    constructor(address _farmerProcessorAddress) {
        delegate = FarmerProcessor(_farmerProcessorAddress);
    }

    function createOrder(uint _quantity) public returns(uint) {
        return delegate.createOrder(_quantity);
    }

    function cancelOrder(uint _orderId) public returns (uint){
        return delegate.cancelOrder(_orderId);
    }

    function viewOrder(
        uint _orderId
    ) public view returns (uint, uint, string memory, address) {
        return delegate.viewOrder(_orderId);
    }

    function createOffer(uint _orderId, string memory _harvestDate, uint _pricePerKilogram, string memory _origin) public returns(uint){
        return delegate.createOffer(_orderId, _harvestDate, _pricePerKilogram, _origin);
    }

    function cancelOffer(uint _offerId) public returns (uint){
        return delegate.cancelOffer(_offerId);
    }

    function viewOffers(uint _orderId) public view returns (FarmerProcessor.Offer[] memory) {
        return delegate.viewOffers(_orderId);
    }

    function acceptOffer(uint _orderId, uint _offerId) public returns (uint) {
        return delegate.acceptOffer(_orderId, _offerId);
    }

    function getAllTransactions() public view returns (FarmerProcessor.Transaction[] memory) {
        return delegate.getAllTransactions();
    }
}


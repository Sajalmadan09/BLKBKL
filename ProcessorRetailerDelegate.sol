// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ProcessorRetailer.sol";

contract ProcessorRetailerDelegate {
    ProcessorRetailer public delegate;

    constructor(address _processorRetailerAddress) {
        delegate = ProcessorRetailer(_processorRetailerAddress);
    }

    function createOrder(address _processorAddress, uint _productId, uint _quantity) public returns (uint) {
        return delegate.createOrder(_processorAddress, _productId, _quantity);
    }

    function cancelOrder(uint _orderId) public returns (uint){
        return delegate.cancelOrder(_orderId);
    }

    function createOffer(
        uint _price, 
        uint[] memory _offerIds, 
        string memory _bestBeforeDate, 
        string memory _wheatType, 
        string memory _harvestDate, 
        string memory _origin, 
        uint _orderId
    ) public returns(uint){
        return delegate.createOffer(_price, _offerIds, _bestBeforeDate, _wheatType, _harvestDate, _origin, _orderId);
    }

    function cancelOffer(uint _offerId) public returns (uint){
        return delegate.cancelOffer(_offerId);
    }

    function viewOrders(address _processorAddress) public view returns (ProcessorRetailer.Order[] memory) {
        return delegate.viewOrders(_processorAddress);
    }

    function viewOffers(uint _orderId) public view returns (ProcessorRetailer.Offer[] memory) {
        return delegate.viewOffers(_orderId);
    }

    function acceptOffer(uint _orderId, uint _offerId) public returns (uint){
        return delegate.acceptOffer(_orderId, _offerId);
    }

    function getAllTransactions() public view returns (ProcessorRetailer.Transaction[] memory) {
        return delegate.getAllTransactions();
    }
}

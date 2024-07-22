// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./RetailerCustomer.sol";

contract RetailerCustomerDelegate {
    RetailerCustomer public delegate;

    constructor(address _retailerCustomerAddress) {
        delegate = RetailerCustomer(_retailerCustomerAddress);
    }

    function createProduct(
        uint _productType, 
        string memory _wheatType, 
        string memory _brand, 
        string memory _origin, 
        uint _price, 
        string memory _description, 
        uint _stock
    ) public {
        delegate.createProduct(_productType, _wheatType, _brand, _origin, _price, _description, _stock);
    }

    function updateProduct(
        uint _productType, 
        string memory _wheatType, 
        string memory _brand, 
        string memory _origin, 
        uint _price, 
        string memory _description, 
        uint _stock
    ) public {
        delegate.updateProduct(_productType, _wheatType, _brand, _origin, _price, _description, _stock);
    }

    function removeProduct(uint _productType) public {
        delegate.removeProduct(_productType);
    }

    function viewProduct(uint _productType) public view returns (RetailerCustomer.WheatProduct[] memory) {
        return delegate.viewProduct(_productType);
    }

    function buyProduct(uint _productType, uint _quantity) public {
        delegate.buyProduct(_productType, _quantity);
    }

    function updateTransaction(uint _transactionId, uint[] memory _offerIds) public {
        delegate.updateTransaction(_transactionId, _offerIds);
    }

    function getAllTransactions() public view returns (RetailerCustomer.Transaction[] memory) {
        return delegate.getAllTransactions();
    }
}

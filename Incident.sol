// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./FarmerProcessor.sol";
import "./ProcessorRetailer.sol";
import "./RetailerCustomer.sol";

contract Incident {
    FarmerProcessor public farmerProcessor;
    ProcessorRetailer public processorRetailer;
    RetailerCustomer public retailerCustomer;

    constructor(address _farmerProcessorAddress, address _processorRetailerAddress, address _retailerCustomerAddress) {
        farmerProcessor = FarmerProcessor(_farmerProcessorAddress);
        processorRetailer = ProcessorRetailer(_processorRetailerAddress);
        retailerCustomer = RetailerCustomer(_retailerCustomerAddress);
    }

    /**
     * @dev Give a farmer's order id, trace all the transactions record in all smart contracts which involves this farmer's order id.
     * @param offerId The farmer's order id
     * @return An array of Offer structs, including 0: transactions record in FarmerProcessor.sol, 1: transactions records in ProcessorRetailer.sol, 2: transactions records in RetailerCustomer.sol
     */    
    function trace(uint offerId) public view returns (
        FarmerProcessor.Transaction memory, 
        ProcessorRetailer.Transaction[] memory, 
        RetailerCustomer.Transaction[] memory
    ) {
        // Get all transactions from each contract
        FarmerProcessor.Transaction[] memory farmerTransactions = farmerProcessor.getAllTransactions();
        ProcessorRetailer.Transaction[] memory processorTransactions = processorRetailer.getAllTransactions();
        RetailerCustomer.Transaction[] memory retailerTransactions = retailerCustomer.getAllTransactions();

        // Placeholder for the result
        FarmerProcessor.Transaction memory farmerTransaction;
        ProcessorRetailer.Transaction[] memory matchedProcessorTransactions = new ProcessorRetailer.Transaction[](processorTransactions.length);
        RetailerCustomer.Transaction[] memory matchedRetailerTransactions = new RetailerCustomer.Transaction[](retailerTransactions.length);

        uint processorCounter = 0;
        uint retailerCounter = 0;

        // Iterate over all transactions to find the ones that contain the offerId
        for (uint i = 0; i < farmerTransactions.length; i++) {
            if (farmerTransactions[i].offerId == offerId) {
                farmerTransaction = farmerTransactions[i];
                break;
            }
        }

        for (uint i = 0; i < processorTransactions.length; i++) {
            for (uint j = 0; j < processorTransactions[i].offerIds.length; j++) {
                if (processorTransactions[i].offerIds[j] == offerId) {
                    matchedProcessorTransactions[processorCounter] = processorTransactions[i];
                    processorCounter++;
                    break;
                }
            }
        }

        for (uint i = 0; i < retailerTransactions.length; i++) {
            for (uint j = 0; j < retailerTransactions[i].offerIds.length; j++) {
                if (retailerTransactions[i].offerIds[j] == offerId) {
                    matchedRetailerTransactions[retailerCounter] = retailerTransactions[i];
                    retailerCounter++;
                    break;
                }
            }
        }

        return (farmerTransaction, matchedProcessorTransactions, matchedRetailerTransactions);
    }
}

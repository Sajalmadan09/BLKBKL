// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Incident.sol";

contract IncidentDelegate {
    Incident public delegate;

    constructor(address _incidentAddress) {
        delegate = Incident(_incidentAddress);
    }

    function trace(uint offerId) public view returns (
        FarmerProcessor.Transaction memory, 
        ProcessorRetailer.Transaction[] memory, 
        RetailerCustomer.Transaction[] memory
    ) {
        return delegate.trace(offerId);
    }
}

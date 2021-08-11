// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// NOTE: Deploy this contract first
contract Called {
    address private immutable myself; 
    
    constructor() {
        myself = address(this); 
    }
    uint num; 
    
    event DelegateCallDetected(address caller);
    event DirectCallDetected();
    

    /** 
        Let's define a simple setter method, we will detect when it gets called directly or via delegate call
        The method relies on the fact `delegatecall` modifies the `address(this)` at runtime setting to the address of the caller contract 
        So if the we store the true `address(this)` of this contract, by setting it in the constructor and making sure it can't change by defining it as immutable, then we can detect a delegate call by a simple comparison 
    */
    function setVar(uint _num) public returns (uint) {
        num = _num; 
        if (address(this) != myself) {
            emit DelegateCallDetected(address(this));
        }
        else {
            emit DirectCallDetected();             
        }
        return num; 
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract Caller {
    event VarSetCaller_UninterpretedResult(bool success, bytes data);
    event VarSetCaller_InterpretedResult(bool success, uint data);

    /**
        Setter method to delegatecall a method with prototype `setVar(uint256)` of a given contract 
        We use it to call the other contract and trigger its delegatecall detection mechanism 

        If the contract does not exist or the prototype is not correct, the API returns `success=false` which gives the programmer more flexibility than reverting in managing the case 
        If the contract exists and the prototype is correct, the function is delegate called and `success=true` and `data` will forward what the called method returns 
        It is important to observe we need to capture the returned values as `bytes memory` since no implicit conversion to another type is possible --> it needs to be done explicitly 
     */
    function setVar(address _contract, uint _num) public {
        (bool success, bytes memory _data) = _contract.delegatecall(
            abi.encodeWithSignature("setVar(uint256)", _num)
        );
        
        emit VarSetCaller_UninterpretedResult(success, _data); 

        // Here we do an explicit conversion from the returned `bytes memory` array to the type `uint256` type we know it is right 
        uint data; 

        assembly {
            data := mload(add(_data, 32))
        }

        emit VarSetCaller_InterpretedResult(success, data); 
    }
}





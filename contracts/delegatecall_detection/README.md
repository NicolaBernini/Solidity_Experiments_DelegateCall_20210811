
# Overview 

How to detect if a given function has been called directly of via `delegatecall()` function from another contract 





# Delegate Call Detection Mechanism 

In this simple example, the contract defined in `called.sol` detects if its setter method is called directly or via `delegatecall()` by using the fact the `delegatecall()` changes the `address(this)` at runtime to the address of the caller contract 

So the idea is to store the true the `address(this)` of the called contract at construction time in an immutable variable and compare it with the `address(this)` of the setter method 

- for a direct call, they will be the same 

- for a delegate call, they will be different 





# Return Value Casting 

Another interesting aspect of using `delegatecall()` regards managing its return values 

The `dalegatecall()` returns 2 variables 

- `bool success` --> indicates whether the call has been successful 

  - if it is also `false` it means the call has failed, possible reasons are 

    - wrong contract address 

    - wrong function prototype

    - the function has been called but its execution has been reverted e.g. for a `require()` not passing 

  - if it is `true` then it is possible to check the next variable 

- `bytes memory data` --> it is a buffer containing the result of the call 

  - it is probably useful to cast this buffer to a specific type so to be able to easily manipulate this in the code, the proposed method relies on low level assembly 












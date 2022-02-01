pragma solidity 0.8.0;
// Directly send ETH to contract
// Executed when a non-existent function is called on the contract

/*
   1. no name
   2. only one fallback function in smart contract
   3. no arguments
   4. only visibility "external"
   5. if not marked payable, it will throw exeception if contract receives ETH
   6. cannot return anything
   7. Take data in form of bytes and take ETH too
*/

/* Receive -
   1. Always Payable
   2. Receive only ETH, no data
*/

contract FallbackReceive {

    bytes public data;
    fallback() external payable {
        data = msg.data;
    }

    function checkbal() external view returns(uint){
        return address(this).balance;
    } 

    receive() external payable {}

}

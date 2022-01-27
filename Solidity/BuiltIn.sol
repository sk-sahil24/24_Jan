pragma solidity 0.8.0;
  

contract BuiltIn { 
    
  
  address public admin;
    
  constructor() public {    
    admin = msg.sender;  
  }
 }

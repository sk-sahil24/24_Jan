// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;
  
contract Function {
  
   function add() public view returns(uint){
      uint num1 = 10; 
      uint num2 = 16;
      uint sum = num1 + num2;
      return sqrt(sum);
   }
   function sqrt(uint num) public view returns(uint){
       num = num ** 2;
       return num;
   }
}

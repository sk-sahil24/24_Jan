pragma solidity 0.8.0;

contract Memory {
 
  int[] public numbers;
  
  function Numbers() public
  {
    numbers.push(1);
    numbers.push(2); 
    int[] memory myArray = numbers;
    myArray[0] = 0;
  } 
}

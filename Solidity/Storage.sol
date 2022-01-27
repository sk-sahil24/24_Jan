//State variables and Local Variables of structs, array are always stored in storage by default
pragma solidity 0.8.0;

contract Storage {

    uint a; // outside of a function already make it storage variable
    int[] public numbers;
    function Numbers() public {
        numbers.push(1);
        numbers.push(2);
        int[] storage myArray = numbers;
        myArray[0] = 0;
  } 
}

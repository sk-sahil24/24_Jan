pragma solidity 0.8.0;

import './LibExample.sol';

contract LibraryPublic {
    
    using LibExample for uint;
    
    function getPow(uint num1, uint num2) public pure returns(uint) {
        return num1.pow(num2);
    }
}

pragma solidity 0.8.0;
// cannot declare state variable inside library.
// we're using library function inside another contract so it doesn't 
// make sense to make it external or private.
// as internal this function will be embedded  inside this contract that's 
// why we don't have to deploy the library.

library All {
    function max(uint value, uint value2) internal pure returns(uint){
        return value>=value2 ? value:value2;
    }
}

contract LibraryFile {
    function Maximum(uint _value,uint _value2) external pure returns(uint){
        return All.max(_value, _value2);
    }
}

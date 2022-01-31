pragma solidity 0.8.0;

library ArrayLib {
    function find(uint[] storage arr, uint value) internal view returns(uint) {
        for(uint i=0;i<arr.length;i++){
            if(arr[i] == value){
                return i;
            }
        }
        revert("not found");
    }
}

contract Library {
    using ArrayLib for uint[];
    uint[] arr = [10,20,30];
    function testFind(uint _value) external view returns(uint) {
        return arr.find(_value);
    }
}

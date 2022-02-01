pragma solidity 0.8.0;

contract MultipleModifier{
    uint public age = 20;

    modifier Same(uint _addAge){
        age = age + _addAge;
        _;
    }

    modifier Same2(uint _addAge){
        age = age + 2 + _addAge;
        _;
    }

    function changeAge(uint _newAge) external Same(_newAge) Same2(_newAge){

    }
}

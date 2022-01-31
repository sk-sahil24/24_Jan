pragma solidity 0.8.0;

contract Assert {
    uint public value = 0;

    function sub(uint a,uint b) external returns(uint){
        assert(a>b);
        value = a-b;
        return value;
    }

    function div(uint a,uint b) external returns(uint){
        if(a<=0 && b<=0){
            revert ("0 and below 0 is invalid");
        }
        value = a/b;
        return value;
    }

}

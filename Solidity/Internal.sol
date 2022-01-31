
// Internal -> Insdie the Smart contract but it can also be 
// called from smart contract who inherit from the smart contract
pragma solidity 0.8.0;

contract Internal {
    uint public value;

    function setValue(uint _value) internal {
        value = _value;
    }

}

contract Access is Internal {
    function result() external{
        setValue(500);
    }
}

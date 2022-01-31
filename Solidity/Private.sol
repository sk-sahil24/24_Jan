
// Private -> Inside The Smart Contract
pragma solidity 0.8.0;

contract Private {
    uint public value;

    function setValue(uint _value) private {
        value = _value;
    }

    function getValue() external returns(uint) {
        setValue(500);
        return value;
    }
}

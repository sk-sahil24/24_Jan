pragma solidity 0.8.0;

contract ContractFirst {

    address addressSecond;

    function setAddressSecond(address _addressSecond) external {
        addressSecond = _addressSecond;
    }

    function callget() external view returns(string memory) {
        ContractSecond b = ContractSecond(addressSecond);
        return b.get();
    }
}

contract ContractSecond {
    function get() external pure returns(string memory){
        return "Hello";
    }
}

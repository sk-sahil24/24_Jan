pragma solidity 0.8.0;

interface InFunctionSum {
   function getResult() external view returns(uint);
}

contract Interface {
    uint public resultValue;

    function CheckInterface(address _address) external {
      resultValue = InFunctionSum(_address).getResult();
   }
}

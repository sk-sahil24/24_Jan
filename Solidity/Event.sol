// Can't change & access.
// 3 parameters can be indexed.


pragma solidity 0.8.0;

contract Event {

    event Log(address indexed account, uint value,string message);

    function setData(uint val) external {
        
        emit Log(msg.sender,val,"value");
    }
}

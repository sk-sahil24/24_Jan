pragma solidity 0.8.0;

contract Modifier{
    address public mine=msg.sender;

    modifier admin() {
        require(mine == msg.sender, "Sorry, Only Admin");
        _;
    }

    function add() external view admin returns(uint){
        return 5;
    }

    function sub() external view admin returns(uint){
        return 10;
    }
}

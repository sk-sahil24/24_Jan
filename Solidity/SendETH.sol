pragma solidity 0.8.0;

contract SendETH{

    receive() external payable{}

    function checkbal() public view returns(uint){
        return address(this).balance;
    }

    function SendEth(address payable get) external{
        bool sent = get.send(1000000000000000000);
        require(sent,"Transaction Failed");
    }
    function Transfer(address payable get) external{
        get.transfer(1000000000000000000);
    }
    function Call(address payable get) external {
        (bool sent,) = get.call{value:1000000000000000000}("");
        require(sent,"Transaction Failed");
    }
}

contract GetETH{
    receive() external payable{}

    function checkbal() public view returns(uint){
        return address(this).balance;
    }

}

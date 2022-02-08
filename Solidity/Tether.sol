pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Tether is ERC20 {

    address private _admin;
    uint private _totalMarketCap;
    uint private _tokenPrice;

    mapping(address=>uint) private _userSellingPrice;
    mapping(address=>uint) private _userTokenSize;

    constructor(uint _totalMarketSupply,uint _supply,uint _price) ERC20("Tether","USDT"){
        _admin = msg.sender;
        _tokenPrice = _price; 
        _totalMarketCap = _totalMarketSupply*10**decimals();
        _mint(msg.sender,_supply*10**decimals());
    }

    modifier adminOnly{
        require(msg.sender == _admin,"Only admin can do this");
        _;
    }

    function mintMoreToken(uint _amount) external adminOnly{
        require(totalSupply()+_amount<=_totalMarketCap,"Max Supply Minted");
        _mint(msg.sender,_amount);
        emit Transfer(msg.sender,address(0),_amount);
    }

    function burnMoreToken(uint _amount) external adminOnly{
        require(balanceOf(msg.sender)>=_amount,"Insufficient Balance for burn");
        _burn(msg.sender,_amount);
        emit Transfer(msg.sender,address(0),_amount);

    }

    function buyTokenFromAdmin(uint _amount) external payable {
        require(msg.value>0,"Value is Zero");
        require(_amount<= balanceOf(_admin),"Insufficient Supply");
        require(_amount*_tokenPrice==msg.value,"Send amount is lower ya higher from require");
        payable(_admin).transfer(msg.value);
        _transfer(_admin,msg.sender,_amount);
    }

    function userSellToken(uint _price) external {
        require(_price>0,"Price of token Never be Zero");
        require(_price == _tokenPrice,"Price always equal to admin price");
        _userSellingPrice[msg.sender] = _price;
    }

    function userTokenSellSize(uint _amount) external{
        require(_amount<=balanceOf(msg.sender),"Insufficient Amount to sell");
        _userTokenSize[msg.sender]=_amount;
    }

    function p2p(address payable _sender, uint _amount) external payable {
        require(msg.value>0,"Value is Zero");
        require(_amount<=_userTokenSize[_sender],"Insufficient Balance of sender");
        require(_amount*_userSellingPrice[_sender]==msg.value,"Send amount is lower ya higher from require");
        _sender.transfer(msg.value);
        _transfer(_sender,msg.sender,_amount);
    }

    function derivativesFromAdmin(uint _leverage) external payable{
        require(msg.value>0,"Value is Zero");
        require((msg.value*_leverage)/_tokenPrice<= balanceOf(_admin),"Insufficient Supply");
        payable(_admin).transfer(msg.value);
        _transfer(_admin,msg.sender,(msg.value*_leverage)/_tokenPrice);
    }

    

}

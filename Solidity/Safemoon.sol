pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Safemoon is ERC20 {

    uint private _totalMarketCap;
    uint private _tokenPrice;
    uint private _totalPreSaleToken;
    uint private _maxTokenInPreSalePerAccount;
    address private _admin;
    address private _special;

    mapping(address=>bool) public whitelist;

    constructor(uint _totalMarketSupply,uint _supply) ERC20("Safemoon","SAFEMOON"){
        _admin = msg.sender;
        _totalMarketCap = _totalMarketSupply*10**decimals();
        _mint(msg.sender,_supply*10**decimals());
        _totalPreSaleToken = balanceOf(_admin)/2;
    }

    modifier adminOnly{
        require(msg.sender == _admin,"Only admin can do this");
        _;
    }

    modifier isWhitelisted(address _ads){
        require(whitelist[_ads],"Sorry,You are not Whitelist");
        _;
    }

    modifier totalPreSaleTokens(uint _amount){
        require(_totalPreSaleToken-_amount>=0,"Insufficient Supply");
        _totalPreSaleToken-=_amount;
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

    function setPerUserMaxPreSaleTokens(uint _amount) external adminOnly{
        _maxTokenInPreSalePerAccount = _amount;
    }

    function setTokenPreSalePrice(uint _price) external adminOnly{
        _tokenPrice = _price;
    }

    function setTokenSalePrice(uint _price) external adminOnly{
        _tokenPrice = _price;
    }

    function setTokenPostSalePrice(uint _price) external adminOnly{
        _tokenPrice = _price;
    }

    function setSpecialAddress(address _ads) external adminOnly{
        require(_totalPreSaleToken<=balanceOf(_admin),"You already Sold all Token in Sale");
        _special = _ads;
        _transfer(_admin,_ads,_totalPreSaleToken);
        _totalPreSaleToken=0;
    }

    function addToWhitelist(address _ads) external adminOnly{
        whitelist[_ads] = true;
    }

    function addManyToWhitelist(address[] memory _ads) external adminOnly{
        for(uint _num=0; _num<_ads.length;_num++){
            whitelist[_ads[_num]]=true;
        }
    }

    function removeFromWhitelist(address _ads) external adminOnly{
        whitelist[_ads] = false;
    } 

    function removeManyFromWhitelist(address[] memory _ads) external adminOnly{
        for(uint _num=0; _num<_ads.length;_num++){
            whitelist[_ads[_num]]=false;
        }
    }

    function buyTokenInPreSale(address _ads,uint _amount) external payable isWhitelisted(_ads) totalPreSaleTokens(_amount){
        require(msg.value>0,"Value is Zero");
        require(_amount<=_maxTokenInPreSalePerAccount,"Can't Buy more than limit");
        require(_amount*_tokenPrice==msg.value,"Send amount is lower ya higher from require");
        payable(_admin).transfer(msg.value);
        _transfer(_admin,msg.sender,_amount);
    }

    function buyTokenInSale(uint _amount) external payable {
        require(msg.value>0,"Value is Zero");
        require(_amount<= balanceOf(_admin),"Insufficient Supply");
        require(_amount*_tokenPrice==msg.value,"Send amount is lower ya higher from require");
        payable(_admin).transfer(msg.value); 
        _transfer(_admin,msg.sender,_amount);
    }

    function buyTokenInPostSale(uint _amount) external payable {
        require(msg.value>0,"Value is Zero");
        require(_amount<=balanceOf(_special),"Insufficient Supply");
        require(_amount*_tokenPrice==msg.value,"Send amount is lower ya higher from require");
        payable(_special).transfer(msg.value);
        _transfer(_special,msg.sender,_amount);
    }

}

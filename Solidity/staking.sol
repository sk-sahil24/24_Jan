pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Tether is ERC20 {
    
    address private _admin;
    uint private _totalMarketCap;
    uint private _tokenPrice;
    address[] private stakeholders;

    mapping(address => uint) private stakes;
    mapping(address => uint) private rewards;

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

    function isStakeholder(address _address) public view returns(bool, uint){
        for (uint s = 0; s < stakeholders.length; s += 1){
           if (_address == stakeholders[s]) return (true, s);
        }
        return (false, 0);
    }

    function addStakeholder(address _stakeholder) public{
       (bool _isStakeholder, ) = isStakeholder(_stakeholder);
       if(!_isStakeholder) stakeholders.push(_stakeholder);
    }

    function removeStakeholder(address _stakeholder) public{
       (bool _isStakeholder, uint s) = isStakeholder(_stakeholder);
       if(_isStakeholder){
           stakeholders[s] = stakeholders[stakeholders.length - 1];
           stakeholders.pop();
        }
    }

    function stakeOf(address _stakeholder) external view returns(uint){
       return stakes[_stakeholder];
    }

    function totalStakes() external view returns(uint){   
        uint _totalStakes = 0;
        for (uint s = 0; s < stakeholders.length; s += 1){
           _totalStakes +=stakes[stakeholders[s]];
       }
       return _totalStakes;
    }

    function createStake(uint _stake) external{
       _burn(msg.sender, _stake);
       if(stakes[msg.sender] == 0) addStakeholder(msg.sender);
       stakes[msg.sender] += (_stake);
    }

    function removeStake(uint _stake) external{
       stakes[msg.sender] -=(_stake);
       if(stakes[msg.sender] == 0) removeStakeholder(msg.sender);
       _mint(msg.sender, _stake);
    }

    function rewardOf(address _stakeholder) external view returns(uint){
       return rewards[_stakeholder];
    }

    function totalRewards() external view returns(uint){
       uint _totalRewards = 0;
       for (uint s = 0; s < stakeholders.length; s += 1){
           _totalRewards +=(rewards[stakeholders[s]]);
       }
       return _totalRewards;
    }

    function calculateReward(address _stakeholder) public view returns(uint){
       return stakes[_stakeholder] / 100;
    }

    function distributeRewards() external adminOnly{
       for (uint s = 0; s < stakeholders.length; s += 1){
           address stakeholder = stakeholders[s];
           uint reward = calculateReward(stakeholder);
           rewards[stakeholder] +=reward;
       }
    }

    function withdrawReward() external{
       uint reward = rewards[msg.sender];
       rewards[msg.sender] = 0;
       _mint(msg.sender, reward);
    }
    
}

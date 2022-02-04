pragma solidity 0.8.0;

interface ERC20 {

    function totalSupply() external view returns(uint);
    function balanceOf(address account) external view returns(uint);
    function transfer(address receiver, uint amount) external;
}

contract EverFTT is ERC20 {

    string public constant name = "EverFTT";
    string public constant symbol = "EFTT";
    uint public constant decimals = 6;

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);

    mapping(address=>uint) private balances;
    mapping(address=>mapping(address=>uint)) private allowed;

    uint _totalSupply = 5000 wei;
    address admin;

    constructor() {
        balances[msg.sender] = _totalSupply;
        admin = msg.sender;
    }

    function totalSupply() external override view returns(uint){
        return _totalSupply;
    }

    function balanceOf(address tokenOwner) external override view returns(uint){
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) external override {
        require(numTokens<=balances[msg.sender],"Insufficient Balance");
        balances[msg.sender]-=numTokens;
        balances[receiver]+=numTokens;
        emit Transfer(msg.sender,receiver,numTokens);
    }

    modifier adminOnly{
        require(msg.sender == admin,"Only admin can do this");
        _;
    }

    function mintMoreToken(uint token) external adminOnly{
        _totalSupply += token;
        balances[msg.sender] += token;
    } 

    function burnSomeToken(uint token) external adminOnly{
        require(balances[msg.sender]>=token,"Insufficient Balance for burn");
        _totalSupply -= token;
        balances[msg.sender] -= token;
    }

    function allowance(address owner, address spender) external view returns(uint remaining){
        return allowed[owner][spender];
    } 

    function approve(address spender, uint amount) external{
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender,amount);
    }

    function transferFrom(address from, address to, uint amount) external{
        uint _allowance = allowed[from][msg.sender];
        require(balances[from]>=amount && _allowance>=amount, "Either Balance ya Allowance is Insufficient");
        balances[to] += amount;
        balances[from] -= amount;
        allowed[from][msg.sender] -= amount;
        emit Transfer(from,to,amount);
    }

}


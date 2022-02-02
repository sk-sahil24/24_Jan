pragma solidity 0.8.0;

contract Bank {

    mapping(address => uint) public Account; 
    mapping(address => bool) public userCheck;

    constructor() payable {
        require(msg.value == 10 ether, "10 ETH initial required");
    }

    event DepositMade(address indexed accountAddress, uint amount);
    
    // Create User Bank Account
    function createAccount() external payable returns(string memory){
        require(userCheck[msg.sender]==false,"Account Exist");
        Account[msg.sender]=msg.value;
        userCheck[msg.sender]=true;
        return "Account Open";
    }

    //  Deposit ETH
    function deposit() external payable returns(string memory){
        require(userCheck[msg.sender]==true,"Account Not Exist");
        require(msg.value>0,"Value is Zero");
        Account[msg.sender]=Account[msg.sender]+msg.value;
        emit DepositMade(msg.sender, msg.value);
        return "Deposit Done";
    }

    // Transfer ETH
    function transfer(address payable ads,uint amount) external returns(string memory){
            require(userCheck[msg.sender]==true,"Account Not Exist");
            require(Account[msg.sender]>amount,"Insufficeint Balance");
            require(userCheck[ads]==true,"Transfer Account Not Exist In Bank");
            require(amount>0,"Value is Zero");
            Account[msg.sender]=Account[msg.sender]-amount;
            Account[ads]=Account[ads]+amount;
            return "Transfer Done";
        }

    //  Withdraw ETH
    function withdraw(uint withdrawAmount) external payable returns(string memory){
        require(userCheck[msg.sender]==true,"Account Not Exist");
        require(withdrawAmount>0,"Value is Zero");
        require(Account[msg.sender]>withdrawAmount,"Insufficeint Balance");
        Account[msg.sender]=Account[msg.sender]-withdrawAmount;
        payable(msg.sender).transfer(withdrawAmount);
        return "Withdraw Done";
    }

    // loan section
    function loanApply(address payable ads,uint amount) external returns(string memory){
            require(userCheck[ads]==true,"Account Not Exist In Bank");
            require(amount>0,"Value is Zero");
            require(address(this).balance>amount,"Insufficeint Balance in Bank");
            Account[ads]=Account[ads]+amount;
            return "Loan Done";
        }

    // Interest Saving Account
    function interestOnSavingAccount(address payable ads, uint rate, uint year) external returns(string memory){
            require(userCheck[ads]==true,"Account Not Exist In Bank");
            Account[ads]=Account[ads]+(Account[ads]*rate*year)/100;
            return "Your Interest";
    }

    // User Information
    function userInformation(address payable ads, string memory name, uint age, uint Id_Num) external view returns(string memory,uint,uint){ 
            require(userCheck[ads]==true,"Account Not Exist In Bank");
            return (name,age,Id_Num);
    }

    function TotalBankBalance() external view returns(uint){
        return address(this).balance;
    }



     function userAccountBalance() external view returns(uint){
      return Account[msg.sender];
  }

}

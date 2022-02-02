pragma solidity 0.8.0;

contract MultipleInheritance{
    function get() external pure virtual returns(string memory){
        return "In MultipleInheritance";
    }
}

contract change is MultipleInheritance{
    function get() external pure virtual override returns(string memory){
        return "In change";
    }
}

contract New is MultipleInheritance,change{
    function get() external pure virtual override(change,MultipleInheritance ) returns(string memory){
        return "In new";
    }
}



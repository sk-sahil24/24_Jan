pragma solidity 0.8.0;

contract Car{
    function color() external pure virtual returns(string memory){
        return "Red";
    }
    function check() external pure virtual returns(string memory){
        return "In contract Car";
    }
}

contract body is Car{

    function color() external pure override returns(string memory){
        return "Blue";
    }
    function check() external pure virtual override returns(string memory){
        return "In contract body";
    }
}

contract Engine is body{
    function check() external pure override returns(string memory){
        return "In contract Engine";
    }
}

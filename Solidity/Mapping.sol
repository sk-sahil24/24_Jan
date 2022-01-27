
pragma solidity 0.8.0;

contract Mapping {

    mapping(uint256 => string) map;

    function set(uint256 key, string memory value) public {
        map[key] = value;
    }

    function get(uint256 key) public view returns(string memory){
        return map[key];
    }

}

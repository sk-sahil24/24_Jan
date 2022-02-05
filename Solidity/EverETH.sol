pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EverETH is ERC20 {
    address public admin;
    constructor() ERC20("EverETH", "EETH"){
        admin = msg.sender;
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}

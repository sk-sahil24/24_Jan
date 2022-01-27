pragma solidity 0.8.0; 
  
 
contract Loop { 
      
    uint[] public data; 

    uint j = 0;    

    function loop() public returns(uint[] memory){
    while(j < 5) {
        j++;
        data.push(j);
     }
      return data;
    }
}

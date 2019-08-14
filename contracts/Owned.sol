pragma solidity ^0.5.8; 

contract Owned {
    
    address public owner; 
    
    constructor() public {
        owner = msg.sender; 
    }
 
     modifier isOwner() {
         require(owner == msg.sender); 
         _;
     }
     
     function setOwner(address newOwner) isOwner public {
        owner = newOwner;
    }
    
}
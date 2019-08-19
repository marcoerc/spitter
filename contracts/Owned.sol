pragma solidity ^0.5.8; 

contract Owned {
    
    address payable private owner; 
    event OwnershipChanged(address from, address to);
    
    constructor() public {
        owner = msg.sender; 
    }
 
    modifier isOwner() {
         require(owner == msg.sender, "OWN001: Only the owner can call this function!"); 
         _;
    }
     
    function setOwner(address payable newOwner) isOwner public returns (bool) {
        require(newOwner != address(0), "OWN002: Owner must be set to a non-zero address");
        emit OwnershipChanged(owner, newOwner);
        owner = newOwner;
        return true;
    }
    
}
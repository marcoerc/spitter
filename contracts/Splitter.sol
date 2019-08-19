import "./Stoppable.sol";

pragma solidity ^0.5.8;

//R: represents a requirement
//*: represents an arbitrary decision
contract Splitter is Stoppable(true) {
    
    //R: there are 3 people: Alice, Bob and Carol.
    //*: Don't understand if it should be general purpose or not. Assume it is not.

    address payable alice; 
    address payable bob; 
    address payable carol; 
    mapping(address => uint256) public balances;  



    constructor(address payable _bob, address payable _carol) public {
    	alice = msg.sender; //* Alice should be the owner of the contract
        bob = _bob; 
        carol = _carol; 
    }
    
    
    //R: whenever alice sends ether to the contract for it to be split, half of it goes to Bob and the other half to Carol.
    function split() isRunning payable public {
        require(msg.sender == alice);
        uint256 value = msg.value; 
        if (value % 2 > 0) {
            // What should I do with that? Well I suppose should be sent back.
            value -= 1;
            balances[alice] += 1;
        }
        uint256 txAmount = value / 2; 
        balances[bob] += txAmount;
        balances[carol]+= txAmount;
    }

    function withdraw(uint256 amount) isRunning public returns (bool) {
        require(msg.sender != address(0), "Invalid transaction, empty address");
        require(balances[msg.sender] >= amount, "SPTR001: Insufficient balance, cannot withdraw.");
        require(amount > 0, "SPTR002: cannot withdraw a negative amount");
        balances[msg.sender] -= amount; 
        msg.sender.transfer(amount);
        return true;
    }
    
   
    function() payable external { 
    	revert("Fallback function not available. Call the contract in the proper way.");
    }

}
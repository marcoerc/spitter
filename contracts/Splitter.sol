import "./Stoppable.sol";

pragma solidity ^0.5.8;

//R: represents a requirement
//*: represents an arbitrary decision
contract Splitter is Stoppable {
    
    //R: there are 3 people: Alice, Bob and Carol.
    //*: Don't understand if it should be general purpose or not. Assume it is not.

    address payable alice; 
    address payable bob; 
    address payable carol; 
    
    constructor(address payable _bob, address payable _carol) public {
    	address empty = address(0);
    	//require(msg.sender != empty && bob != empty && carol != empty);
    	alice = address(uint160(owner)); //* Alice should be the owner of the contract
        bob = _bob; 
        carol = _carol; 
    }
    
    //R: we can see the balance of the Splitter contract on the Web page.
    //*: that is not strictly necessary
    function getBalance() public returns (uint256) {
        return address(this).balance;
    }
    
    //R: whenever alice sends ether to the contract for it to be split, half of it goes to Bob and the other half to Carol.
    function split() isRunning payable public {
        require(msg.sender == alice);
        uint256 value = msg.value; 
        if (value % 2 > 0) {
            // What should I do with that? Well I suppose should be sent back.
            value -= 1;
            alice.transfer(1);
        }
        uint256 txAmount = value / 2; 
        bob.transfer(txAmount);
        carol.transfer(txAmount);
    }
    
    //R: we can see the balances of alice, Bob and Carol on the Web page.
    //*: that is not strictly necessary
    function getBalanceOf(address _addr) public returns (uint256){
        require (_addr == bob || _addr == alice || _addr == carol);
        return _addr.balance;
    }
    
    //R: alice can use the Web page to split her ether.
    //*: that must happen outside of a contract.
    

    function() payable external { 
    	require(msg.data.length == 0); 
    }

}
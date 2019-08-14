pragma solidity ^0.5.8; 

import "./Owned.sol"; 

contract Stoppable is Owned {

	bool public running; 

	constructor() public {
		running = true;
	}

	modifier isRunning {
		require(running);
		_;
	}

	function stop() isOwner public {
		running = false; 
	}

	function start() isOwner public {
		running = true;
	}
}
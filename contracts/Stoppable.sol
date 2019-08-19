pragma solidity ^0.5.8; 

import "./Owned.sol"; 

contract Stoppable is Owned {

	bool private running; 

	constructor(bool start) public {
		running = start;
	}

	modifier isRunning {
		require(running, "RUN001: The contract is not in a running state.");
		_;
	}

	modifier isPaused {
		require(!running, "RUN002: The contract is not in a paused state.");
		_;
	}

	function stop() isOwner isRunning public {
		running = false; 
	}

	function start() isOwner isPaused public {
		running = true;
	}
}
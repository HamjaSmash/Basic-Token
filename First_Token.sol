// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address public owner ;

    constructor () {
        owner = msg.sender ;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "You are not the owner, you can't call it");
        _;
    }
}

contract Pausable is Ownable {
    bool public paused ;

    modifier whenNotPaused(){
        require(!paused, "Contract is paused" );
        _;
    }

    function pause() public onlyOwner {
        paused = true ;
    }

    function unpause() public onlyOwner{
        paused = false;
    }
}

contract Token is Ownable,Pausable {
    mapping (address => uint) public balances;

    function transfer(address to, uint amount) public whenNotPaused {
        require(balances[msg.sender] >= amount, "Insufficient Balance");

        balances[msg.sender] -= amount ;
        balances[to] += amount ;

    }

    function mint(address to, uint amount) public onlyOwner {
        balances[to] += amount ;
    }
}




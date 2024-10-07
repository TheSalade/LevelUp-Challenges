// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./ERC20.sol";

contract TRTtheSalad is ERC20 {
    // Global variables for token name, symbol, and total supply
    string public _tokenName;
    string public _tokenSymbol;
    uint256 public _totalSupply;

    // Constructor that mints the initial supply to the deployer of the contract
    constructor(uint256 initialSupply) ERC20(_tokenName, _tokenSymbol) {
        _tokenName = "TRTtheSalad";         
        _tokenSymbol = "TRT";           
        _totalSupply = initialSupply;    
        _mint(msg.sender, initialSupply); 
    }
    // Function to mint new tokens to a specified address
    function mint(address to, uint256 amount) public {
        _mint(to, amount); // Call the _mint function from ERC20
        _totalSupply += amount; // Update the total supply
    }

    // Function to burn tokens from a specified address
    function burn(address from, uint256 amount) public {
        _burn(from, amount); // Call the _burn function from ERC20
        _totalSupply -= amount; // Update the total supply
    }

    // Override the transfer function to send tokens from the caller's address to a specified address
    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), to, amount); // Call the _transfer function from ERC20
        return true;
    }

    // Override the approve function to authorize another address to spend a certain amount of tokens
    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount); // Call the _approve function from ERC20
        return true;
    }

    // Override the transferFrom function to allow a spender to transfer tokens using an allowance
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        _transfer(from, to, amount); // Call the _transfer function from ERC20
        _approve(from, _msgSender(), allowance(from, _msgSender()) - amount); // Decrease the allowance
        return true;
    }

    // Function to get the balance of a specified account
    function getBalanceOf(address account) public view returns (uint256) {
        return balanceOf(account); // Return the balance of the account
    }

    // Getter functions for the global variables
    function getTokenName() public view returns (string memory) {
        return _tokenName;
    }

    function getTokenSymbol() public view returns (string memory) {
        return _tokenSymbol;
    }

    function getTotalSupply() public view returns (uint256) {
        return _totalSupply;
    }
}

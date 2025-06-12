// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyMint is ERC20, Ownable {

    string public constant tokenName = "Toffee Tokens"; // Token name
    string public constant tokenSymbol = "TOFF";        // Token symbol
    uint8 public constant tokenDecimals = 18;           // Decimal places
    uint256 public constant maxTokenSupply = 1_000_000 * (10 ** uint256(tokenDecimals)); // Max total supply

    event Minted(address indexed to, uint256 amount); // Custom event for minting

    constructor() ERC20(tokenName, tokenSymbol) {
        // Token is initialized with name and symbol.
        // No tokens are minted yet.
    }

    function mintFunction(uint256 amountToMint) public onlyOwner {
        // Ensure minting won't exceed the max supply.
        uint256 currentSupply = totalSupply();
        require(
            currentSupply + amountToMint <= maxTokenSupply,
            "Minting the amount requested would exceed the max supply allowed."
        );

        _mint(msg.sender, amountToMint);
        emit Minted(msg.sender, amountToMint); // Emit mint event
    }
}

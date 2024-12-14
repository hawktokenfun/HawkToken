// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts@5.1.0/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts@5.1.0/access/Ownable.sol";

contract Hawk is ERC20, Ownable {
    address private constant BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;

    constructor() ERC20("Hawk", "Hawk") Ownable(msg.sender) {
        
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        
        uint256 burnAmount = (amount * 1) / 100;
        uint256 transferAmount = amount - burnAmount;

        
        _transfer(_msgSender(), BURN_ADDRESS, burnAmount);

        
        _transfer(_msgSender(), recipient, transferAmount);

        return true;
    }

    
    function renounceOwnershipManually() external onlyOwner {
        renounceOwnership();
    }
}

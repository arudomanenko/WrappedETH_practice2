// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract WETH is ERC20 {
    constructor() ERC20("Wrapped Ether", "WETH") {}

    function mint() external payable {
        require(msg.value > 0, "Cannot mint zero ETH");
        _mint(msg.sender, msg.value);
    }

    function burn(uint256 amount) external {
        require(amount > 0, "Cannot burn zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient WETH balance");
        require(
            address(this).balance >= amount,
            "Contract has insufficient ETH"
        );

        _burn(msg.sender, amount);

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "ETH transfer failed");    
    }

    function reserves(address user) external view returns (uint256) {
        return balanceOf(user);
    }
}

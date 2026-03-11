// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {WETH} from "../src/WETH.sol";

contract WETHTest is Test {
    WETH public weth;
    address public user;

    function setUp() public {
        weth = new WETH();
        user = address(1);
        vm.deal(user, 100 ether);
    }

    function test_MintMintsTokensAndHoldsEth() public {
        uint256 amount = 1 ether;

        vm.prank(user);
        weth.mint{value: amount}();

        assertEq(weth.balanceOf(user), amount, "user WETH balance");
        assertEq(weth.reserves(user), amount, "reserves view");
        assertEq(address(weth).balance, amount, "contract ETH balance");
        assertEq(weth.totalSupply(), amount, "total supply");
    }

    function test_MintZeroReverts() public {
        vm.prank(user);
        vm.expectRevert(bytes("Cannot mint zero ETH"));
        weth.mint{value: 0}();
    }

    function test_BurnBurnsTokensAndReturnsEth() public {
        uint256 amount = 2 ether;

        vm.prank(user);
        weth.mint{value: amount}();

        uint256 contractBalanceBefore = address(weth).balance;
        uint256 userWethBalanceBefore = weth.balanceOf(user);

        vm.prank(user);
        weth.burn(1 ether);

        assertEq(
            weth.balanceOf(user),
            userWethBalanceBefore - 1 ether,
            "user WETH balance after burn"
        );
        assertEq(
            address(weth).balance,
            contractBalanceBefore - 1 ether,
            "contract ETH balance after burn"
        );
        assertEq(
            weth.totalSupply(),
            contractBalanceBefore - 1 ether,
            "total supply after burn"
        );
    }

    function test_BurnZeroReverts() public {
        vm.prank(user);
        vm.expectRevert(bytes("Cannot burn zero"));
        weth.burn(0);
    }

    function test_BurnMoreThanBalanceReverts() public {
        uint256 amount = 1 ether;

        vm.prank(user);
        weth.mint{value: amount}();

        vm.prank(user);
        vm.expectRevert(bytes("Insufficient WETH balance"));
        weth.burn(amount + 1);
    }

    function test_BurnWhenContractHasInsufficientEthReverts() public {
        uint256 amount = 2 ether;

        vm.prank(user);
        weth.mint{value: amount}();

        deal(address(weth), 1 ether);

        vm.prank(user);
        vm.expectRevert(bytes("Contract has insufficient ETH"));
        weth.burn(amount);
    }
}

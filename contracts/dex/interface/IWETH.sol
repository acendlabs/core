// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2;

import "./IERC20.sol";

interface IWETH is IERC20 {
    function withdraw(uint256 amount) external;

    function deposit() external payable;
}

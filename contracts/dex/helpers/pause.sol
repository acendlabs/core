// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Pause is Ownable {
    mapping(address => bool) internal user;

    // returns the swap state for a user
    function _isActive(address caller) {
        return user[caller];
    }

    // user can pause yak swaps on his address
    function _setActiveStateUser(bool state) public {
        address caller = msg.sender;
        user[caller] = state;
    }

    // admin can pause yak swaps for a user
    function _setActiveStateUserAdmin(bool state, address _to) public onlyOwner {
        user[_to] = state;
    }
}

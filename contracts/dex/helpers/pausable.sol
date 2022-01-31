// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/utils/Context.sol";
import "./Pause.sol";

abstract contract Pausable {
    function activeUser(address caller) public view virtual returns (bool) {
        return _isActive(caller);
    }

    modifier notPaused() {
        require(activeUser(_msgSender()), "Pausable: caller is paused");
        _;
    }
}

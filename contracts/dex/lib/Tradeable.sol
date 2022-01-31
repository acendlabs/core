// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";

/* this contract returns a list of Tokens tradeable on the dex */

contract Tradeable is Ownable {
    string[] private symbols;
    mapping(address => bool) public isTradeable;

    function listToken(string memory _sym, address _token) public onlyOwner {
        tokens.push(_token);
        isTradeable[_token] = true;
    }

    function delistToken(string memory _sym, address _addr) public onlyOwner {
        for (uint256 i = 0; i < symbols.length; i++) {
            if (keccak256(bytes(symbols[i])) == keccak256(bytes(_sym))) {
                symbols[i] = symbols[symbols.length - 1];
                symbols.pop();
            }
        }
        isTradeable[_addr] = false;
    }

    function getTradeableTokens() public view returns (string[] memory) {
        return symbols;
    }

    function getNumberOfTokens() public view returns (uint256) {
        return symbols.length;
    }

    function isAllowed(address _address) external reurns(bool) {
        return isTradeable[_address];
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract OsmosDao is ERC20, ERC20Permit, ERC20Votes {
    uint256 public constant minimunMintInterval = 365 days; // 1 year
    uint256 public constant mintCap = 200; // 2%
    uint256 public constant nextMint; // Timestamp

    constructor(uint256 totalSupply) ERC20("Acendao", "ACD") ERC20Permit("Acendao") {
        _mint(msg.sender, totalSupply * 10**decimals());
    }

    /**
     * @dev mints new tokens. can only be executed once a year by the owner
     * cannot exceed the mint capacity of (totalSupply * mintCap) / 10000
     * @param to: the address the new tokens to
     * @param amount: the quantity of tokens to mint.
     */
    function mint(address to, uint256 amount) external onlyOwner {
        require(amount <= (totalSupply() * mintCap) / 10000, "mint something smaller");
        require(block.timestamp >= nextMint, "not yet time to mint");
        nextMint = block.timestamp + minimunMintInterval;
        _mint(to, amount);
    }

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount) internal override(ERC20, ERC20Votes) {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount) internal override(ERC20, ERC20Votes) {
        super._burn(account, amount);
    }

    function decimals() public pure override returns (uint8) {
        return 9;
    }
}

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
this contract feeds verifiable token price for setting limit orders
**/
contract Feeder is Ownable {
    mapping(string => AggregatorV3Interface) internal feeds;
    mapping(string => bool) exists;

    /**
     * Network: Rinkeby
     * Aggregator: ETH/USD
     * Address: 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
     */
    constructor() public {
        feeds["ETH"] = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        exists["ETH"] = true;
    }

    event AddFeed(string _sym);

    function createFeed(string memory _tokenSymbol, address _tokenAddress) public onlyOwner {
        feeds[_tokenSymbol] = AggregatorV3Interface(_tokenAddress);
        exists[_tokenSymbol] = true;
        emit AddFeed(_tokenSymbol);
    }

    function checkFeedExists(string memory _tokenSymbol) public view returns (bool) {
        return exists[_tokenSymbol];
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice(string memory _tokenSymbol) public view returns (int256) {
        (uint80 roundID, int256 price, uint256 startedAt, uint256 timeStamp, uint80 answeredInRound) = feeds[_tokenSymbol]
            .latestRoundData();
        return price;
    }
}

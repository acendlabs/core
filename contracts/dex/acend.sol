// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "https://github.com/yieldyak/yak-aggregator/contracts/interface/IYakRouter.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

/* this contract calls/perfoms limit and market swap using yield yak **/
contract Spot {
    address internal constant YYROUTER_ADDRESS = 0xC4729E56b831d74bBc18797e0e17A295fA77488c;
    IYakRouter public router;

    struct trade {
        uint256 amountIn;
        uint256 amountOut;
        address[] path;
        address[] adapters;
    }

    constructor() {
        router = IYakRouter(YYROUTER_ADDRESS);
    }

    function findPath(
        uint256 amountIn,
        address tokenIn,
        address tokenOut,
        uint256 steps,
        uint256 gasPrice
    ) {
        router.findBestPathWithGas(amountIn, tokenIn, tokenOut, steps, gasPrice);
    }

    function buy() {
        router.swapNoSplitFromAvaxWithPermit(trade, to, fee);
    }

    function sell() {
        router.swapNoSplitToAVAXWithPermit(trade, to, fee);
    }
}

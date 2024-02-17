// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20Implementation} from "./ERC20Implementation.sol";

/**
   * @title PogTokenContract
   * @dev ContractDescription
   * @custom:dev-run-script scripts/deploy_with_ethers.ts
   */

contract PogTokenContract is ERC20Implementation {
    constructor() ERC20Implementation("PogToken", "POG") {
        _mint(msg.sender, 42069 * (10 ** decimals()));
    }
}
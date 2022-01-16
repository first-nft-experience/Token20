// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20MinerReward is ERC20 {

    event LogNewAlert(string description, address indexed _from, uint256 _n);

    address public creatorAddr;

    constructor() ERC20("MinerRewardB", "MRWB") {
        creatorAddr = msg.sender; //set the creator address
    }

    function _reward() public {
        _mint(creatorAddr, 20);
        emit LogNewAlert('_rewarded', creatorAddr, block.number);
    }

}
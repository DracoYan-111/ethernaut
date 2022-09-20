// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '@openzeppelin/contracts/math/SafeMath.sol';

contract GatekeeperOne {

    using SafeMath for uint256;
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        require(gasleft().mod(8191) == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(tx.origin), "GatekeeperOne: invalid gateThree part three");
        _;
    }

    function enter(bytes8 _gateKey) public gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}

contract GatekeeperOne1 {
    function enterTest(uint256 gasAmount,GatekeeperOne gatekeeperOne) public {
        gatekeeperOne.enter{gas:gasAmount}(getTxOrgin2());
    }

    function getTxOrgin2() public view returns (bytes8 origin){
        origin = bytes8(uint64(uint160(tx.origin))) & 0xFFFFFFFF0000FFFF;
    }

    //================test===================
    function getTxOrgin() public view returns (bytes8 origin){
        origin = bytes8(uint64(uint160(tx.origin))) & 0xFFFFFFFFFFFFFFFF;
    }

    function getTxOrgin1() public view returns (bytes8 origin){
        origin = bytes8(uint64(uint160(tx.origin))) & 0xFFFFFFFFFF0000FF;
    }
}

contract GatekeeperOneTest {
    function getTest(bytes8 _gateKey) public pure returns (uint16){
        return uint16(uint64(_gateKey));
    }

    function getTest1(bytes8 _gateKey) public pure returns (uint32){
        return uint32(uint64(_gateKey));
    }

    function getTest2(bytes8 _gateKey) public pure returns (uint16){
        return uint16(uint32(uint64(_gateKey)));
    }

    function getTest0(bytes8 _gateKey) public pure returns (uint64){
        return uint64(_gateKey);
    }

    function getTest02() public view returns (uint16){
        return uint16(tx.origin);
    }

    function getTsest01(bytes8 _gateKey) public pure returns (bool isPass){
        //isPass = getTest(_gateKey) == getTest1(_gateKey)==getTest2(_gateKey) ?true:false;
        if (getTest(_gateKey) == getTest1(_gateKey)) {
            if (getTest1(_gateKey) == getTest2(_gateKey)) {
                if (getTest(_gateKey) == getTest2(_gateKey)) {
                    isPass = true;
                }
            }
        }
    }
}


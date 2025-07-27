// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanToInt {
    function romanToInt(string memory s) public pure returns (uint256) {
        bytes memory str = bytes(s);
        uint256 total = 0;
        uint256 prev = 0;
        for (uint256 i = str.length; i > 0; i--) {
            uint256 value = getValue(str[i - 1]);
            if (value < prev) {
                total -= value;
            } else {
                total += value;
            }
            prev = value;
        }
        return total;
    }

    function getValue(bytes1 c) internal pure returns (uint256) {
        if (c == "I") return 1;
        if (c == "V") return 5;
        if (c == "X") return 10;
        if (c == "L") return 50;
        if (c == "C") return 100;
        if (c == "D") return 500;
        if (c == "M") return 1000;
        return 0;
    }
}
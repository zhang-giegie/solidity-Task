// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract StringReverse{
    // 反转字符串
    function reverse(string memory str) public pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        uint len = strBytes.length;
        for (uint i = 0; i < len / 2; i++) {
            // 交换前后字符
            bytes1 temp = strBytes[i];
            strBytes[i] = strBytes[len - 1 - i];
            strBytes[len - 1 - i] = temp;
        }
        return string(strBytes);
    }

}
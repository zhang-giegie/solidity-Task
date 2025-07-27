// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSortedArray {
    function merge(uint[] memory arr1, uint[] memory arr2) public pure returns (uint[] memory) {
        uint m = arr1.length;
        uint n = arr2.length;
        uint[] memory result = new uint[](m + n);
        uint i = 0;
        uint j = 0;
        uint k = 0;
        while (i < m && j < n) {
            if (arr1[i] < arr2[j]) {
                result[k++] = arr1[i++];
            } else {
                result[k++] = arr2[j++];
            }
        }
        while (i < m) {
            result[k++] = arr1[i++];
        }
        while (j < n) {
            result[k++] = arr2[j++];
        }
        return result;
    }
}

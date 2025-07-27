// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 二分查找 (Binary Search)
// 题目描述：在一个有序数组中查找目标值。
contract BinarySearch {
    function binarySearch(uint[] memory arr,uint target)public pure returns(int){
        int result = -1;
        uint start = 0;
        uint end = arr.length -1;
        while (start <= end){
            uint mid = start + (end - start)/2;
            if (arr[mid] > target)
                end = mid - 1;
            else if (arr[mid] < target)
                start = mid + 1;
            else {
                result = int(mid) ;  
                break;
            }
        }
    
        return result;
    }
}
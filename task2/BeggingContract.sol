// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

//https://sepolia.etherscan.io/address/0xBE4bD0A2D1f100c09FF89D8F12554DF486eAF632
contract BeggingContract{
    address public owner;
    uint256 public startTime;
    uint256 public endTime;
    // 记录每个捐赠者的捐赠总额
    mapping(address => uint256) public donations;

    // 捐赠者地址数组，用于排行榜
    address[] public donors;

    //捐赠事件
    event Donation(address indexed donor, uint256 amount);
    
    //只允许合约拥有者调用的修饰符
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    //只允许在指定时间段内捐赠
    modifier onlyDuringDonationTime() {
        require(block.timestamp >= startTime && block.timestamp <= endTime, "Not within the donation time frame");
        _;
    }

    constructor() {
        owner = msg.sender;
        startTime = block.timestamp;
        endTime = block.timestamp + 60 days;
    }

    //捐赠函数
    function donate() external payable onlyDuringDonationTime {
        require(msg.value > 0, "Donation amount must be greater than 0");
        // 如果这是一个新的捐赠者，将其添加到捐赠者地址数组中
        if (donations[msg.sender] == 0) {
            donors.push(msg.sender);
        }
        donations[msg.sender] += msg.value;
        emit Donation(msg.sender, msg.value);
    }


    // 提现函数，只能合约拥有者调用
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");
        payable(owner).transfer(balance);
    }

    // 查询某个地址的捐赠金额
    function getDonation(address _donor) external view returns (uint256) {
        return donations[_donor];
    }

     // 获取捐赠排行榜前3名
    function getTop3Donors() external view returns (address[3] memory topDonors, uint256[3] memory topAmounts) {
        uint256[3] memory amounts;
        address[3] memory addrs;

        for (uint256 i = 0; i < donors.length; i++) {
            uint256 amount = donations[donors[i]];
            if (amount > amounts[0]) {
                // 下移
                amounts[2] = amounts[1];
                addrs[2] = addrs[1];
                amounts[1] = amounts[0];
                addrs[1] = addrs[0];
                amounts[0] = amount;
                addrs[0] = donors[i];
            } else if (amount > amounts[1]) {
                amounts[2] = amounts[1];
                addrs[2] = addrs[1];
                amounts[1] = amount;
                addrs[1] = donors[i];
            } else if (amount > amounts[2]) {
                amounts[2] = amount;
                addrs[2] = donors[i];
            }
        }
        return (addrs, amounts);
    }

    // 获取合约余额
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

}
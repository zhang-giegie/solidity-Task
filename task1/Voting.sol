// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Voting{

    // mapping存储候选人的得票数
    mapping(string => uint256) private votes;

    // 候选人列表（用于resetVotes时遍历）
    string[] private candidates;

    // 判断候选人是否已存在
    mapping(string => bool) private isCandidate;

    // 投票函数，允许用户给某个候选人投票
    function vote(string memory candidate) public {
        if (!isCandidate[candidate]) {
            candidates.push(candidate);
            isCandidate[candidate] = true;
        }
        votes[candidate]+=1;
    }

    function getVotes(string memory candidate)public view returns(uint256){
        return votes[candidate];
    }

    function resetVotes()public{
        for (uint i =0;i<candidates.length;i++){
            votes[candidates[i]]=0;
        }
    }


}
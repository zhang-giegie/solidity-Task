// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//测试网地址https://sepolia.etherscan.io/address/0x53d4818F00Cf0c4a340ee70DCddfc8472CF7972C
contract SimpleERC20{

    string public name = "SimpleToken";
    string public symbol = "STK";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * 10 ** uint256(decimals);
    address public owner;

    // 账户余额
    mapping(address => uint256) public balanceOf;
    // 授权额度
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // 转账
    function transfer(address to, uint256 value) public returns (bool) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // 授权
    function approve(address spender, uint256 value) public returns(bool){
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    // 代扣转账
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Allowance exceeded");
        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    
    // 铸币
    function mint(address to, uint256 value) public onlyOwner{
        balanceOf[to] += value;
        totalSupply += value;
        emit Transfer(address(0), to, value);
    }


}
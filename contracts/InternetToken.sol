// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract InternetToken {

    string public name = "Internet Token";
    string public symbol = "ITK";
    uint public totalSupply = 1000000;
    address public owner;

    mapping (address => uint) balances;

    event Transfer(address indexed _from, address indexed _to, uint _amount);

    modifier onlyOwner() {
        require(owner == msg.sender, "Caller is not the owner");
        _;
    }

    constructor() {
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    function mint(address _to, uint _amount) public onlyOwner {
        require(_amount < 1e60, "Maximum Exceeded");
        balances[_to] += _amount;
    }

    function transfer(address _to, uint _amount) public {
        require(balances[msg.sender] >= _amount, "Not enough tokens");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
    }

    function balanceOf(address _addr) external view returns (uint) {
        return balances[_addr];
    }
}
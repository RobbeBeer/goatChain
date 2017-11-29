pragma solidity ^0.4.0;


contract ERC20 {
    uint256 public totalSupply;
    string public name;
    string public symbol;
    uint8 public decimals;
    function balanceOf(address _who) public view returns (uint256);
    function transfer(address _to, uint256 _value) public returns (bool);
    function allowance(address _owner, address _spender) public view returns (uint256);
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool);
    function approve(address _spender, uint256 _value) public returns (bool);
    event Approval(address indexed _owner, address indexed _spender, uint256 value);
    event Transfer(address indexed _from, address indexed _to, uint256 value);
}

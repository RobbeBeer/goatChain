pragma solidity ^0.4.0;

import "./ERC20.sol";
import "./ConvertLib.sol";
import "./SafeMath.sol";


contract GoatCoin is ERC20 {

    using SafeMath for uint256;
    uint public INITIAL_SUPPLY = 20000;

    // This creates an array with all balances
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;

    function GoatCoin() {
        totalSupply = INITIAL_SUPPLY * 10 ** uint256(decimals);
        balances[msg.sender] = totalSupply;
        name = 'GoatCoin';
        symbol = 'G.O.A.T';
        decimals = 18;
    }

    function balanceOf(address _who) public view returns (uint256) {
        return balances[_who];
    }
    function transfer(address _to, uint256 _value) public returns (bool) {
        _transfer(msg.sender, _to, _value);
        return true;
    }
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_value <= allowed[_from][msg.sender]);     // Check allowance
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        _transfer(_from, _to, _value);
        return true;
    }
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        return true;
    }

    function balanceOfInEth(address _who) returns(uint){
        return ConvertLib.convert(balanceOf(_who),5);
    }

    /**
     * Internal transfer, only can be called by this contract
     */
    function _transfer(address _from, address _to, uint _value) internal {
        // Prevent transfer to 0x0 address. Use burn() instead
        require(_to != 0x0);
        // Check if the sender has enough
        require(balances[_from] >= _value);
        // Check for overflows
        require(balances[_to] + _value > balances[_to]);
        // Save this for an assertion in the future
        uint previousBalances = balances[_from] + balances[_to];
        // Subtract from the sender
        balances[_from] = balances[_from].sub(_value);
        // Add the same to the recipient
        balances[_to] = balances[_to].add(_value);
        Transfer(_from, _to, _value);
        // Asserts are used to use static analysis to find bugs in your code. They should never fail
        assert(balances[_from] + balances[_to] == previousBalances);
    }


}

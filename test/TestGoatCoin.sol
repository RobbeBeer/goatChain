pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/GoatCoin.sol";

contract TestGoatCoin {

  function testInitialBalanceUsingDeployedContract() {
    GoatCoin goat = GoatCoin(DeployedAddresses.GoatCoin());

    uint expected = 20000;

    Assert.equal(goat.balanceOf(tx.origin), expected, "Owner should have 20000 GoatCoin initially");
  }

}

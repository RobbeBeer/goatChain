var GoatCoin = artifacts.require("./GoatCoin.sol");

contract('GoatCoin', function(accounts) {
  it("should put 20000 GoatCoin in the first account", function() {
    return GoatCoin.deployed().then(function(instance) {
      return instance.balanceOf.call(accounts[0]);
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 20000, "20000 wasn't in the first account");
    });
  });
  it("should call a function that depends on a linked library", function() {
    var goat;
    var goatCoinBalance;
    var goatCoinEthBalance;

    return GoatCoin.deployed().then(function(instance) {
      goat = instance;
      return goat.balanceOf.call(accounts[0]);
    }).then(function(outCoinBalance) {
      goatCoinBalance = outCoinBalance.toNumber();
      return goat.balanceOfInEth.call(accounts[0]);
    }).then(function(outCoinBalanceEth) {
      goatCoinEthBalance = outCoinBalanceEth.toNumber();
    }).then(function() {
      assert.equal(goatCoinEthBalance, 5 * goatCoinBalance, "Library function returned unexpeced function, linkage may be broken");
    });
  });

  it("should transfer coins correctly", function() {
    var goat;

    //    Get initial balances of first and second account.
    var account_one = accounts[0];
    var account_two = accounts[1];

    var account_one_starting_balance;
    var account_two_starting_balance;
    var account_one_ending_balance;
    var account_two_ending_balance;

    var amount = 10;

    return GoatCoin.deployed().then(function(instance) {
      goat = instance;
      return goat.balanceOf.call(account_one);
    }).then(function(balance) {
      account_one_starting_balance = balance.toNumber();
      return goat.balanceOf.call(account_two);
    }).then(function(balance) {
      account_two_starting_balance = balance.toNumber();
      return goat.transfer(account_two, amount, {from: account_one});
    }).then(function() {
      return goat.balanceOf.call(account_one);
    }).then(function(balance) {
      account_one_ending_balance = balance.toNumber();
      return goat.balanceOf.call(account_two);
    }).then(function(balance) {
      account_two_ending_balance = balance.toNumber();

      assert.equal(account_one_ending_balance, account_one_starting_balance - amount, "Amount wasn't correctly taken from the sender");
      assert.equal(account_two_ending_balance, account_two_starting_balance + amount, "Amount wasn't correctly sent to the receiver");
    });
  });
});

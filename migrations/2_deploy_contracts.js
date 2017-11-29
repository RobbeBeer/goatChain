var ConvertLib = artifacts.require("./ConvertLib.sol");
var SafeMath = artifacts.require("./SafeMath.sol");
var GoatCoin = artifacts.require("./GoatCoin.sol");


module.exports = function(deployer) {
    deployer.deploy(ConvertLib);
    deployer.link(ConvertLib, GoatCoin);
    deployer.deploy(SafeMath);
    deployer.link(SafeMath, GoatCoin);
    deployer.deploy(GoatCoin);
};

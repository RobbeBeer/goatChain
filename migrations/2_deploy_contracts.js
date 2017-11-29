var ConvertLib = artifacts.require("./ConvertLib.sol");
var ERC20 = artifacts.require("./ERC20.sol");
var GoatCoin = artifacts.require("./GoatCoin.sol");


module.exports = function(deployer) {
    deployer.deploy(ConvertLib);
    deployer.link(ConvertLib, GoatCoin);
    deployer.deploy(GoatCoin);
};

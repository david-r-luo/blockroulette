var ConvertLib = artifacts.require("./ConvertLib.sol");
var Roulette = artifacts.require("./Roulette.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, Roulette);
  deployer.deploy(Roulette);
};

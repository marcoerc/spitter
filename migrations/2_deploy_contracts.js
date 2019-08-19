const Owned = artifacts.require("Owned");
const Stoppable = artifacts.require("Stoppable");
const Splitter = artifacts.require("Splitter");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Owned);
  deployer.link(Owned, Stoppable);
  deployer.deploy(Stoppable, true);
  deployer.link(Stoppable, Splitter);
  deployer.deploy(Splitter, accounts[1], accounts[2]);
};

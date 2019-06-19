const PrecompileCall = artifacts.require("PrecompileCall.sol");

module.exports = async function(deployer) {
  await deployer.deploy(PrecompileCall);
};

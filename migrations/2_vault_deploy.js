const Vault = artifacts.require("Migrations");
const VaultManager = artifacts.require("VaultManager");
const VaultKeyStore = artifacts.require("VaultKeyStore");

module.exports = function (deployer) {
  deployer.deploy(Vault);
  deployer.deploy(VaultManager);
  deployer.deploy(VaultKeyStore);
};
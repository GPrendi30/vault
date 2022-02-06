pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "./Vault.sol";
import "./VaultKeyStore.sol";

contract VaultManager {
    using Counters for Counters.Counter;

    Vault[] private vaults;
    VaultKeyStore private keyStore;
    Counters.Counter private vaultId;

    // modifier onlyKeyMaster(); 
    receive() external payable {}
    constructor() public {
        keyStore = new VaultKeyStore();
    }

    // create Vault
    function createVault() public {
        Vault _new = new Vault(keyStore, vaultId._value, msg.sender);

        vaults.push(_new);
        vaultId.increment();
    }


    // transfer Ownership
    function transferOwnership(address _newOwner, uint _vaultId) public {
        vaults[_vaultId].transferOwnership(msg.sender, _newOwner);
    }

    // destroy Vault
    function destroyVault(uint _id) public {
        vaults[_id].destroy(msg.sender);
    }



}
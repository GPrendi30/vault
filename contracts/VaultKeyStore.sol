pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// take care of imports
contract VaultKeyStore is ERC721 {
    using Counters for Counters.Counter;

    struct VaultKey {
        uint256 keyId;
    }

    // mapping VaultAddress => VaultKey
    mapping(address => VaultKey) keys;
    // current keyId;
    Counters.Counter private currentId;
    
    constructor () public ERC721("Vault Key", "KEY"){
        currentId = Counters.Counter(1);
    }

    function generateKey(address _vaultAddress, address account) public {
        uint256 keyId = currentId._value;
        VaultKey memory key = VaultKey(keyId);
        if (keys[_vaultAddress].keyId != 0) {
            destroyKey(_vaultAddress);
        }

        keys[_vaultAddress] = key;
        // creating the key and storing
        _mint(account, keyId);
        currentId.increment();
    }

    function destroyKey(address _vaultAddress) public {
        VaultKey memory _key = keys[_vaultAddress];
        uint _keyId = _key.keyId;
        keys[_vaultAddress] = VaultKey(0); // inavailable
        // removing the key and storing
        _burn(_keyId);
    }

    function transferOwnership(address _vault, address _newOwner) public {
        VaultKey memory key = keys[_vault];
        safeTransferFrom(ownerOf(key.keyId), _newOwner, key.keyId);
    }

    function isOwner(address _vault) public view returns (bool) {
        // TODO
    }

    // function getOwner(VaultKey memory key) public view returns(address) {
    //     return keys[];
    // }

}

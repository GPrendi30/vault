
import "./VaultManager.sol";
import "./VaultKeyStore.sol";
contract Vault {

    address private VaultMaster;

    VaultKeyStore private keyStore;
    VaultManager private manager;
    uint public vaultId;
    receive() external payable {} // This contract acts like a wallet, holding ETH, ERC-20 and ERC-721
    
    modifier onlyVaultManager() {
        require(msg.sender == address(manager));
        _;
    }

    constructor (VaultKeyStore _store, uint _id, address _owner) public onlyVaultManager() {
        VaultMaster = _owner;
        vaultId = _id;
        keyStore = _store;
    }

    function destroy(address _caller) public onlyVaultManager() onlyVaultManager() {
        require(VaultMaster == _caller && keyStore.isOwner(_caller));
        transferOwnership(_caller, address(0)); // set the ownership to the 0 address;
    }

    function transferOwnership(address _caller, address _newOwner) public onlyVaultManager() {
        require(VaultMaster == _caller && keyStore.isOwner(_caller));
        VaultMaster = _newOwner;
        
        if (_newOwner == address(0)) {
            keyStore.destroyKey(address(this));
        } else {
            keyStore.transferOwnership(address(this), _newOwner);
        }
           
    }

    // store functionality missing

//     function transferERC20(IERC20 tokenContract, address recipient, uint256 amount) public {
//         require(_vaultKeyTokenContract.ownerOf(_vaultId) == msg.sender, "only the owner of this vault's key can withdraw ERC20");
//         tokenContract.transfer(recipient, amount); // This potentially passes control to an external contract
//     }

//     function transferERC721(IERC721 tokenContract, address recipient, uint256 tokenId) public {
//         require(_vaultKeyTokenContract.ownerOf(_vaultId) == msg.sender, "only the owner of this vault's key can withdraw ERC721");
//         tokenContract.safeTransferFrom(address(this), recipient, tokenId); // This potentially passes control to an external contract
//     }

//     function transferETH(address payable recipient, uint256 amount) public {
//         require(_vaultKeyTokenContract.ownerOf(_vaultId) == msg.sender, "only the owner of this vault's key can withdraw ETH");
//         recipient.transfer(amount); // This potentially passes control to an external contract
//     }

// }
}
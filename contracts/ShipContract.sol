
// SPDX-License-Identifier: MIT

// File: @openzeppelin/contracts/utils/Context.sol

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol

pragma solidity ^0.8.0;


/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _setOwner(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _setOwner(newOwner);
    }

    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

pragma solidity ^0.8.6;

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 {
    /**
     * @dev Emitted when `tokenId` token is transfered from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address _owner) external view returns (uint256 balance);

    /*
     * @dev Returns the total number of tokens in circulation.
     */
    function totalSupply() external view returns (uint256 total);

    /*
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory tokenName);

    /*
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory tokenSymbol);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 _tokenId) external view returns (address owner);


     /* @dev Transfers `tokenId` token from `msg.sender` to `to`.
     *
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `to` can not be the contract address.
     * - `tokenId` token must be owned by `msg.sender`.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address _to, uint256 _tokenId) external;

    /// @notice Change or reaffirm the approved address for an NFT
    /// @dev The zero address indicates there is no approved address.
    ///  Throws unless `msg.sender` is the current NFT owner, or an authorized
    ///  operator of the current owner.
    /// @param _approved The new approved NFT controller
    /// @param _tokenId The NFT to approve
    function approve(address _approved, uint256 _tokenId) external;

    /// @notice Enable or disable approval for a third party ("operator") to manage
    ///  all of `msg.sender`'s assets
    /// @dev Emits the ApprovalForAll event. The contract MUST allow
    ///  multiple operators per owner.
    /// @param _operator Address to add to the set of authorized operators
    /// @param _approved True if the operator is approved, false to revoke approval
    function setApprovalForAll(address _operator, bool _approved) external;

    /// @notice Get the approved address for a single NFT
    /// @dev Throws if `_tokenId` is not a valid NFT.
    /// @param _tokenId The NFT to find the approved address for
    /// @return The approved address for this NFT, or the zero address if there is none
    function getApproved(uint256 _tokenId) external view returns (address);

    /// @notice Query if an address is an authorized operator for another address
    /// @param _owner The address that owns the NFTs
    /// @param _operator The address that acts on behalf of the owner
    /// @return True if `_operator` is an approved operator for `_owner`, false otherwise
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT. When transfer is complete, this function
    ///  checks if `_to` is a smart contract (code size > 0). If so, it calls
    ///  `onERC721Received` on `_to` and throws if the return value is not
    ///  `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    /// @param data Additional data with no specified format, sent in call to `_to`
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external;

    /// @notice Transfers the ownership of an NFT from one address to another address
    /// @dev This works identically to the other function with an extra data parameter,
    ///  except this function just sets data to "".
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external;

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function transferFrom(address _from, address _to, uint256 _tokenId) external;
}

pragma solidity ^0.8.6;

interface IERC721Receiver {
  function onERC721Received(address _operator, address _from, uint _tokenId, bytes calldata _data) external returns (bytes4);
}

contract Shipcontract is IERC721, Ownable {

  uint256 public constant gen0CreationLimit = 5;

  string private constant nameOfToken = "Ships";
  string private constant symbolOfToken = "PRATE";

  bytes4 private constant ERC721VerificationNum = bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));

  bytes4 private constant interfaceIdERC721 = 0x80ac58cd;
  bytes4 private constant interfaceIdERC165 = 0x01ffc9a7;

  event Birth(
    address owner,
    uint256 shipId,
    uint256 genes,
    uint256 dadId,
    uint256 momId
  );

  struct Ship {
    uint256 genes;
    uint64 birthTime;
    uint32 dadId;
    uint32 momId;
    uint16 generation;
  }

  Ship[] private ships;

  mapping(uint256 => address) private shipOwners;
  mapping(address => uint256) private tokenBalances;

  mapping(uint256 => address) private tokenApprovedAddresses;
  mapping(address => mapping(address => bool)) private operatorApproval;

  uint256 public gen0Total;

  constructor() {
    _createShip(type(uint256).max, 0, 0, 0, address(0));
  }

  function supportsInterface(bytes4 _interfaceId) external pure returns (bool) {
    return (_interfaceId == interfaceIdERC721 || _interfaceId == interfaceIdERC165);
  }

  function getShip(uint256 _tokenId) external view returns (
    uint256 genes,
    uint256 birthTime,
    uint256 dadId,
    uint256 momId,
    uint256 generation,
    address owner) {
      require(_tokenId < ships.length, "Token does not exist");
      return (
        ships[_tokenId].genes,
        ships[_tokenId].birthTime,
        ships[_tokenId].dadId,
        ships[_tokenId].momId,
        ships[_tokenId].generation,
        shipOwners[_tokenId]
      );
    }

    function allOwnedShips() external view returns(uint256[] memory) {
        uint256[] memory ownedShips = new uint256[](tokenBalances[msg.sender]);
        uint256 counter = 0;
        for(uint256 i = 0; i < ships.length; i++) {
          if(shipOwners[i] == msg.sender) {
            ownedShips[counter] = i;
            counter++;
          }
        }
        return ownedShips;
    }

  function _createShip(
    uint256 _genes,
    uint256 _dadId,
    uint256 _momId,
    uint256 _generation,
    address _owner
  ) private returns (uint256) {
      Ship memory _ship = Ship(_genes, uint64(block.timestamp), uint32(_dadId), uint32(_momId), uint16(_generation));

      ships.push(_ship);
      uint256 newShipId = ships.length - 1;

      emit Birth(_owner, newShipId, _genes, _momId, _dadId);

      _transfer(address(0), _owner, newShipId);

      return newShipId;
  }

  function name() override external pure returns (string memory tokenName) {
    return nameOfToken;
  }

  function symbol() override external pure returns (string memory tokenSymbol) {
    return symbolOfToken;
  }

  function balanceOf(address _owner) override external view returns (uint256 balance) {
    return tokenBalances[_owner];
  }

  function totalSupply() override external view returns (uint256 total) {
    return ships.length;
  }

  function ownerOf(uint256 _tokenId) override external view returns (address owner) {
    require(_tokenId < ships.length, "Token does not exist");
    return shipOwners[_tokenId];
  }

  function transfer(address _to, uint256 _tokenId) override external {
    require(_to != address(0), "Cannot transfer to 0 address");
    require(_to != address(this), "Cannot transfer to contract address");
    require(_owns(msg.sender, _tokenId), "Token must be owned by sender");

    _transfer(msg.sender, _to, _tokenId);
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    tokenBalances[_to]++;

    shipOwners[_tokenId] = _to;

    if (_from != address(0)) {
      tokenBalances[_from]--;
      delete tokenApprovedAddresses[_tokenId];
    }

    emit Transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) override external {
    require(_owns(msg.sender, _tokenId) || operatorApproval[shipOwners[_tokenId]][msg.sender], "You are not the owner or the operator of this token");

    tokenApprovedAddresses[_tokenId] = _approved;

    emit Approval(msg.sender, _approved, _tokenId);
  }

  function setApprovalForAll(address _operator, bool _approved) override external {
    require(_operator != msg.sender, "You cannot set yourself as operator");

    operatorApproval[msg.sender][_operator] = _approved;

    emit ApprovalForAll(msg.sender, _operator, _approved);
  }

  function getApproved(uint256 _tokenId) override external view returns (address) {
    require(_tokenId < ships.length, "Token does not exist");

    return tokenApprovedAddresses[_tokenId];
  }

  function isApprovedForAll(address _owner, address _operator) override public view returns (bool) {
    return operatorApproval[_owner][_operator];
  }

  function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory _data) override public {
    require(_transferFromRequire(msg.sender, _from, _to, _tokenId));

    _safeTransfer(_from, _to, _tokenId, _data);
  }

  function safeTransferFrom(address _from, address _to, uint256 _tokenId) override external {
    safeTransferFrom(_from, _to, _tokenId, "");
  }

  function _safeTransfer(address _from, address _to, uint256 _tokenId, bytes memory _data) private {
    _transfer(_from, _to, _tokenId);

    require(_checkERC721Support(_from, _to, _tokenId, _data), "Contract does not support ERC721 tokens");
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) override external {
    require(_transferFromRequire(msg.sender, _from, _to, _tokenId));

    _transfer(_from, _to, _tokenId);
  }

  function _isApproved(address _claimant, uint256 _tokenId) private view returns (bool) {
    return _claimant == tokenApprovedAddresses[_tokenId];
  }

  function _checkERC721Support(address _from, address _to, uint256 _tokenId, bytes memory _data) private returns (bool) {
    if(!_isContract(_to)) {
      return true;
    }
    else {
      bytes4 returnData = IERC721Receiver(_to).onERC721Received(msg.sender, _from, _tokenId, _data);
      return returnData == ERC721VerificationNum;
    }
  }

  function _isContract(address _to) private view returns (bool) {
    uint32 size;
    assembly{
      size := extcodesize(_to)
    }
    return size > 0;
  }

  function _transferFromRequire(address _spender, address _from, address _to, uint256 _tokenId) private view returns (bool) {
    require(_to != address(0), "Cannot transfer to 0 address");
    require(_tokenId < ships.length, "Token does not exist");
    require(_owns(_from, _tokenId), "Token must be owned by the address from");

    return _spender == _from || _isApproved(_spender, _tokenId) || isApprovedForAll(_from, _spender);
  }

  function _owns(address _claimant, uint256 _tokenId) public view returns (bool) {
    return _claimant == shipOwners[_tokenId];
  }
}

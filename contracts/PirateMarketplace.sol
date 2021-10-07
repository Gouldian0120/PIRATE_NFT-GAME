// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

import "./PirateContract.sol";

pragma solidity ^0.8.6;

/*
 * Market place to trade pirates (should **in theory** be used for any ERC721 token)
 * It needs an existing Pirate contract to interact with
 * Note: it does not inherit from the pirate contracts
 * Note: The contract needs to be an operator for everyone who is selling through this contract.
 */
interface IPirateMarketplace {

    event MarketTransaction(string TxType, address owner, uint256 tokenId);

    /**
    * Set the current PirateContract address and initialize the instance of Piratecontract.
    * Requirement: Only the contract owner can call.
     */
    function setPirateContract(address _pirateContractAddress) external;

    /**
    * Get the details about a offer for _tokenId. Throws an error if there is no active offer for _tokenId.
     */
    function getOffer(uint256 _tokenId) external view returns (address seller, uint256 price, uint256 index, uint256 tokenId, bool active);

    /**
    * Get all tokenId's that are currently for sale. Returns an empty arror if none exist.
     */
    function getAllTokenOnSale() external view returns(uint256[] memory listOfOffers);

    /**
    * Creates a new offer for _tokenId for the price _price.
    * Emits the MarketTransaction event with txType "Create offer"
    * Requirement: Only the owner of _tokenId can create an offer.
    * Requirement: There can only be one active offer for a token at a time.
    * Requirement: Marketplace contract (this) needs to be an approved operator when the offer is created.
     */
    function setOffer(uint256 _price, uint256 _tokenId) external;

    /**
    * Removes an existing offer.
    * Emits the MarketTransaction event with txType "Remove offer"
    * Requirement: Only the seller of _tokenId can remove an offer.
     */
    function removeOffer(uint256 _tokenId) external;

    /**
    * Executes the purchase of _tokenId.
    * Sends the funds to the seller and transfers the token using transferFrom in Piratecontract.
    * Emits the MarketTransaction event with txType "Buy".
    * Requirement: The msg.value needs to equal the price of _tokenId
    * Requirement: There must be an active offer for _tokenId
     */
    function buyPirate(uint256 _tokenId, address payable _seller) external payable;
}

pragma solidity ^0.8.6;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) private pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

pragma solidity ^0.8.0;

/**
 * @title Escrow
 * @dev Base escrow contract, holds funds designated for a payee until they
 * withdraw them.
 *
 * Intended usage: This contract (and derived escrow contracts) should be a
 * standalone contract, that only interacts with the contract that instantiated
 * it. That way, it is guaranteed that all Ether will be handled according to
 * the `Escrow` rules, and there is no need to check for payable functions or
 * transfers in the inheritance tree. The contract that uses the escrow as its
 * payment method should be its owner, and provide public methods redirecting
 * to the escrow's deposit and withdraw.
 */
contract Escrow is Ownable {
    using Address for address payable;

    event Deposited(address indexed payee, uint256 weiAmount);
    event Withdrawn(address indexed payee, uint256 weiAmount);

    mapping(address => uint256) private _deposits;

    function depositsOf(address payee) public view returns (uint256) {
        return _deposits[payee];
    }

    /**
     * @dev Stores the sent amount as credit to be withdrawn.
     * @param payee The destination address of the funds.
     */
    function deposit(address payee) public payable virtual onlyOwner {
        uint256 amount = msg.value;
        _deposits[payee] += amount;
        emit Deposited(payee, amount);
    }

    /**
     * @dev Withdraw accumulated balance for a payee, forwarding all gas to the
     * recipient.
     *
     * WARNING: Forwarding all gas opens the door to reentrancy vulnerabilities.
     * Make sure you trust the recipient, or are either following the
     * checks-effects-interactions pattern or using {ReentrancyGuard}.
     *
     * @param payee The address whose funds will be withdrawn and transferred to.
     */
    function withdraw(address payable payee) public virtual onlyOwner {
        uint256 payment = _deposits[payee];

        _deposits[payee] = 0;

        payee.sendValue(payment);

        emit Withdrawn(payee, payment);
    }
}

pragma solidity ^0.8.0;

contract PirateMarketplace is Ownable, IPirateMarketplace {
  PirateContract private _PirateContract;
  Escrow private _escrowContract;

  struct Offer {
    address payable seller;
    uint256 price;
    uint256 index;
    uint256 tokenId;
    bool active;
  }

  constructor(address _pirateContract) {
    _escrowContract = new Escrow();
    setPirateContract(_pirateContract);
  }

  Offer[] offers;

  mapping(uint256 => Offer) tokenIdToOffer;

  function setPirateContract(address _PirateContractAddress) override public onlyOwner {
    _PirateContract = PirateContract(_PirateContractAddress);
  }

  function getOffer(uint256 _tokenId) override external view returns (address seller, uint256 price, uint256 index, uint256 tokenId, bool active) {
    return (tokenIdToOffer[_tokenId].seller, tokenIdToOffer[_tokenId].price, tokenIdToOffer[_tokenId].index, tokenIdToOffer[_tokenId].tokenId, tokenIdToOffer[_tokenId].active);
  }

  function getActiveStatus(uint256 _tokenId) external view returns (bool active) {
    return tokenIdToOffer[_tokenId].active;
  }

  function getAllTokenOnSale() override external view returns(uint256[] memory listOfOffers) {
    uint256[] memory tokensForSale = new uint256[](offers.length);
    uint256 counter = 0;
    for(uint256 i = 0; i < offers.length; i++) {
      if(offers[i].active) {
        tokensForSale[counter] = offers[i].tokenId;
        counter++;
      }
    }
    return tokensForSale;
  }

  function setOffer(uint256 _price, uint256 _tokenId) override external {
    require(_PirateContract._owns(msg.sender, _tokenId), "You are not the token owner");
    require(!tokenIdToOffer[_tokenId].active, "You cannot have more then one offer for a token at a time");
    require(_PirateContract.isApprovedForAll(msg.sender, address(this)), "Marketplace contract is not an approved operator");

    Offer memory _newOffer = Offer(payable(msg.sender), _price, offers.length, _tokenId, true);
    tokenIdToOffer[_tokenId] = _newOffer;
    offers.push(_newOffer);

    emit MarketTransaction("Offer Created", msg.sender, _tokenId);
  }

  function removeOffer(uint256 _tokenId) override external {
    Offer memory offer = tokenIdToOffer[_tokenId];

    require(offer.seller == msg.sender, "Only the token seller can remove an offer");

    _offerRemove(_tokenId);

    emit MarketTransaction("Offer removed", msg.sender, _tokenId);
  }

  function buyPirate(uint256 _tokenId, address payable _seller) override external payable {
    Offer memory offer = tokenIdToOffer[_tokenId];

    require(offer.price == msg.value, "The price of the offer is incorrect");
    require(offer.active, "There is no offer for this token");

    _offerRemove(_tokenId);

    sendPayment(_seller, msg.value);
    _PirateContract.transferFrom(offer.seller, msg.sender, _tokenId);

    emit MarketTransaction("Token purchased", msg.sender, _tokenId);
  }

  function sendPayment(address payable _payee, uint256 _amount) public payable {
    _escrowContract.deposit{value: _amount}(_payee);
  }

  function withdraw(address payable _payee) external {
    _escrowContract.withdraw(_payee);
  }

  function balance(address _payee) external view returns (uint256 userBalance) {
    return _escrowContract.depositsOf(_payee);
  }

  function _offerRemove(uint256 _tokenId) private {
    offers[tokenIdToOffer[_tokenId].index].active = false;
    delete tokenIdToOffer[_tokenId];
  }
}

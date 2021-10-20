// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

import "./utils/access/Ownable.sol";
import "./ERC721/ERC721.sol";
import "./utils/random.sol";
import "./ERC20/IERC20.sol";
import "./Interface/gameStructs.sol";

interface IPirateNFT is IERC721,gameStructs {
    function create(uint _pirateType) external returns(uint256 tokenId);
    function getPirateInfo(uint256 id) external view returns(string memory _className, string memory _rarityName, 
        uint _tier, uint _itemSpace, uint _minAp, uint _maxAp, uint _drop, uint256 _price);
    function getPirateType(uint256 id) external view returns (uint256 _pirateType);
}

contract PirateNFT is IPirateNFT, Ownable, ERC721 {
    
    event ItemCreated(
        address indexed owner,
        uint256 indexed tokenId
    );

    event Born(
        address indexed owner,
        uint256 indexed tokenId
    );

    //token Data
    uint256 private _totalSupply;
    mapping(uint256 => string) private _tokenURIs;

    mapping(uint256 => PirateInfo) public pirateInfos;
    mapping(uint256 => uint256) public pirateTypes;

    // accepted token
    IERC20 public pirateCoin;
    uint256[5] public prices;

    // shipContract 
    address public shipContract;

    // Used to correctly support fingerprint verification for the assets
    bytes4 public constant _INTERFACE_ID_ERC721_VERIFY_FINGERPRINT = bytes4(
        keccak256("verifyFingerprint(uint256,bytes32)")
    );

    constructor (
        string memory _name,
        string memory _symbol
    )
        Ownable() ERC721(_name, _symbol)
    {
        _totalSupply=0;
        prices[0] = 10 * 10**18;
        prices[1] = 20 * 10**18;
        prices[2] = 30 * 10**18;
        prices[3] = 40 * 10**18;
        prices[4] = 50 * 10**18;
    }

    function setAcceptedToken(address _pirateCoinAddress) external onlyOwner {
        pirateCoin = IERC20(_pirateCoinAddress);
    }

    function setShipContract(address _shipContract) external onlyOwner {
        shipContract = _shipContract;
    }

    function setPrices(uint256[5] memory _prices) external onlyOwner {
        prices = _prices;
    }
     
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId));
        return _tokenURIs[tokenId];
    }
    
    function totalSupply()external view returns(uint256){
        return _totalSupply;
    }
    
    function getPirateInfo(uint256 id) public view override returns(string memory _className, string memory _rarityName,  
            uint _tier, uint _itemSpace, uint _minAp, uint _maxAp, uint _drop, uint256 _price) {
        _className = pirateInfos[id].className;
        _rarityName = pirateInfos[id].rarityName;
        _tier = pirateInfos[id].tier;
        _itemSpace = pirateInfos[id].itemSpace;
        _minAp = pirateInfos[id].minAp;
        _maxAp = pirateInfos[id].maxAp;
        _drop = pirateInfos[id].drop;
        _price = pirateInfos[id].price;
    }

    function getPirateType(uint256 id) external view override returns (uint256 _pirateType){
        _pirateType = pirateTypes[id];
    }
    
    function create(uint _pirateType)
        external override returns(uint256 tokenId)
    {
        require(_pirateType>=0 && _pirateType<5,"PirateNFT : Only 5 type of Pirates exist");
        PirateInfo memory _pirateInfo;

        if(_pirateType==0){

            pirateCoin.transferFrom(msg.sender,owner(),prices[0]);

            _pirateInfo.className = "Novatos";
            _pirateInfo.rarityName = "Common";
            _pirateInfo.tier = 1; 
            _pirateInfo.itemSpace = 0;
            _pirateInfo.minAp = 10;
            _pirateInfo.maxAp = 50;
            _pirateInfo.drop = 45; 
            _pirateInfo.price = prices[0]; 
        }
        else if(_pirateType==1) {

            pirateCoin.transferFrom(msg.sender,owner(),prices[1]);

            _pirateInfo.className = "Grumete";
            _pirateInfo.rarityName = "Uncommon";
            _pirateInfo.tier = 2; 
            _pirateInfo.itemSpace = 1;
            _pirateInfo.minAp = 51;
            _pirateInfo.maxAp = 100;
            _pirateInfo.drop = 35; 
            _pirateInfo.price = prices[1]; 
        }
        else if(_pirateType==2) {
             pirateCoin.transferFrom(msg.sender,owner(),prices[2]);

            _pirateInfo.className = "Sailor";
            _pirateInfo.rarityName = "Rare";
            _pirateInfo.tier = 3; 
            _pirateInfo.itemSpace = 1;
            _pirateInfo.minAp = 101;
            _pirateInfo.maxAp = 150;
            _pirateInfo.drop = 15; 
            _pirateInfo.price = prices[2];            
        }
        else if(_pirateType==3) {
            pirateCoin.transferFrom(msg.sender,owner(),prices[3]);

            _pirateInfo.className = "Sea Wolf";
            _pirateInfo.rarityName = "Mythic";
            _pirateInfo.tier = 4; 
            _pirateInfo.itemSpace = 2;
            _pirateInfo.minAp = 151;
            _pirateInfo.maxAp = 200;
            _pirateInfo.drop = 5; 
            _pirateInfo.price = prices[3]; 
        }
        else {
            pirateCoin.transferFrom(msg.sender,owner(),prices[4]);

            _pirateInfo.className = "Pirate";
            _pirateInfo.rarityName = "Legendary";
            _pirateInfo.tier = 5; 
            _pirateInfo.itemSpace = 2;
            _pirateInfo.minAp = 201;
            _pirateInfo.maxAp = 250;
            _pirateInfo.drop = 1; 
            _pirateInfo.price = prices[1]; 
        }    
        pirateTypes[_totalSupply] = _pirateType;
        tokenId = _create(msg.sender, _pirateInfo);
    }

    function _create(
        address _owner,
        PirateInfo memory _pirateInfo
    )
        internal returns (uint256 tokenId)
    {
        tokenId = _totalSupply;
        _totalSupply=_totalSupply+1;

        /// Mint new NFT
        _mint(_owner, tokenId);
        _setPirateInfo(tokenId, _pirateInfo);

        emit ItemCreated(_owner, tokenId);
    }
    
    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        require(_exists(tokenId));
        _tokenURIs[tokenId] = uri;
    }

    function _setPirateInfo(uint256 tokenId, PirateInfo memory _pirateInfo) internal {
        pirateInfos[tokenId].className = _pirateInfo.className;
        pirateInfos[tokenId].rarityName = _pirateInfo.rarityName;
        pirateInfos[tokenId].tier = _pirateInfo.tier;
        pirateInfos[tokenId].itemSpace = _pirateInfo.itemSpace;
        pirateInfos[tokenId].minAp = _pirateInfo.minAp;
        pirateInfos[tokenId].maxAp = _pirateInfo.maxAp;
        pirateInfos[tokenId].drop = _pirateInfo.drop;
        pirateInfos[tokenId].price = _pirateInfo.price;
    }
}

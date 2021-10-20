// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

import "./utils/access/Ownable.sol";
import "./ERC721/ERC721.sol";
import "./utils/random.sol";
import "./ERC20/IERC20.sol";
import "./Interface/gameStructs.sol";

interface IShipNFT is IERC721,gameStructs {
    function create(uint _shipType) external returns(uint256 tokenId);
    function getShipInfo(uint256 id) external view returns(string memory _className, string memory _rarityName, 
        uint _tier, uint pirate, uint durability, uint items, uint _drop, uint256 _price);
    function getShipType(uint256 id) external view returns (uint256 _shipType);
}

contract ShipNFT is IShipNFT, Ownable, ERC721 {
    
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

    mapping(uint256 => ShipInfo) public shipInfos;
    mapping(uint256 => uint256) public shipTypes;

    // accepted token
    IERC20 public pirateCoin;
    uint256[5] public prices;

    // pirateContract 
    address public pirateContract;

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
        prices[0] = 100 * 10**18;
        prices[1] = 200 * 10**18;
        prices[2] = 300 * 10**18;
        prices[3] = 400 * 10**18;
        prices[4] = 500 * 10**18;
    }

    function setAcceptedToken(address _pirateCoinAddress) external onlyOwner {
        pirateCoin = IERC20(_pirateCoinAddress);
    }

    function setPirateContract(address _pirateContract) external onlyOwner {
        pirateContract = _pirateContract;
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

    function getShipInfo(uint256 id) public view override returns(string memory _className, string memory _rarityName,  
            uint _tier, uint _pirate, uint _durability, uint _items, uint _drop, uint256 _price) {
        _className = shipInfos[id].className;
        _rarityName = shipInfos[id].rarityName;
        _tier = shipInfos[id].tier;
        _pirate = shipInfos[id].pirate;
        _durability = shipInfos[id].durability;
        _items = shipInfos[id].items;
        _drop = shipInfos[id].drop;
        _price = shipInfos[id].price;
    }

    function getShipType(uint256 id) external view override returns (uint256 _shipType){
        _shipType = shipTypes[id];
    }
    
    function create(uint _shipType)
        external override returns(uint256 tokenId)
    {
        require(_shipType>=0 && _shipType<5,"ShipNFT : Only 5 type of Ships exist");
        ShipInfo memory _shipInfo;

        if(_shipType==0){

            pirateCoin.transferFrom(msg.sender,owner(),prices[0]);

            _shipInfo.className = "Sailboat";
            _shipInfo.rarityName = "Common";
            _shipInfo.tier = 1; 
            _shipInfo.pirate = 1;
            _shipInfo.durability = 10;
            _shipInfo.items = 0;
            _shipInfo.drop = 44; 
            _shipInfo.price = prices[0]; 
        }
        else if(_shipType==1) {

            pirateCoin.transferFrom(msg.sender,owner(),prices[1]);

            _shipInfo.className = "Balandro";
            _shipInfo.rarityName = "Common";
            _shipInfo.tier = 2; 
            _shipInfo.pirate = 2;
            _shipInfo.durability = 10;
            _shipInfo.items = 0;
            _shipInfo.drop = 35; 
            _shipInfo.price = prices[1];  
        }
        else if(_shipType==2) {
             pirateCoin.transferFrom(msg.sender,owner(),prices[2]);

            _shipInfo.className = "Bergantin";
            _shipInfo.rarityName = "Common";
            _shipInfo.tier = 3; 
            _shipInfo.pirate = 3;
            _shipInfo.durability = 15;
            _shipInfo.items = 1;
            _shipInfo.drop = 15; 
            _shipInfo.price = prices[2];           
        }
        else if(_shipType==3) {
            pirateCoin.transferFrom(msg.sender,owner(),prices[3]);

            _shipInfo.className = "Galeon";
            _shipInfo.rarityName = "Common";
            _shipInfo.tier = 4; 
            _shipInfo.pirate = 4;
            _shipInfo.durability = 15;
            _shipInfo.items = 1;
            _shipInfo.drop = 5; 
            _shipInfo.price = prices[3]; 
        }
        else {
            pirateCoin.transferFrom(msg.sender,owner(),prices[4]);

            _shipInfo.className = "Fragata";
            _shipInfo.rarityName = "Common";
            _shipInfo.tier = 5; 
            _shipInfo.pirate = 5;
            _shipInfo.durability = 20;
            _shipInfo.items = 2;
            _shipInfo.drop = 1; 
            _shipInfo.price = prices[4]; 
        }    
        shipTypes[_totalSupply] = _shipType;
        tokenId = _create(msg.sender, _shipInfo);
    }

    function _create(
        address _owner,
        ShipInfo memory _shipInfo
    )
        internal returns (uint256 tokenId)
    {
        tokenId = _totalSupply;
        _totalSupply=_totalSupply+1;

        /// Mint new NFT
        _mint(_owner, tokenId);
        _setShipInfo(tokenId, _shipInfo);

        emit ItemCreated(_owner, tokenId);
    }
    
    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        require(_exists(tokenId));
        _tokenURIs[tokenId] = uri;
    }

    function _setShipInfo(uint256 tokenId, ShipInfo memory _shipInfo) internal {
        shipInfos[tokenId].className = _shipInfo.className;
        shipInfos[tokenId].rarityName = _shipInfo.rarityName;
        shipInfos[tokenId].tier = _shipInfo.tier;
        shipInfos[tokenId].pirate = _shipInfo.pirate;
        shipInfos[tokenId].durability = _shipInfo.durability;
        shipInfos[tokenId].items = _shipInfo.items;
        shipInfos[tokenId].drop = _shipInfo.drop;
        shipInfos[tokenId].price = _shipInfo.price;
    }
}

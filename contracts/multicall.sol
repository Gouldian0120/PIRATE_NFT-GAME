// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

import "./utils/access/Ownable.sol";
import "./ERC721/ERC721.sol";
import "./Interface/gameStructs.sol";

interface IPirateNFT is IERC721,gameStructs {
    function create(uint8 _pirateType) external returns(uint256 tokenId);
    function getPirateInfo(uint256 id) external view returns(string memory _className, string memory _rarityName, 
        uint _tier, uint _itemSpace, uint _minAp, uint _maxAp, uint _drop, uint256 _price);
    function getPirateType(uint256 id) external view returns (uint256 _pirateType);
}

interface IShipNFT is IERC721,gameStructs {
    function create(uint8 _shipType) external returns(uint256 tokenId);
    function getShipInfo(uint256 id) external view returns(string memory _className, string memory _rarityName, 
        uint _tier, uint pirate, uint durability, uint items, uint _drop, uint256 _price);
    function getShipType(uint256 id) external view returns (uint256 _shipType);
}

contract multicall is Ownable {
    address public pirateNFTAddress;
    address public shipNFTAddress;
    
    function setAddresses(address _pirateNFTAddress, address _shipNFTAddress) external onlyOwner{
        pirateNFTAddress = _pirateNFTAddress;
        shipNFTAddress = _shipNFTAddress;
    }

    function getPirateInfos(uint256[] memory tokenIds) external view 
        returns (address[] memory owners,address[] memory creators,
                string[] memory _className, string[] memory _rarityName, uint[] memory _tier,
                uint[] memory _itemSpace, uint[] memory _minAp, uint[] memory _maxAp,
                uint[] memory _drop, uint256[] memory _price, uint[] memory _pirateType){
        owners = new address[](tokenIds.length);
        creators = new address[](tokenIds.length);
        _className = new string[](tokenIds.length);
        _rarityName = new string[](tokenIds.length);
        _tier = new uint[](tokenIds.length);
        _itemSpace =  new uint[](tokenIds.length);
        _minAp =  new uint[](tokenIds.length);
        _maxAp = new uint[](tokenIds.length);
        _drop =  new uint[](tokenIds.length);
        _price = new uint256[](tokenIds.length);
        _pirateType = new uint[](tokenIds.length);

        IPirateNFT pirateNFTContract = IPirateNFT(pirateNFTAddress);
        
        for (uint256 i=0; i<tokenIds.length; i++)
        {
            owners[i] = pirateNFTContract.ownerOf(tokenIds[i]);
            creators[i] = pirateNFTContract.createrOf(tokenIds[i]);
            _pirateType[i] = pirateNFTContract.getPirateType(tokenIds[i]);

            (_className[i], _rarityName[i], _tier[i], _itemSpace[i], _minAp[i],
            _maxAp[i], _drop[i], _price[i]) = pirateNFTContract.getPirateInfo(tokenIds[i]);
        }
    }

    function getShipInfos(uint256[] memory tokenIds) external view 
        returns (address[] memory owners, address[] memory creators,
                string[] memory _className, string[] memory _rarityName, uint[] memory _tier,
                uint[] memory _pirate, uint[] memory _durability, uint[] memory _items,
                uint[] memory _drop, uint256[] memory _price, uint[] memory _shiptype){
        owners = new address[](tokenIds.length);
        creators = new address[](tokenIds.length);
        _className = new string[](tokenIds.length);
        _rarityName = new string[](tokenIds.length);
        _tier = new uint[](tokenIds.length);
        _pirate =  new uint[](tokenIds.length);
        _durability =  new uint[](tokenIds.length);
        _items = new uint[](tokenIds.length);
        _drop =  new uint[](tokenIds.length);
        _price = new uint256[](tokenIds.length);
        _shiptype = new uint[](tokenIds.length);

        IShipNFT shipNFTContract = IShipNFT(shipNFTAddress);
        
        for (uint256 i=0; i<tokenIds.length; i++)
        {
            owners[i] = shipNFTContract.ownerOf(tokenIds[i]);
            creators[i] = shipNFTContract.createrOf(tokenIds[i]);
            _shiptype[i] = shipNFTContract.getShipType(tokenIds[i]);

            (_className[i], _rarityName[i], _tier[i], _pirate[i], _durability[i],
            _items[i], _drop[i], _price[i]) = shipNFTContract.getShipInfo(tokenIds[i]);
        }
    }
}
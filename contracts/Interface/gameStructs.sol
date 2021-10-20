// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface gameStructs {

    struct PirateInfo {
        string className;
        string rarityName;
        uint tier;
        uint itemSpace;
        uint minAp;
        uint maxAp;
        uint drop;
        uint256 price;
    }

    struct ShipInfo {
        string className;
        string rarityName;
        uint tier;
        uint pirate;
        uint durability;
        uint items;
        uint drop;
        uint256 price;
    }
}
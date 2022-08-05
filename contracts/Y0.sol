//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Y0 is ERC1155, Ownable {
  using SafeMath for uint256;
  using Strings for string;

  // ==============================================
  // Properties
  // ==============================================
  uint256 public normal_car_count = 0;
  uint256 public rare_car_count = 0;
  uint256 public super_car_count = 0;
  uint256 public extra_car_count = 0;

  uint256 public normal_car_price = 11 ether;
  uint256 public rare_car_price = 22 ether;
  uint256 public super_car_price = 33 ether;
  uint256 public extra_car_price = 44 ether; 

  uint256 public MAX_SUPPLY_NORMAL = 1600; 
  uint256 public MAX_SUPPLY_RARE = 400; 
  uint256 public MAX_SUPPLY_SUPER = 200; 
  uint256 public MAX_SUPPLY_EXTRA = 22; 
  
  bool public isActive = false;

  mapping (uint256 => string) private _uris;

  string private constant _name = "Y0";
  string private constant _symbol = "Y0";

  string private baseURI = "";

  mapping (address => mapping (uint256 => uint256)) private mintTimeStamp;

  constructor(string memory _tokenUri) ERC1155(_tokenUri) {
    baseURI = _tokenUri;
    setTokenUri(1, string(abi.encodePacked(_tokenUri, "placeholder1.json")));
    setTokenUri(2, string(abi.encodePacked(_tokenUri, "placeholder2.json")));
    setTokenUri(3, string(abi.encodePacked(_tokenUri, "placeholder3.json")));
    setTokenUri(4, string(abi.encodePacked(_tokenUri, "placeholder4.json")));
  }

  // ==============================================
  // Functions
  // ==============================================

  /**
    * @dev Gets the token name.
    * @return string representing the token name
    */
  function name() external pure returns (string memory) {
      return _name;
  }

  /**
    * @dev Gets the token symbol.
    * @return string representing the token symbol
    */
  function symbol() external pure returns (string memory) {
      return _symbol;
  }

  /**
    * Get token uri (overrided to work properly with opensea)
    * @param _tokenId {uint256} tokenId
  */
  function uri(uint256 _tokenId) override public view returns (string memory) {
      return(_uris[_tokenId]);
  }
  
  /**
    * Set tokenUri for a certain token Id
    * @param _tokenId {uint256} tokenId
    * @param _uri {string} uri of token metadata
  */
  function setTokenUri(uint256 _tokenId, string memory _uri) private onlyOwner {
      _uris[_tokenId] = _uri; 
  }

  /**
    * Set the isActive flag to activate/desactivate the mint capability 
    * @param _isActive {bool} A flag to activate contract 
  */
  function setIsActive(bool _isActive) external onlyOwner {
    isActive = _isActive;
  }

  /**
    * Public Mint function
    * @param _to {address} address
    * @param _num {uint256} number of mint for this transaction
    * @param _mintType {uint256} mintType (1: normal, 2: rare, 3: super, 4: extra )
   */
  function mint(address _to, uint256 _num, uint256 _mintType) external payable {
    require(isActive, 'Mint is not active');
    
    if (_mintType == 1) {
      // Normal type NFT
      require(mintTimeStamp[_to][_mintType] == 0, 'You Already Minted');
      require(normal_car_count + _num <= MAX_SUPPLY_NORMAL, 'Exceeded total supply of normal cars');
      require(msg.value >= normal_car_price * _num, 'Ether Value sent is not sufficient');
      normal_car_count += _num;
      _mint(_to, 1, _num, "");
      mintTimeStamp[_to][_mintType] = block.timestamp;
    } else if (_mintType == 2) {
      // Rare type NFT
      require(mintTimeStamp[_to][_mintType] == 0, 'You Already Minted');
      require(rare_car_count + _num <= MAX_SUPPLY_RARE, 'Exceeded total supply of rare cars');
      require(msg.value >= rare_car_price * _num, 'Ether value sent is not sufficient');
      rare_car_count += _num;
      _mint(_to, 2, _num, "");
      mintTimeStamp[_to][_mintType] = block.timestamp;
    } else if (_mintType == 3) {
      // Super type NFT
      require(mintTimeStamp[_to][_mintType] == 0, 'You Already Minted');
      require(super_car_count + _num <= MAX_SUPPLY_SUPER, 'Exceeded total supply of super cars');
      require(msg.value >= super_car_price * _num, 'Ether value sent is not sufficient');
      super_car_count += _num;
      _mint(_to, 3, _num, "");
      mintTimeStamp[_to][_mintType] = block.timestamp;
    } else if (_mintType == 4) {
      // Extra type NFT
      require(mintTimeStamp[_to][_mintType] == 0, 'You Already Minted');
      require(extra_car_count + _num <= MAX_SUPPLY_EXTRA, 'Exceeded total supply of extra cars');
      require(msg.value >= extra_car_price * _num, 'Ether value sent is not sufficient');
      extra_car_count += _num;
      _mint(_to, 4, _num, "");
      mintTimeStamp[_to][_mintType] = block.timestamp;
    } else {
      require(false, 'This tokenId doesnt exist');
    }
  }

  /**
   * Mint By Owner (for airdrops)
    * @param _to {address} address
    * @param _num {uint256} number of mint for this transaction
    * @param _mintType {uint256} mintType (1: normal, 2: rare, 3: super, 4: extra )
   */
  function mintByOwner(address _to, uint256 _num, uint256 _mintType) external onlyOwner {
    if (_mintType == 1) {
      // Normal type NFT
      require(mintTimeStamp[_to][_mintType] == 0, 'You Already Minted');
      require(normal_car_count + _num <= MAX_SUPPLY_NORMAL, 'Exceeded total supply of normal cars');
      normal_car_count += _num;
      _mint(_to, 1, _num, "");
      mintTimeStamp[_to][_mintType] = block.timestamp;
    } else if (_mintType == 2) {
      // Rare type NFT
      require(mintTimeStamp[_to][_mintType] == 0, 'You Already Minted');
      require(rare_car_count + _num <= MAX_SUPPLY_RARE, 'Exceeded total supply of rare cars');
      rare_car_count += _num;
      _mint(_to, 2, _num, "");
      mintTimeStamp[_to][_mintType] = block.timestamp;
    } else if (_mintType == 3) {
      // Super type NFT
      require(mintTimeStamp[_to][_mintType] == 0, 'You Already Minted');
      require(super_car_count + _num <= MAX_SUPPLY_SUPER, 'Exceeded total supply of super cars');
      super_car_count += _num;
      _mint(_to, 3, _num, "");
      mintTimeStamp[_to][_mintType] = block.timestamp;
    } else if (_mintType == 4) {
      // Extra type NFT
      require(mintTimeStamp[_to][_mintType] == 0, 'You Already Minted');
      require(extra_car_count + _num <= MAX_SUPPLY_EXTRA, 'Exceeded total supply of extra cars');
      extra_car_count += _num;
      _mint(_to, 4, _num, "");
      mintTimeStamp[_to][_mintType] = block.timestamp;
    } else  {
      require(false, 'This mint type does not exist');
    }
  }

  /**
    * Function to withdraw collected amount during minting by the owner
    * @param _wallet1 {address} address 1 get 95% of balance
    * @param _wallet2 {address2} address 2 get 9% of balance
  */

  // TODO: responsability to 1 wallet (problem) + wallet not fixed in contract
  function withdraw(address _wallet1, address _wallet2) external onlyOwner {
    uint256 balance = address(this).balance;
    require(balance > 0, "Balance should be more then zero");

    // Pay wallet 1 95% and wallet 2 5%
    uint256 balance1 = (balance * 95 / 100);
    uint256 balance2 = (balance * 5 / 100);
    payable(address(_wallet1)).transfer(balance1);
    payable(address(_wallet2)).transfer(balance2);
  }

  function reveal(address claimer, uint256 _typeId) public onlyOwner {
    require(mintTimeStamp[claimer][_typeId] > 0, 'You did not mint this type of NFTs');
    require((block.timestamp - mintTimeStamp[claimer][_typeId]) >= 1 minutes, 'NFT is revealed soon');
    setTokenUri(_typeId, string(abi.encodePacked(baseURI, Strings.toString(_typeId), ".json")));
  }
}
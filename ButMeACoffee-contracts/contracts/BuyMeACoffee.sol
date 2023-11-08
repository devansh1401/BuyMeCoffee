// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

// BuyMeACoffee deployed to: 0xbaCAcaF853fF31E765B5907E1c9c7b074751A1d5

 contract BuyMeACoffee{
    //event to emit whem a memo is created. 
    event NewMemo(
    address indexed from,
    uint256 timestramp,
    string name,
    string message
    );

     // Memo Struct ❤️
  struct Memo{
    address from;
    uint256 timestramp;
    string name;
    string message;
  }

  Memo[] memos;

   // Address pf the contract deployer.
   address payable owner;

   constructor() {
    owner = payable(msg.sender);
   }

   /**
    * @dev buy a coffee for contract owner
    * @param _name name of the coffee buyer
    * @param _message a nice messaage for the coffee buyer
    */

   function buyCoffee(string memory _name, string memory _message) public payable{
    require(msg.value > 0 , "You ain't got no money");

    memos.push(Memo(
        msg.sender,
        block.timestamp,
        _name,
        _message
    ));

    emit NewMemo(msg.sender,block.timestamp, _name, _message);
   }

   /**
    * @dev send the entire balance stored int this contract to the owner
    */

   function withdrawTips() public {
    require(owner.send(address(this).balance));

   }

   /**
    * @dev recieve all the momos stored and ecieved in the blockchain
    */

   function getMemos() public view returns(Memo[] memory){
    return memos;
   }

 }

package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.IFurniData;
   import com.sulake.habbo.communication.messages.parser.room.engine.UnknownHabboCommunicationMessagesParserRoomEngine1;
   import com.sulake.habbo.room.IStuffData;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class ItemDataStructure implements IFurniData
   {
      private var _expirationTimeStamp:int;
      
      private var _isWallItem:Boolean;
      
      private var _itemId:int;
      
      private var _itemType:String;
      
      private var _roomItemId:int;
      
      private var _itemTypeId:int;
      
      private var _category:int;
      
      private var _stuffData:IStuffData;
      
      private var _extra:int;
      
      private var _secondsToExpiration:int;
      
      private var _creationDay:int;
      
      private var _creationMonth:int;
      
      private var _creationYear:int;
      
      private var _isGroupable:Boolean;
      
      private var UnknownVarFromItemDataStructure_Int_1:int;
      
      private var _flatId:int;
      
      private var _isRented:Boolean;
      
      private var _hasRentPeriodStarted:Boolean;
      
      public function ItemDataStructure(param1:IMessageDataWrapper)
      {
         super();
         _itemId = param1.readInteger();
         _itemType = param1.readString().toUpperCase();
         _roomItemId = param1.readInteger();
         _itemTypeId = param1.readInteger();
         _category = param1.readInteger();
         _isGroupable = param1.readBoolean();
         _stuffData = UnknownHabboCommunicationMessagesParserRoomEngine1.parseStuffData(param1);
         _secondsToExpiration = -1;
         _expirationTimeStamp = getTimer();
         _hasRentPeriodStarted = false;
         _creationDay = param1.readInteger();
         _creationMonth = param1.readInteger();
         _creationYear = param1.readInteger();
         _extra = itemType == "S" ? param1.readInteger() : -1;
         _flatId = -1;
         _isRented = false;
         _isWallItem = _itemType == "I";
      }
      
      public function get itemId() : int
      {
         return _itemId;
      }
      
      public function get itemType() : String
      {
         return _itemType;
      }
      
      public function get roomItemId() : int
      {
         return _roomItemId;
      }
      
      public function get itemTypeId() : int
      {
         return _itemTypeId;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get stuffData() : IStuffData
      {
         return _stuffData;
      }
      
      public function get extra() : int
      {
         return _extra;
      }
      
      public function get secondsToExpiration() : int
      {
         return _secondsToExpiration;
      }
      
      public function get creationDay() : int
      {
         return _creationDay;
      }
      
      public function get creationMonth() : int
      {
         return _creationMonth;
      }
      
      public function get creationYear() : int
      {
         return _creationYear;
      }
      
      public function get isGroupable() : Boolean
      {
         return _isGroupable;
      }
      
      public function get songId() : int
      {
         return _extra;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get isRented() : Boolean
      {
         return _isRented;
      }
      
      public function get isWallItem() : Boolean
      {
         return _isWallItem;
      }
      
      public function get hasRentPeriodStarted() : Boolean
      {
         return _hasRentPeriodStarted;
      }
      
      public function get expirationTimeStamp() : int
      {
         return _expirationTimeStamp;
      }
      
      public function get isRecyclable() : Boolean
      {
         return true;
      }
      
      public function get isTradeable() : Boolean
      {
         return true;
      }
      
      public function get isSellable() : Boolean
      {
         return true;
      }
      
      public function get slotId() : String
      {
         return null;
      }
      
      public function get isExternalImageFurni() : Boolean
      {
         return _itemType.indexOf("external_image") != -1;
      }
   }
}


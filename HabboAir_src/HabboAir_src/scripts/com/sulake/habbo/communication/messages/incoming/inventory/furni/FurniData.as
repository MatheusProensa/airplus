package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.parser.room.engine.UnknownHabboCommunicationMessagesParserRoomEngine1;
   import com.sulake.habbo.room.IStuffData;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class FurniData implements IFurniData
   {
      private static const UnknownConstFromFurniData_String_1:String = "I";
      
      private static const UnknownConstFromFurniData_String_2:String = "S";
      
      private var _isRented:Boolean;
      
      private var _itemId:int;
      
      private var _itemType:String;
      
      private var _roomItemId:int;
      
      private var _itemTypeId:int;
      
      private var _category:int;
      
      private var _stuffData:IStuffData;
      
      private var _isGroupable:Boolean;
      
      private var _isRecyclable:Boolean;
      
      private var _isTradeable:Boolean;
      
      private var _isSellable:Boolean;
      
      private var _secondsToExpiration:int;
      
      private var _extra:int;
      
      private var _flatId:int;
      
      private var _isWallItem:Boolean;
      
      private var _hasRentPeriodStarted:Boolean;
      
      private var _expirationTimeStamp:int;
      
      private var _slotId:String = "";
      
      private var _songId:int = -1;
      
      public function FurniData(param1:IMessageDataWrapper)
      {
         super();
         _itemId = param1.readInteger();
         _itemType = param1.readString();
         _roomItemId = param1.readInteger();
         _itemTypeId = param1.readInteger();
         _category = param1.readInteger();
         _stuffData = UnknownHabboCommunicationMessagesParserRoomEngine1.parseStuffData(param1);
         _isRecyclable = param1.readBoolean();
         _isTradeable = param1.readBoolean();
         _isGroupable = param1.readBoolean();
         _isSellable = param1.readBoolean();
         _secondsToExpiration = param1.readInteger();
         _expirationTimeStamp = getTimer();
         if(secondsToExpiration > -1)
         {
            _isRented = true;
         }
         else
         {
            _isRented = false;
            _secondsToExpiration = -1;
         }
         _hasRentPeriodStarted = param1.readBoolean();
         _flatId = param1.readInteger();
         _isWallItem = _itemType == "I";
         if(_itemType == "S")
         {
            _slotId = param1.readString();
            _extra = param1.readInteger();
         }
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
      
      public function get isGroupable() : Boolean
      {
         return _isGroupable;
      }
      
      public function get isRecyclable() : Boolean
      {
         return _isRecyclable;
      }
      
      public function get isTradeable() : Boolean
      {
         return _isTradeable;
      }
      
      public function get isSellable() : Boolean
      {
         return _isSellable;
      }
      
      public function get secondsToExpiration() : int
      {
         return _secondsToExpiration;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get slotId() : String
      {
         return _slotId;
      }
      
      public function get songId() : int
      {
         return _songId;
      }
      
      public function get extra() : int
      {
         return _extra;
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
      
      public function get creationDay() : int
      {
         return 0;
      }
      
      public function get creationMonth() : int
      {
         return 0;
      }
      
      public function get creationYear() : int
      {
         return 0;
      }
      
      public function get isExternalImageFurni() : Boolean
      {
         return _itemType.indexOf("external_image") != -1;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.parser.room.engine.UnknownHabboCommunicationMessagesParserRoomEngine1;
   import com.sulake.habbo.room.IStuffData;
   
   public class ChestStorage implements IChestStorage
   {
      public static var UnknownVarFromChestStorage_Int_1:int = 0;
      
      public static var UnknownVarFromChestStorage_Int_2:int = 1;
      
      public static var UnknownVarFromChestStorage_Int_3:int = 2;
      
      public static var UnknownVarFromChestStorage_Int_4:int = 3;
      
      private var _inventoryId:int;
      
      private var _lockState:int;
      
      private var _transactionId:Number;
      
      private var _type:ChestItemType;
      
      private var _groupable:Boolean;
      
      private var _specialType:int;
      
      private var _stuffData:IStuffData;
      
      private var _extra:int;
      
      public function ChestStorage(param1:IMessageDataWrapper)
      {
         super();
         _inventoryId = param1.readInteger();
         _lockState = param1.readInteger();
         _transactionId = param1.readLong();
         _type = ChestItemType.readFromMessage(param1);
         _groupable = param1.readBoolean();
         _specialType = param1.readInteger();
         _stuffData = UnknownHabboCommunicationMessagesParserRoomEngine1.parseStuffData(param1);
         if(!_type.isWallItem)
         {
            _extra = param1.readInteger();
         }
      }
      
      public function get inventoryId() : int
      {
         return _inventoryId;
      }
      
      public function get lockState() : int
      {
         return _lockState;
      }
      
      public function get transactionId() : Number
      {
         return _transactionId;
      }
      
      public function get type() : ChestItemType
      {
         return _type;
      }
      
      public function get groupable() : Boolean
      {
         return _groupable;
      }
      
      public function get specialType() : int
      {
         return _specialType;
      }
      
      public function get stuffData() : IStuffData
      {
         return _stuffData;
      }
      
      public function get extra() : int
      {
         return _extra;
      }
   }
}


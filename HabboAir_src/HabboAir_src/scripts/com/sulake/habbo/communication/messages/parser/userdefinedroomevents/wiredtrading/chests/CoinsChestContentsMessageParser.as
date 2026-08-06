package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CoinsChestContentsMessageParser implements IMessageParser
   {
      private var _chestId:int;
      
      private var _coins:int;
      
      private var _isUpdate:Boolean;
      
      public function CoinsChestContentsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _chestId = 0;
         _coins = 0;
         _isUpdate = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _chestId = param1.readInteger();
         _coins = param1.readInteger();
         _isUpdate = param1.readBoolean();
         return true;
      }
      
      public function get chestId() : int
      {
         return _chestId;
      }
      
      public function get coins() : int
      {
         return _coins;
      }
      
      public function get isUpdate() : Boolean
      {
         return _isUpdate;
      }
   }
}


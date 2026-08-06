package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UpgradeChestResultMessageParser implements IMessageParser
   {
      public static const SUCCESS:int = 0;
      
      private var _chestId:int;
      
      private var _resultCode:int;
      
      public function UpgradeChestResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _chestId = 0;
         _resultCode = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _chestId = param1.readInteger();
         _resultCode = param1.readInteger();
         return true;
      }
      
      public function get chestId() : int
      {
         return _chestId;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
   }
}


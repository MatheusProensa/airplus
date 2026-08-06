package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChestPreferencesUpdateSuccessMessageParser implements IMessageParser
   {
      private var _chestId:int;
      
      private var _isNotificationPreferences:Boolean;
      
      public function ChestPreferencesUpdateSuccessMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _chestId = 0;
         _isNotificationPreferences = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _chestId = param1.readInteger();
         _isNotificationPreferences = param1.readBoolean();
         return true;
      }
      
      public function get chestId() : int
      {
         return _chestId;
      }
      
      public function get isNotificationPreferences() : Boolean
      {
         return _isNotificationPreferences;
      }
   }
}


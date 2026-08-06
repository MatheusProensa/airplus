package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredRoomSettingsMessageParser implements IMessageParser
   {
      private var _modifyPermissionMask:int;
      
      private var _readPermissionMask:int;
      
      private var _timezone:String;
      
      public function WiredRoomSettingsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _modifyPermissionMask = 0;
         _readPermissionMask = 0;
         _timezone = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _modifyPermissionMask = param1.readInteger();
         _readPermissionMask = param1.readInteger();
         _timezone = param1.readString();
         return true;
      }
      
      public function get modifyPermissionMask() : int
      {
         return _modifyPermissionMask;
      }
      
      public function get readPermissionMask() : int
      {
         return _readPermissionMask;
      }
      
      public function get timezone() : String
      {
         return _timezone;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredPermissionsMessageParser implements IMessageParser
   {
      private var _canModify:Boolean;
      
      private var _canRead:Boolean;
      
      public function WiredPermissionsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _canModify = false;
         _canRead = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _canModify = param1.readBoolean();
         _canRead = param1.readBoolean();
         return true;
      }
      
      public function get canModify() : Boolean
      {
         return _canModify;
      }
      
      public function get canRead() : Boolean
      {
         return _canRead;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredSetUserPermanentVariableResultMessageParser implements IMessageParser
   {
      private var _success:Boolean;
      
      public function WiredSetUserPermanentVariableResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _success = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _success = param1.readBoolean();
         return true;
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
   }
}


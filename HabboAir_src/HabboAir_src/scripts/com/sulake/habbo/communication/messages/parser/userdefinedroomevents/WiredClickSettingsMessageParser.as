package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredClickSettingsMessageParser implements IMessageParser
   {
      private var _userOption:int;
      
      private var _furniOption:int;
      
      public function WiredClickSettingsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _userOption = 0;
         _furniOption = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userOption = param1.readInteger();
         _furniOption = param1.readInteger();
         return true;
      }
      
      public function get userOption() : int
      {
         return _userOption;
      }
      
      public function get furniOption() : int
      {
         return _furniOption;
      }
   }
}


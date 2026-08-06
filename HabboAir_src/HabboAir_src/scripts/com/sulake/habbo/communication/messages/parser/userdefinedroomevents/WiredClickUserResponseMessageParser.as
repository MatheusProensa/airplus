package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredClickUserResponseMessageParser implements IMessageParser
   {
      private var _index:int;
      
      private var _openMenu:Boolean;
      
      public function WiredClickUserResponseMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _index = 0;
         _openMenu = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _index = param1.readInteger();
         _openMenu = param1.readBoolean();
         return true;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get openMenu() : Boolean
      {
         return _openMenu;
      }
   }
}


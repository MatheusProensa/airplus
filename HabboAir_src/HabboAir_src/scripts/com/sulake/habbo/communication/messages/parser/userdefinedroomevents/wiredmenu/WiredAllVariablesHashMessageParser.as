package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredAllVariablesHashMessageParser implements IMessageParser
   {
      private var _allVariablesHash:int;
      
      public function WiredAllVariablesHashMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _allVariablesHash = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _allVariablesHash = param1.readInteger();
         return true;
      }
      
      public function get allVariablesHash() : int
      {
         return _allVariablesHash;
      }
   }
}


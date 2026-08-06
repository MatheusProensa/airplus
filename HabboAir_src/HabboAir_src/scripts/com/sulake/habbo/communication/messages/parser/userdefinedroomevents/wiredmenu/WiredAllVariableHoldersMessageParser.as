package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.VariableInfoAndHolders;
   
   public class WiredAllVariableHoldersMessageParser implements IMessageParser
   {
      private var _variableInfoAndHolders:VariableInfoAndHolders;
      
      public function WiredAllVariableHoldersMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _variableInfoAndHolders = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         param1.readInteger();
         _variableInfoAndHolders = new VariableInfoAndHolders(param1);
         return true;
      }
      
      public function get variableInfoAndHolders() : VariableInfoAndHolders
      {
         return _variableInfoAndHolders;
      }
   }
}


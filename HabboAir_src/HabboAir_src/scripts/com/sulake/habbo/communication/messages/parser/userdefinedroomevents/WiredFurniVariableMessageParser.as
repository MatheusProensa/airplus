package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.VariableDefinition;
   
   [SecureSWF(rename="true")]
   public class WiredFurniVariableMessageParser implements IMessageParser
   {
      private var _def:VariableDefinition;
      
      public function WiredFurniVariableMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _def = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _def = new VariableDefinition(param1);
         return true;
      }
      
      public function get def() : VariableDefinition
      {
         return _def;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
   
   [SecureSWF(rename="true")]
   public class WiredFurniConditionMessageParser implements IMessageParser
   {
      private var _def:ConditionDefinition;
      
      public function WiredFurniConditionMessageParser()
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
         _def = new ConditionDefinition(param1);
         return true;
      }
      
      public function get def() : ConditionDefinition
      {
         return _def;
      }
   }
}


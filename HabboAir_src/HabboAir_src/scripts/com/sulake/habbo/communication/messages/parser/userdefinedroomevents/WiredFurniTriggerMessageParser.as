package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
   
   [SecureSWF(rename="true")]
   public class WiredFurniTriggerMessageParser implements IMessageParser
   {
      private var _def:TriggerDefinition;
      
      public function WiredFurniTriggerMessageParser()
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
         _def = new TriggerDefinition(param1);
         return true;
      }
      
      public function get def() : TriggerDefinition
      {
         return _def;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ActionDefinition;
   
   [SecureSWF(rename="true")]
   public class WiredFurniActionMessageParser implements IMessageParser
   {
      private var _def:ActionDefinition;
      
      public function WiredFurniActionMessageParser()
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
         _def = new ActionDefinition(param1);
         return true;
      }
      
      public function get def() : ActionDefinition
      {
         return _def;
      }
   }
}


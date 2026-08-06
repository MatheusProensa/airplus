package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.AddonDefinition;
   
   [SecureSWF(rename="true")]
   public class WiredFurniAddonMessageParser implements IMessageParser
   {
      private var _def:AddonDefinition;
      
      public function WiredFurniAddonMessageParser()
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
         _def = new AddonDefinition(param1);
         return true;
      }
      
      public function get def() : AddonDefinition
      {
         return _def;
      }
   }
}


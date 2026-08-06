package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.SelectorDefinition;
   
   public class WiredFurniSelectorMessageParser implements IMessageParser
   {
      private var _def:SelectorDefinition;
      
      public function WiredFurniSelectorMessageParser()
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
         _def = new SelectorDefinition(param1);
         return true;
      }
      
      public function get def() : SelectorDefinition
      {
         return _def;
      }
   }
}


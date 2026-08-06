package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniSelectorMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredFurniSelectorEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredFurniSelectorEvent(param1:Function)
      {
         super(param1,WiredFurniSelectorMessageParser);
      }
      
      public function getParser() : WiredFurniSelectorMessageParser
      {
         return this._parser as WiredFurniSelectorMessageParser;
      }
   }
}


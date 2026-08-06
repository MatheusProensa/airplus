package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniConditionMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredFurniConditionEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredFurniConditionEvent(param1:Function)
      {
         super(param1,WiredFurniConditionMessageParser);
      }
      
      public function getParser() : WiredFurniConditionMessageParser
      {
         return this._parser as WiredFurniConditionMessageParser;
      }
   }
}


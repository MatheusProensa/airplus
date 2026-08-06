package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.AreaHideMessageParser;
   
   [SecureSWF(rename="true")]
   public class AreaHideMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function AreaHideMessageEvent(param1:Function)
      {
         super(param1,AreaHideMessageParser);
      }
      
      public function getParser() : AreaHideMessageParser
      {
         return _parser as AreaHideMessageParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionRequesterRoomMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionRequesterRoomMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuideSessionRequesterRoomMessageEvent(param1:Function)
      {
         super(param1,GuideSessionRequesterRoomMessageParser);
      }
      
      public function getParser() : GuideSessionRequesterRoomMessageParser
      {
         return _parser as GuideSessionRequesterRoomMessageParser;
      }
   }
}


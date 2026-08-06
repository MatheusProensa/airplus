package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RoomMessageNotificationMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomMessageNotificationMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function RoomMessageNotificationMessageEvent(param1:Function)
      {
         super(param1,RoomMessageNotificationMessageParser);
      }
      
      public function getParser() : RoomMessageNotificationMessageParser
      {
         return _parser as RoomMessageNotificationMessageParser;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.UserUnbannedFromRoomParser;
   
   [SecureSWF(rename="true")]
   public class UserUnbannedFromRoomEvent extends MessageEvent implements IMessageEvent
   {
      public function UserUnbannedFromRoomEvent(param1:Function)
      {
         super(param1,UserUnbannedFromRoomParser);
      }
      
      public function getParser() : UserUnbannedFromRoomParser
      {
         return this._parser as UserUnbannedFromRoomParser;
      }
   }
}


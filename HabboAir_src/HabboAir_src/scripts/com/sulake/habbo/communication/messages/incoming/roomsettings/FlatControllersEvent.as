package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllersMessageParser;
   
   [SecureSWF(rename="true")]
   public class FlatControllersEvent extends MessageEvent implements IMessageEvent
   {
      public function FlatControllersEvent(param1:Function)
      {
         super(param1,FlatControllersMessageParser);
      }
      
      public function getParser() : FlatControllersMessageParser
      {
         return this._parser as FlatControllersMessageParser;
      }
   }
}


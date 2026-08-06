package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.UnreadForumsCountMessageParser;
   
   [SecureSWF(rename="true")]
   public class UnreadForumsCountMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function UnreadForumsCountMessageEvent(param1:Function)
      {
         super(param1,UnreadForumsCountMessageParser);
      }
      
      public function getParser() : UnreadForumsCountMessageParser
      {
         return this._parser as UnreadForumsCountMessageParser;
      }
   }
}


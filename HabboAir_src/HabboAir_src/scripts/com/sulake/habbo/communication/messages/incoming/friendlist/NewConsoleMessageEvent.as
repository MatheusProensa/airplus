package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
   
   [SecureSWF(rename="true")]
   public class NewConsoleMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function NewConsoleMessageEvent(param1:Function)
      {
         super(param1,NewConsoleMessageMessageParser);
      }
      
      public function getParser() : NewConsoleMessageMessageParser
      {
         return this._parser as NewConsoleMessageMessageParser;
      }
   }
}


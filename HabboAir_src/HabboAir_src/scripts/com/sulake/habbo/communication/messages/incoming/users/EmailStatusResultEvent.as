package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.EmailStatusParser;
   
   [SecureSWF(rename="true")]
   public class EmailStatusResultEvent extends MessageEvent implements IMessageEvent
   {
      public function EmailStatusResultEvent(param1:Function)
      {
         super(param1,EmailStatusParser);
      }
      
      public function getParser() : EmailStatusParser
      {
         return _parser as EmailStatusParser;
      }
   }
}


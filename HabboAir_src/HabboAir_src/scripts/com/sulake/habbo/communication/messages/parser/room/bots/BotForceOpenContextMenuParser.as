package com.sulake.habbo.communication.messages.parser.room.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotForceOpenContextMenuParser implements IMessageParser
   {
      private var _botId:int;
      
      public function BotForceOpenContextMenuParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _botId = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _botId = param1.readInteger();
         return true;
      }
      
      public function get botId() : int
      {
         return _botId;
      }
   }
}


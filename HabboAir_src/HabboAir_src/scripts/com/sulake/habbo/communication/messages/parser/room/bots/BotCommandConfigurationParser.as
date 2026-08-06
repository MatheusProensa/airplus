package com.sulake.habbo.communication.messages.parser.room.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotCommandConfigurationParser implements IMessageParser
   {
      private var _botId:int;
      
      private var _commandId:int;
      
      private var _data:String;
      
      public function BotCommandConfigurationParser()
      {
         super();
      }
      
      public function get botId() : int
      {
         return _botId;
      }
      
      public function get commandId() : int
      {
         return _commandId;
      }
      
      public function get data() : String
      {
         return _data;
      }
      
      public function flush() : Boolean
      {
         _botId = -1;
         _commandId = -1;
         _data = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _botId = param1.readInteger();
         _commandId = param1.readInteger();
         _data = param1.readString();
         return true;
      }
   }
}


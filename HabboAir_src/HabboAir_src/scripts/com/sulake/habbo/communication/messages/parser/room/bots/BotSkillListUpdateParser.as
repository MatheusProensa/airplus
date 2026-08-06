package com.sulake.habbo.communication.messages.parser.room.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotSkillListUpdateParser implements IMessageParser
   {
      private var _botId:int;
      
      private var _skillList:Array;
      
      public function BotSkillListUpdateParser()
      {
         super();
      }
      
      public function get skillList() : Array
      {
         return _skillList;
      }
      
      public function get botId() : int
      {
         return _botId;
      }
      
      public function flush() : Boolean
      {
         _botId = -1;
         _skillList = new Array(0);
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _botId = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _skillList.push(new BotSkillData(param1));
            _loc3_++;
         }
         return true;
      }
   }
}


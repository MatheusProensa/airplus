package com.sulake.habbo.communication.messages.incoming.room.bots
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.bots.BotSkillListUpdateParser;
   
   [SecureSWF(rename="true")]
   public class BotSkillListUpdateEvent extends MessageEvent implements IMessageEvent
   {
      public function BotSkillListUpdateEvent(param1:Function)
      {
         super(param1,BotSkillListUpdateParser);
      }
      
      public function getParser() : BotSkillListUpdateParser
      {
         return _parser as BotSkillListUpdateParser;
      }
   }
}


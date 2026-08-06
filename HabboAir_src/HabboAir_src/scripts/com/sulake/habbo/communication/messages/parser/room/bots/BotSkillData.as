package com.sulake.habbo.communication.messages.parser.room.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class BotSkillData
   {
      private var _id:int;
      
      private var _data:String;
      
      public function BotSkillData(param1:IMessageDataWrapper)
      {
         super();
         parse(param1);
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         _id = param1.readInteger();
         _data = param1.readString();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get data() : String
      {
         return _data;
      }
   }
}


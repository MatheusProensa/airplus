package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
   
   [SecureSWF(rename="true")]
   public class HabboGroupDetailsMessageParser implements IMessageParser
   {
      private var _data:HabboGroupDetailsData;
      
      public function HabboGroupDetailsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _data = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new HabboGroupDetailsData(param1);
         return true;
      }
      
      public function get data() : HabboGroupDetailsData
      {
         return _data;
      }
   }
}


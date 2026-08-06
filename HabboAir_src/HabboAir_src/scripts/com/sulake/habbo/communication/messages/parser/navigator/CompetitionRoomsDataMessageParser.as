package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsData;
   
   [SecureSWF(rename="true")]
   public class CompetitionRoomsDataMessageParser implements IMessageParser
   {
      private var _data:CompetitionRoomsData;
      
      public function CompetitionRoomsDataMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new CompetitionRoomsData(param1);
         return true;
      }
      
      public function get data() : CompetitionRoomsData
      {
         return _data;
      }
   }
}


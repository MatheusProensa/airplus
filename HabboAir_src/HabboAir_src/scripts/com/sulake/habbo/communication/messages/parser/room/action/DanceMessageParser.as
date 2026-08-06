package com.sulake.habbo.communication.messages.parser.room.action
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class DanceMessageParser implements IMessageParser
   {
      private var _userId:int = 0;
      
      private var _danceStyle:int = 0;
      
      public function DanceMessageParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get danceStyle() : int
      {
         return _danceStyle;
      }
      
      public function flush() : Boolean
      {
         _userId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _userId = param1.readInteger();
         _danceStyle = param1.readInteger();
         return true;
      }
   }
}


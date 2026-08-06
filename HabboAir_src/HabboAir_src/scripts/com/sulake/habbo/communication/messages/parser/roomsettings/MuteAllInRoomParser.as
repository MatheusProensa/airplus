package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MuteAllInRoomParser implements IMessageParser
   {
      private var _allMuted:Boolean;
      
      public function MuteAllInRoomParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _allMuted = param1.readBoolean();
         return true;
      }
      
      public function get allMuted() : Boolean
      {
         return _allMuted;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}


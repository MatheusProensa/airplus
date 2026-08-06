package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorSettingsMessageParser implements IMessageParser
   {
      private var _homeRoomId:int;
      
      private var _roomIdToEnter:int;
      
      public function NavigatorSettingsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _homeRoomId = param1.readInteger();
         _roomIdToEnter = param1.readInteger();
         return true;
      }
      
      public function get homeRoomId() : int
      {
         return _homeRoomId;
      }
      
      public function get roomIdToEnter() : int
      {
         return _roomIdToEnter;
      }
   }
}


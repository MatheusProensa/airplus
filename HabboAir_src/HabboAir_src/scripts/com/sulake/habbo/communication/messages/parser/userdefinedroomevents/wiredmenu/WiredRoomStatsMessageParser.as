package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomStatsData;
   
   public class WiredRoomStatsMessageParser implements IMessageParser
   {
      private var _roomStats:WiredRoomStatsData;
      
      public function WiredRoomStatsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _roomStats = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomStats = new WiredRoomStatsData(param1);
         return true;
      }
      
      public function get roomStats() : WiredRoomStatsData
      {
         return _roomStats;
      }
   }
}


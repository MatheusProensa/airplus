package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRentableBotForceOpenContextMenuEvent extends RoomWidgetUpdateEvent
   {
      public static const OPEN:String = "RWRBFOCME_OPEN";
      
      private var _botId:int;
      
      public function RoomWidgetRentableBotForceOpenContextMenuEvent(param1:int)
      {
         _botId = param1;
         super("RWRBFOCME_OPEN");
      }
      
      public function get botId() : int
      {
         return _botId;
      }
   }
}


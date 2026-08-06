package com.sulake.habbo.catalog.viewer.widgets.events
{
   import com.sulake.habbo.room.IStuffData;
   import flash.events.Event;
   
   public class SetRoomPreviewerStuffDataEvent extends Event
   {
      private var _stuffData:IStuffData;
      
      public function SetRoomPreviewerStuffDataEvent(param1:IStuffData, param2:Boolean = false, param3:Boolean = false)
      {
         super("CWE_SET_PREVIEWER_STUFFDATA",param2,param3);
         _stuffData = param1;
      }
      
      public function get stuffData() : IStuffData
      {
         return _stuffData;
      }
   }
}


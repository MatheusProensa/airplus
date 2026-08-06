package com.sulake.habbo.ui.widget.chooser
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class ChooserWidgetBase extends RoomWidgetBase
   {
      public function ChooserWidgetBase(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
      }
      
      public function choose(param1:int, param2:int) : void
      {
         var _loc3_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage("RWROM_SELECT_OBJECT",param1,param2);
         messageListener.processWidgetMessage(_loc3_);
      }
   }
}


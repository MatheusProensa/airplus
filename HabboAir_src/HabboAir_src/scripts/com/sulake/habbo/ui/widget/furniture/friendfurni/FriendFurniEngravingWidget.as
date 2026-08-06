package com.sulake.habbo.ui.widget.furniture.friendfurni
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FriendFurniEngravingWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class FriendFurniEngravingWidget extends RoomWidgetBase
   {
      private var _stuffId:int = -1;
      
      private var UnknownVarFromFriendFurniEngravingWidget_FriendFurniEngravingView_1:FriendFurniEngravingView;
      
      public function FriendFurniEngravingWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager)
      {
         super(param1,param2,param3,param4);
         engravingWidgetHandler.widget = this;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get engravingWidgetHandler() : FriendFurniEngravingWidgetHandler
      {
         return _widgetHandler as FriendFurniEngravingWidgetHandler;
      }
      
      public function open(param1:int, param2:int, param3:StringArrayStuffData) : void
      {
         close(_stuffId);
         _stuffId = param1;
         switch(param2)
         {
            case 0:
               UnknownVarFromFriendFurniEngravingWidget_FriendFurniEngravingView_1 = new LoveLockEngravingView(this,param3);
               break;
            case 1:
            case 2:
               break;
            case 3:
               UnknownVarFromFriendFurniEngravingWidget_FriendFurniEngravingView_1 = new WildWestEngravingView(this,param3);
               break;
            case 4:
               UnknownVarFromFriendFurniEngravingWidget_FriendFurniEngravingView_1 = new HabboweenEngravingView(this,param3);
         }
         UnknownVarFromFriendFurniEngravingWidget_FriendFurniEngravingView_1.open();
      }
      
      public function close(param1:int) : void
      {
         if(param1 == _stuffId && UnknownVarFromFriendFurniEngravingWidget_FriendFurniEngravingView_1)
         {
            UnknownVarFromFriendFurniEngravingWidget_FriendFurniEngravingView_1.dispose();
            UnknownVarFromFriendFurniEngravingWidget_FriendFurniEngravingView_1 = null;
            _stuffId = -1;
         }
      }
   }
}


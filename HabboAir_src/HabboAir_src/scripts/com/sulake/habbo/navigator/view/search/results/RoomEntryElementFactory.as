package com.sulake.habbo.navigator.view.search.results
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.navigator.view.search.ViewMode;
   import com.sulake.habbo.window.utils.UnknownHabboWindowUtils1;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.geom.Rectangle;
   
   public class RoomEntryElementFactory
   {
      public static const TILES_PER_CONTAINER:int = 3;
      
      private var _navigator:HabboNewNavigator;
      
      private var UnknownVarFromRoomEntryElementFactory_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromRoomEntryElementFactory_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromRoomEntryElementFactory_IItemListWindow_1:IItemListWindow;
      
      private var _viewMode:int;
      
      public function RoomEntryElementFactory(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
         _viewMode = ViewMode.getViewMode("hotel_view");
      }
      
      public function set viewMode(param1:int) : void
      {
         _viewMode = param1;
      }
      
      public function set rowEntryTemplate(param1:IWindowController_1) : void
      {
         UnknownVarFromRoomEntryElementFactory_IWindowController_1_1 = param1;
      }
      
      public function set tileEntryTemplate(param1:IWindowController_1) : void
      {
         UnknownVarFromRoomEntryElementFactory_IWindowController_1_2 = param1;
      }
      
      public function set tileContainerTemplate(param1:IItemListWindow) : void
      {
         UnknownVarFromRoomEntryElementFactory_IItemListWindow_1 = param1;
      }
      
      public function get rowEntryTemplateHeight() : int
      {
         return UnknownVarFromRoomEntryElementFactory_IWindowController_1_1.height;
      }
      
      public function getNewRowElement(param1:GuestRoomData, param2:int, param3:int = -1) : IWindowController_1
      {
         var _loc4_:IWindowController_1 = IWindowController_1(UnknownVarFromRoomEntryElementFactory_IWindowController_1_1.clone());
         if(param3 != -1)
         {
            _loc4_.width = param3;
         }
         UnknownICoreWindowComponents6(_loc4_).color = RoomEntryUtils.getModulatedBackgroundColor(param2,UnknownICoreWindowComponents6(_loc4_).color);
         updateCommonEntryElements(_loc4_,param1,false);
         _loc4_.findChildByName("grouphome_icon").visible = param1.groupBadgeCode != "";
         return _loc4_;
      }
      
      public function getNewTileElement(param1:GuestRoomData, param2:int) : IWindowController_1
      {
         var _loc3_:IWindowController_1 = IWindowController_1(UnknownVarFromRoomEntryElementFactory_IWindowController_1_2.clone());
         updateCommonEntryElements(_loc3_,param1,true);
         if(param1.groupBadgeCode != "")
         {
            _loc3_.findChildByName("room_group_badge").visible = true;
            IBadgeImageWidget(IWidgetWindowController(_loc3_.findChildByName("room_group_badge")).widget).badgeId = param1.groupBadgeCode;
         }
         if(param1.officialRoomPicRef != null)
         {
            if(_navigator.getBoolean("new.navigator.official.room.thumbnails.in.amazon"))
            {
               IStaticBitmapWrapperWindow(_loc3_.findChildByName("room_pic_placeholder")).assetUri = _navigator.getProperty("navigator.thumbnail.url_base") + param1.officialRoomPicRef;
            }
            else
            {
               IStaticBitmapWrapperWindow(_loc3_.findChildByName("room_pic_placeholder")).assetUri = _navigator.getProperty("image.library.url") + param1.officialRoomPicRef;
            }
         }
         else
         {
            IStaticBitmapWrapperWindow(_loc3_.findChildByName("room_pic_placeholder")).assetUri = _navigator.getProperty("navigator.thumbnail.url_base") + param1.flatId + ".png";
         }
         return _loc3_;
      }
      
      private function updateCommonEntryElements(param1:IWindowController_1, param2:GuestRoomData, param3:Boolean) : void
      {
         param1.findChildByName("room_usercount").caption = param2.userCount.toString();
         param1.findChildByName("room_name").caption = ViewMode.isEventViewMode(_viewMode) ? param2.roomAdName : param2.roomName;
         param1.findChildByName("go_to_room_region").id = param2.flatId;
         param1.findChildByName("go_to_room_region").addEventListener("WME_CLICK",onGoButtonClicked);
         param1.findChildByName("go_to_room_region").addEventListener("WME_OVER",param3 ? onTileGoToRoomMouseOver : onGoToRoomMouseOver);
         param1.findChildByName("info_popup_click_region").id = param2.flatId;
         param1.findChildByName("info_popup_click_region").addEventListener("WME_CLICK",onMouseClicked);
         param1.findChildByName("info_popup_click_region").addEventListener("WME_OVER",onRoomRoomInfoMouseOver);
         UnknownICoreWindowComponents6(param1.findChildByName("room_info_usercount_border")).color = UnknownHabboWindowUtils1.getUserCountColor(param2.userCount,param2.maxUserCount);
         IStaticBitmapWrapperWindow(param1.findChildByName("doormode_icon")).assetUri = RoomEntryUtils.getDoorModeIconAsset(param2.doorMode);
      }
      
      public function getNewTileContainerElement() : IItemListWindow
      {
         return UnknownVarFromRoomEntryElementFactory_IItemListWindow_1.clone() as IItemListWindow;
      }
      
      private function onGoButtonClicked(param1:WindowEvent) : void
      {
         _navigator.goToRoom(param1.window.id);
      }
      
      private function onMouseClicked(param1:WindowEvent) : void
      {
         var _loc2_:Rectangle = new Rectangle();
         param1.window.getGlobalRectangle(_loc2_);
         _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(param1.window.id),_loc2_.right,(_loc2_.bottom - _loc2_.top) / 2 + _loc2_.top);
      }
      
      private function onRoomRoomInfoMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(_navigator.view.isRoomInfoBubbleVisible)
         {
            _loc2_ = new Rectangle();
            param1.window.getGlobalRectangle(_loc2_);
            _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(param1.window.id),_loc2_.right,(_loc2_.bottom - _loc2_.top) / 2 + _loc2_.top,true);
         }
      }
      
      private function onTileGoToRoomMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(_navigator.view.isRoomInfoBubbleVisible)
         {
            _loc2_ = new Rectangle();
            param1.window.getGlobalRectangle(_loc2_);
            _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(param1.window.id),_loc2_.right - 6,(_loc2_.bottom - _loc2_.top) / 2 + _loc2_.top + 56,true);
         }
      }
      
      private function onGoToRoomMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(_navigator.view.isRoomInfoBubbleVisible)
         {
            _loc2_ = new Rectangle();
            param1.window.getGlobalRectangle(_loc2_);
            _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(param1.window.id),_loc2_.right + 20,(_loc2_.bottom - _loc2_.top) / 2 + _loc2_.top,true);
         }
      }
      
      private function onOwnerLinkClicked(param1:WindowEvent) : void
      {
         _navigator.getExtendedProfile(param1.window.id);
      }
      
      private function onGroupLinkClicked(param1:WindowEvent) : void
      {
         _navigator.getGuildInfo(param1.window.id);
      }
      
      private function onFavoriteRegionClicked(param1:WindowEvent) : void
      {
         var _loc2_:Boolean = _navigator.legacyNavigator.isRoomFavorite(param1.window.id);
         if(_loc2_)
         {
            _navigator.communication.connection.send(new DeleteFavouriteRoomMessageComposer(param1.window.id));
         }
         else
         {
            _navigator.communication.connection.send(new AddFavouriteRoomMessageComposer(param1.window.id));
         }
         IStaticBitmapWrapperWindow(IRegionWindow(param1.window).findChildByName("favourite_icon")).assetUri = RoomEntryUtils.getFavoriteIcon(!_loc2_);
      }
   }
}


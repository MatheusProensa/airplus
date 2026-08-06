package com.sulake.habbo.ui.widget.roomtools
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class RoomToolsHistory
   {
      private static const PADDING:int = 5;
      
      private static const SPACING:int = 2;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromRoomToolsHistory_RoomToolsWidgetHandler_1:RoomToolsWidgetHandler;
      
      private var _items:Vector.<IWindowController_1> = new Vector.<IWindowController_1>();
      
      public function RoomToolsHistory(param1:IHabboWindowManagerComponent, param2:IAssetLibraryCollection, param3:RoomToolsWidgetHandler)
      {
         super();
         UnknownVarFromRoomToolsHistory_RoomToolsWidgetHandler_1 = param3;
         _assets = param2;
         _windowManager = param1;
         _window = param1.buildFromXML(param2.getAssetByName("room_tools_history_xml").content as XML) as IWindowController_1;
      }
      
      public function populate(param1:Vector.<RoomVisitHistoryEntry>) : void
      {
         var _loc3_:IWindowModel = null;
         var _loc2_:IWindowController_1 = null;
         clearItems();
         for each(var _loc4_ in param1)
         {
            _loc2_ = _windowManager.buildFromXML(_assets.getAssetByName("room_tools_history_item_xml").content as XML) as IWindowController_1;
            _window.addChild(_loc2_);
            _loc2_.findChildByName("room_name").caption = _loc4_.roomName;
            if(_loc3_)
            {
               _loc2_.y = _loc3_.bottom + 2;
            }
            else
            {
               _loc2_.y = 5;
            }
            _loc2_.x = 5;
            _loc2_.id = _loc4_.flatId;
            _loc2_.procedure = onClick;
            _loc3_ = _loc2_;
            _items.push(_loc2_);
         }
         _window.height = !!_loc3_ ? _loc3_.bottom + 2 * 5 : 2 * 5;
      }
      
      public function dispose() : void
      {
         clearItems();
         _items = null;
         _windowManager = null;
         UnknownVarFromRoomToolsHistory_RoomToolsWidgetHandler_1 = null;
         _assets = null;
         _window.dispose();
         _window = null;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromRoomToolsHistory_RoomToolsWidgetHandler_1.goToPrivateRoom(param2.id);
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function clearItems() : void
      {
         if(_items == null)
         {
            return;
         }
         for each(var _loc1_ in _items)
         {
            _loc1_.procedure = null;
            _loc1_.dispose();
         }
         _items.length = 0;
      }
   }
}


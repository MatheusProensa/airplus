package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitData;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsData;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomVisitsMessageComposer;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RoomVisitsCtrl implements IComponentInterfaceQueue, ITrackedWindow
   {
      private static var ROOM_ROW_POOL_MAX_SIZE:int = 200;
      
      private static var ROOM_ROW_POOL:Array = [];
      
      private var _main:ModerationManager;
      
      private var _frame:IFrameController;
      
      private var UnknownVarFromRoomVisitsCtrl_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromRoomVisitsCtrl_Int_1:int;
      
      private var _rooms:Array;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromRoomVisitsCtrl_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromRoomVisitsCtrl_Timer_1:Timer;
      
      private var UnknownVarFromRoomVisitsCtrl_Array_1:Array = [];
      
      public function RoomVisitsCtrl(param1:ModerationManager, param2:int)
      {
         super();
         _main = param1;
         UnknownVarFromRoomVisitsCtrl_Int_1 = param2;
      }
      
      public static function getFormattedTime(param1:int, param2:int) : String
      {
         return padToTwoDigits(param1) + ":" + padToTwoDigits(param2);
      }
      
      public static function padToTwoDigits(param1:int) : String
      {
         return param1 < 10 ? "0" + param1 : "" + param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         UnknownVarFromRoomVisitsCtrl_Timer_1 = new Timer(300,1);
         UnknownVarFromRoomVisitsCtrl_Timer_1.addEventListener("timer",onResizeTimer);
         _main.messageHandler.addRoomVisitsListener(this);
         _main.connection.send(new GetRoomVisitsMessageComposer(UnknownVarFromRoomVisitsCtrl_Int_1));
         _frame = IFrameController(_main.getXmlWindow("roomvisits_frame"));
         UnknownVarFromRoomVisitsCtrl_IItemListWindow_1 = IItemListWindow(_frame.findChildByName("visits_list"));
         UnknownVarFromRoomVisitsCtrl_IWindowController_1_1 = UnknownVarFromRoomVisitsCtrl_IItemListWindow_1.getListItemAt(0) as IWindowController_1;
         UnknownVarFromRoomVisitsCtrl_IItemListWindow_1.removeListItems();
         _frame.procedure = onWindow;
         var _loc1_:IWindowModel = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
      }
      
      public function onRoomVisits(param1:RoomVisitsData) : void
      {
         if(param1.userId != UnknownVarFromRoomVisitsCtrl_Int_1)
         {
            return;
         }
         if(_disposed)
         {
            return;
         }
         this._rooms = param1.rooms;
         _frame.caption = "Room visits: " + param1.userName;
         populate();
         onResizeTimer(null);
         _frame.visible = true;
         _main.messageHandler.removeRoomVisitsListener(this);
      }
      
      public function getType() : int
      {
         return 6;
      }
      
      public function getId() : String
      {
         return "" + UnknownVarFromRoomVisitsCtrl_Int_1;
      }
      
      public function getFrame() : IFrameController
      {
         return _frame;
      }
      
      private function populate() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = true;
         for each(_loc2_ in _rooms)
         {
            populateRoomRow(_loc2_,_loc1_);
            _loc1_ = !_loc1_;
         }
      }
      
      private function populateRoomRow(param1:RoomVisitData, param2:Boolean) : void
      {
         var _loc4_:IWindowController_1 = getRoomRowWindow();
         var _loc3_:uint = param2 ? 4288861930 : 4294967295;
         _loc4_.color = _loc3_;
         var _loc7_:IWindowModel = _loc4_.findChildByName("room_name_txt");
         _loc7_.caption = param1.roomName;
         new OpenRoomTool(_frame,_main,_loc7_,param1.roomId);
         _loc7_.color = _loc3_;
         var _loc5_:ITextWindow = ITextWindow(_loc4_.findChildByName("time_txt"));
         _loc5_.text = getFormattedTime(param1.enterHour,param1.enterMinute);
         var _loc6_:ITextWindow = ITextWindow(_loc4_.findChildByName("view_room_txt"));
         new OpenRoomInSpectatorMode(_main,_loc6_,param1.roomId);
         _loc6_.color = _loc3_;
         addRoomRowToList(_loc4_,UnknownVarFromRoomVisitsCtrl_IItemListWindow_1);
      }
      
      private function addRoomRowToList(param1:IWindowController_1, param2:IItemListWindow) : void
      {
         param2.addListItem(param1);
         UnknownVarFromRoomVisitsCtrl_Array_1.push(param1);
      }
      
      private function getRoomRowWindow() : IWindowController_1
      {
         if(ROOM_ROW_POOL.length > 0)
         {
            return ROOM_ROW_POOL.pop() as IWindowController_1;
         }
         return IWindowController_1(UnknownVarFromRoomVisitsCtrl_IWindowController_1_1.clone());
      }
      
      private function storeRoomRowWindow(param1:IWindowController_1) : void
      {
         var _loc3_:IWindowModel = null;
         var _loc2_:IWindowModel = null;
         if(ROOM_ROW_POOL.length < ROOM_ROW_POOL_MAX_SIZE)
         {
            _loc3_ = param1.findChildByName("room_name_txt");
            _loc3_.procedure = null;
            _loc2_ = param1.findChildByName("view_room_txt");
            _loc2_.procedure = null;
            param1.width = UnknownVarFromRoomVisitsCtrl_IWindowController_1_1.width;
            param1.height = UnknownVarFromRoomVisitsCtrl_IWindowController_1_1.height;
            ROOM_ROW_POOL.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      private function onClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WE_RESIZED" || param2 != _frame)
         {
            return;
         }
         if(!this.UnknownVarFromRoomVisitsCtrl_Timer_1.running)
         {
            this.UnknownVarFromRoomVisitsCtrl_Timer_1.reset();
            this.UnknownVarFromRoomVisitsCtrl_Timer_1.start();
         }
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         var _loc3_:IWindowController_1 = IWindowController_1(UnknownVarFromRoomVisitsCtrl_IItemListWindow_1.parent);
         var _loc5_:IWindowModel = _loc3_.getChildByName("scroller") as IWindowModel;
         var _loc4_:* = UnknownVarFromRoomVisitsCtrl_IItemListWindow_1.scrollableRegion.height > UnknownVarFromRoomVisitsCtrl_IItemListWindow_1.height;
         var _loc2_:int = 17;
         if(_loc5_.visible)
         {
            if(!_loc4_)
            {
               _loc5_.visible = false;
               UnknownVarFromRoomVisitsCtrl_IItemListWindow_1.width += _loc2_;
            }
         }
         else if(_loc4_)
         {
            _loc5_.visible = true;
            UnknownVarFromRoomVisitsCtrl_IItemListWindow_1.width -= _loc2_;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(UnknownVarFromRoomVisitsCtrl_IItemListWindow_1 != null)
         {
            UnknownVarFromRoomVisitsCtrl_IItemListWindow_1.removeListItems();
            UnknownVarFromRoomVisitsCtrl_IItemListWindow_1.dispose();
            UnknownVarFromRoomVisitsCtrl_IItemListWindow_1 = null;
         }
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _main = null;
         if(UnknownVarFromRoomVisitsCtrl_Timer_1 != null)
         {
            UnknownVarFromRoomVisitsCtrl_Timer_1.stop();
            UnknownVarFromRoomVisitsCtrl_Timer_1.removeEventListener("timer",onResizeTimer);
            UnknownVarFromRoomVisitsCtrl_Timer_1 = null;
         }
         for each(_loc1_ in UnknownVarFromRoomVisitsCtrl_Array_1)
         {
            storeRoomRowWindow(_loc1_);
         }
         if(UnknownVarFromRoomVisitsCtrl_IWindowController_1_1 != null)
         {
            UnknownVarFromRoomVisitsCtrl_IWindowController_1_1.dispose();
            UnknownVarFromRoomVisitsCtrl_IWindowController_1_1 = null;
         }
         UnknownVarFromRoomVisitsCtrl_Array_1 = [];
      }
   }
}


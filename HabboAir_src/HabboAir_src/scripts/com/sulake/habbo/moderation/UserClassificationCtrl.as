package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.userclassification.UserClassificationData;
   import com.sulake.habbo.util.VisitUserUtil;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class UserClassificationCtrl implements IComponentInterfaceQueue, ITrackedWindow
   {
      private static var CLASSIFICATION_ROW_POOL_MAX_SIZE:int = 200;
      
      private static var CLASSIFICATION_ROW_POOL:Array = [];
      
      private var _main:ModerationManager;
      
      private var _frame:IFrameController;
      
      private var UnknownVarFromUserClassificationCtrl_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromUserClassificationCtrl_Int_1:int;
      
      private var UnknownVarFromUserClassificationCtrl_Array_1:Array;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromUserClassificationCtrl_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromUserClassificationCtrl_Timer_1:Timer;
      
      private var UnknownVarFromUserClassificationCtrl_Array_2:Array = [];
      
      public function UserClassificationCtrl(param1:ModerationManager, param2:int)
      {
         super();
         _main = param1;
         UnknownVarFromUserClassificationCtrl_Int_1 = param2;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         UnknownVarFromUserClassificationCtrl_Timer_1 = new Timer(300,1);
         UnknownVarFromUserClassificationCtrl_Timer_1.addEventListener("timer",onResizeTimer);
         _main.messageHandler.addUserClassificationListener(this);
         _frame = IFrameController(_main.getXmlWindow("userclassification_frame"));
         UnknownVarFromUserClassificationCtrl_IItemListWindow_1 = IItemListWindow(_frame.findChildByName("userclassification_list"));
         UnknownVarFromUserClassificationCtrl_IWindowController_1_1 = UnknownVarFromUserClassificationCtrl_IItemListWindow_1.getListItemAt(0) as IWindowController_1;
         UnknownVarFromUserClassificationCtrl_IItemListWindow_1.removeListItems();
         _frame.procedure = onWindow;
         var _loc1_:IWindowModel = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
      }
      
      public function onUserClassification(param1:int, param2:Array) : void
      {
         if(param1 != UnknownVarFromUserClassificationCtrl_Int_1)
         {
            return;
         }
         if(_disposed)
         {
            return;
         }
         this.UnknownVarFromUserClassificationCtrl_Array_1 = param2;
         _frame.caption = "";
         populate();
         onResizeTimer(null);
         _frame.visible = true;
         _main.messageHandler.removeUserClassificationListener(this);
      }
      
      private function populate() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = true;
         for each(_loc2_ in UnknownVarFromUserClassificationCtrl_Array_1)
         {
            populateRoomRow(_loc2_,_loc1_);
            _loc1_ = !_loc1_;
         }
      }
      
      private function populateRoomRow(param1:UserClassificationData, param2:Boolean) : void
      {
         var _loc5_:IWindowController_1 = getRoomRowWindow();
         var _loc3_:uint = param2 ? 4288861930 : 4294967295;
         _loc5_.color = _loc3_;
         var _loc6_:IWindowModel = _loc5_.findChildByName("user_name_txt");
         _loc6_.caption = param1.username;
         _loc6_.color = _loc3_;
         var _loc4_:ITextWindow = ITextWindow(_loc5_.findChildByName("visit_room_txt"));
         _loc4_.color = _loc3_;
         var _loc7_:ITextWindow = ITextWindow(_loc5_.findChildByName("user_classification_txt"));
         _loc7_.text = param1.classType;
         if(!_main || !_main.isModerator)
         {
            _loc7_.visible = false;
            _loc4_.visible = false;
         }
         addClassificationRowToList(_loc5_,UnknownVarFromUserClassificationCtrl_IItemListWindow_1);
         if(_main && _main.isModerator)
         {
            new OpenUserInfo(_frame,_main,_loc6_,param1.userId);
            new VisitUserUtil(_main,_loc4_,param1.userId);
         }
      }
      
      private function addClassificationRowToList(param1:IWindowController_1, param2:IItemListWindow) : void
      {
         param2.addListItem(param1);
         UnknownVarFromUserClassificationCtrl_Array_2.push(param1);
      }
      
      private function getRoomRowWindow() : IWindowController_1
      {
         if(CLASSIFICATION_ROW_POOL.length > 0)
         {
            return CLASSIFICATION_ROW_POOL.pop() as IWindowController_1;
         }
         return IWindowController_1(UnknownVarFromUserClassificationCtrl_IWindowController_1_1.clone());
      }
      
      private function storeClassificationRowWindow(param1:IWindowController_1) : void
      {
         var _loc3_:IWindowModel = null;
         var _loc2_:IWindowModel = null;
         if(CLASSIFICATION_ROW_POOL.length < CLASSIFICATION_ROW_POOL_MAX_SIZE)
         {
            _loc3_ = param1.findChildByName("user_name_txt");
            _loc3_.procedure = null;
            _loc2_ = param1.findChildByName("visit_room_txt");
            _loc2_.procedure = null;
            param1.width = UnknownVarFromUserClassificationCtrl_IWindowController_1_1.width;
            param1.height = UnknownVarFromUserClassificationCtrl_IWindowController_1_1.height;
            CLASSIFICATION_ROW_POOL.push(param1);
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
         if(!this.UnknownVarFromUserClassificationCtrl_Timer_1.running)
         {
            this.UnknownVarFromUserClassificationCtrl_Timer_1.reset();
            this.UnknownVarFromUserClassificationCtrl_Timer_1.start();
         }
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         var _loc3_:IWindowController_1 = IWindowController_1(UnknownVarFromUserClassificationCtrl_IItemListWindow_1.parent);
         var _loc5_:IWindowModel = _loc3_.getChildByName("scroller") as IWindowModel;
         var _loc4_:* = UnknownVarFromUserClassificationCtrl_IItemListWindow_1.scrollableRegion.height > UnknownVarFromUserClassificationCtrl_IItemListWindow_1.height;
         var _loc2_:int = 17;
         if(_loc5_.visible)
         {
            if(!_loc4_)
            {
               _loc5_.visible = false;
               UnknownVarFromUserClassificationCtrl_IItemListWindow_1.width += _loc2_;
            }
         }
         else if(_loc4_)
         {
            _loc5_.visible = true;
            UnknownVarFromUserClassificationCtrl_IItemListWindow_1.width -= _loc2_;
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
         if(UnknownVarFromUserClassificationCtrl_IItemListWindow_1 != null)
         {
            UnknownVarFromUserClassificationCtrl_IItemListWindow_1.removeListItems();
            UnknownVarFromUserClassificationCtrl_IItemListWindow_1.dispose();
            UnknownVarFromUserClassificationCtrl_IItemListWindow_1 = null;
         }
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _main = null;
         if(UnknownVarFromUserClassificationCtrl_Timer_1 != null)
         {
            UnknownVarFromUserClassificationCtrl_Timer_1.stop();
            UnknownVarFromUserClassificationCtrl_Timer_1.removeEventListener("timer",onResizeTimer);
            UnknownVarFromUserClassificationCtrl_Timer_1 = null;
         }
         for each(_loc1_ in UnknownVarFromUserClassificationCtrl_Array_2)
         {
            storeClassificationRowWindow(_loc1_);
         }
         if(UnknownVarFromUserClassificationCtrl_IWindowController_1_1 != null)
         {
            UnknownVarFromUserClassificationCtrl_IWindowController_1_1.dispose();
            UnknownVarFromUserClassificationCtrl_IWindowController_1_1 = null;
         }
         UnknownVarFromUserClassificationCtrl_Array_2 = [];
      }
      
      public function getType() : int
      {
         return 6;
      }
      
      public function getId() : String
      {
         return "" + UnknownVarFromUserClassificationCtrl_Int_1;
      }
      
      public function getFrame() : IFrameController
      {
         return _frame;
      }
   }
}


package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.utils.FixedSizeStack;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class VariableInfoBubbleView implements IComponentInterfaceQueue, IProfiler_1
   {
      private static const UnknownConstFromVariableInfoBubbleView_Int_1:int = 18;
      
      public static const UnknownConstFromContextInfoView_Int_2:int = 3;
      
      private static const MAX_VERTICAL_LEAD_RATIO:Number = 0.05;
      
      private static var STATE_IDLE:int = 0;
      
      private static var STATE_AWAIT_TARGET_RECT:int = 1;
      
      private static var STATE_ACTIVE:int = 1;
      
      private var _disposed:Boolean;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var UnknownVarFromVariableInfoBubbleView_Int_1:int = STATE_IDLE;
      
      private var _objectId:int;
      
      private var _category:int;
      
      private var UnknownVarFromVariableInfoBubbleView_Boolean_1:Boolean;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromVariableInfoBubbleView_Int_2:int = 0;
      
      protected var UnknownVarFromVariableInfoBubbleView_FixedSizeStack_1:FixedSizeStack = new FixedSizeStack(18);
      
      public function VariableInfoBubbleView(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         var _loc2_:XmlAsset = _roomEvents.assets.getAssetByName("variable_value_info_bubble_xml") as XmlAsset;
         _window = _roomEvents.windowManager.buildFromXML(_loc2_.content as XML,0) as IWindowController_1;
         _window.ignoreMouseEvents = true;
      }
      
      public function updateValue(param1:String) : void
      {
         if(UnknownVarFromVariableInfoBubbleView_Int_1 == STATE_IDLE)
         {
            return;
         }
         valueText.text = param1;
      }
      
      public function setActive(param1:String, param2:int, param3:int, param4:Boolean) : void
      {
         if(UnknownVarFromVariableInfoBubbleView_Int_1 != STATE_IDLE)
         {
            return;
         }
         valueText.text = param1;
         _objectId = param2;
         _category = param3;
         UnknownVarFromVariableInfoBubbleView_Boolean_1 = param4;
         UnknownVarFromVariableInfoBubbleView_Int_1 = STATE_AWAIT_TARGET_RECT;
      }
      
      public function setInactive() : void
      {
         valueText.text = "";
         _objectId = 0;
         _category = 0;
         UnknownVarFromVariableInfoBubbleView_Int_2 = 0;
         UnknownVarFromVariableInfoBubbleView_FixedSizeStack_1.reset();
         UnknownVarFromVariableInfoBubbleView_Int_1 = STATE_IDLE;
         hide();
      }
      
      private function show() : void
      {
         var _loc1_:IDesktopController = null;
         _window.visible = true;
         if(_window.parent == null)
         {
            _loc1_ = _roomEvents.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         else
         {
            _window.activate();
         }
      }
      
      private function hide() : void
      {
         var _loc1_:IDesktopController = null;
         _window.visible = false;
         if(_window.parent != null)
         {
            _loc1_ = _roomEvents.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function get valueText() : ITextWindow
      {
         return _window.findChildByName("value") as ITextWindow;
      }
      
      public function update(param1:uint) : void
      {
         if(UnknownVarFromVariableInfoBubbleView_Int_1 == STATE_IDLE)
         {
            return;
         }
         var _loc13_:IRoomEngine = _roomEvents.roomEngine;
         var _loc3_:IRoomDesktop = _roomEvents.roomDesktop;
         var _loc8_:Rectangle = _loc13_.getRoomObjectBoundingRectangle(_loc13_.activeRoomId,_objectId,_category,_loc3_.getFirstCanvasId());
         var _loc9_:Point = _loc13_.getRoomObjectScreenLocation(_loc13_.activeRoomId,_objectId,_category,_loc3_.getFirstCanvasId());
         var _loc10_:Rectangle = _loc3_.getRoomViewRect();
         if(_loc8_ && _loc9_ && _loc10_)
         {
            _loc8_.offset(_loc10_.x,_loc10_.y);
            _loc9_.offset(_loc10_.x,_loc10_.y);
         }
         if(!_loc8_ || !_loc9_)
         {
            return;
         }
         var _loc2_:int = getOffset(_loc8_);
         var _loc4_:int = _loc9_.y - _loc8_.top;
         UnknownVarFromVariableInfoBubbleView_FixedSizeStack_1.addValue(_loc4_);
         var _loc5_:int = UnknownVarFromVariableInfoBubbleView_FixedSizeStack_1.getMax();
         if(_loc5_ < UnknownVarFromVariableInfoBubbleView_Int_2 - 3)
         {
            _loc5_ = UnknownVarFromVariableInfoBubbleView_Int_2 - 3;
         }
         var _loc12_:int = _loc9_.y - _loc5_;
         UnknownVarFromVariableInfoBubbleView_Int_2 = _loc5_;
         var _loc7_:int = _loc8_.top + _loc2_;
         var _loc11_:int = _loc7_ - getMaximumVerticalLead(_loc8_);
         var _loc6_:* = _loc12_ + _loc2_;
         if(_loc6_ < _loc11_)
         {
            _loc6_ = _loc11_;
         }
         _window.x = _loc9_.x - _window.width / 2;
         _window.y = _loc6_;
         if(UnknownVarFromVariableInfoBubbleView_Int_1 == STATE_AWAIT_TARGET_RECT)
         {
            UnknownVarFromVariableInfoBubbleView_Int_1 = STATE_ACTIVE;
            show();
         }
      }
      
      private function getOffset(param1:Rectangle) : int
      {
         var _loc2_:int = -_window.height;
         if(UnknownVarFromVariableInfoBubbleView_Boolean_1)
         {
            _loc2_ += param1.height > 50 ? 25 : 0;
         }
         else
         {
            _loc2_ -= 4;
         }
         return _loc2_;
      }
      
      private function getMaximumVerticalLead(param1:Rectangle) : int
      {
         return int(param1.height * 0.05);
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         hide();
         _window.dispose();
         _window = null;
         _roomEvents = null;
         UnknownVarFromVariableInfoBubbleView_FixedSizeStack_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}


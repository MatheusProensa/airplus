package com.sulake.habbo.ui.widget.contextmenu
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.utils.FixedSizeStack;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class ContextInfoView implements IComponentInterfaceQueue
   {
      protected static const CONTEXT_INFO_DELAY:uint = 3000;
      
      protected static const BUTTON_COLOR_DEFAULT:uint = 4281149991;
      
      protected static const BUTTON_COLOR_HOVER:uint = 4282950861;
      
      protected static const UnknownConstFromContextInfoView_Uint_1:uint = 4288230144;
      
      protected static const LINK_COLOR_ACTIONS_DEFAULT:uint = 16777215;
      
      protected static const LINK_COLOR_ACTIONS_HOVER:uint = 9552639;
      
      protected static const UnknownConstFromContextInfoView_Uint_2:uint = 16777215;
      
      protected static const UnknownConstFromContextInfoView_Uint_3:uint = 5789011;
      
      protected static const ICON_COLOR_ENABLED:uint = 13947341;
      
      protected static const ICON_COLOR_DISABLED:uint = 5789011;
      
      private static const UnknownConstFromContextInfoView_Int_1:int = 25;
      
      public static const UnknownConstFromContextInfoView_Int_2:int = 3;
      
      private static const MAX_VERTICAL_LEAD_RATIO:Number = 0.05;
      
      protected static var UnknownVarFromContextInfoView_Boolean_1:Boolean = false;
      
      protected var _window:IWindowController_1;
      
      protected var UnknownVarFromContextInfoView_IWindowController_1_1:IWindowController_1;
      
      protected var UnknownVarFromContextInfoView_IWindowController_1_2:IWindowController_1;
      
      private var _forcedPositionUpdate:Boolean;
      
      protected var UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1:UnknownIHabboUiWidgetContextmenu1;
      
      protected var UnknownVarFromContextInfoView_Boolean_2:Boolean;
      
      protected var UnknownVarFromContextInfoView_FixedSizeStack_1:FixedSizeStack = new FixedSizeStack(25);
      
      protected var UnknownVarFromContextInfoView_Int_1:int = -1000000;
      
      protected var _disposed:Boolean = false;
      
      private var _forceActivateOnUpdate:Boolean = true;
      
      protected var UnknownVarFromContextInfoView_Timer_1:Timer;
      
      protected var UnknownVarFromContextInfoView_Int_2:int = 3000;
      
      protected var UnknownVarFromContextInfoView_Boolean_3:Boolean;
      
      protected var UnknownVarFromContextInfoView_Boolean_4:Boolean;
      
      protected var UnknownVarFromContextInfoView_Number_1:Number;
      
      protected var _fadeTime:int;
      
      protected var _fadeLength:int = 500;
      
      protected var UnknownVarFromContextInfoView_Boolean_5:Boolean;
      
      public function ContextInfoView(param1:UnknownIHabboUiWidgetContextmenu1)
      {
         super();
         UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 = param1;
         UnknownVarFromContextInfoView_Boolean_5 = true;
         UnknownVarFromContextInfoView_Boolean_3 = false;
         UnknownVarFromContextInfoView_Boolean_4 = false;
      }
      
      public static function setupContext(param1:ContextInfoView) : void
      {
         param1.UnknownVarFromContextInfoView_Boolean_3 = false;
         param1._fadeLength = 500;
         param1.UnknownVarFromContextInfoView_Boolean_4 = false;
         param1.UnknownVarFromContextInfoView_Number_1 = 1;
         param1.UnknownVarFromContextInfoView_Boolean_2 = false;
         if(param1.UnknownVarFromContextInfoView_Boolean_5)
         {
            if(!param1.UnknownVarFromContextInfoView_Timer_1)
            {
               param1.UnknownVarFromContextInfoView_Timer_1 = new Timer(param1.UnknownVarFromContextInfoView_Int_2,1);
               param1.UnknownVarFromContextInfoView_Timer_1.addEventListener("timerComplete",param1.onTimerComplete);
            }
            param1.UnknownVarFromContextInfoView_Timer_1.reset();
            param1.UnknownVarFromContextInfoView_Timer_1.start();
         }
         param1.updateWindow();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get maximumBlend() : Number
      {
         return 1;
      }
      
      public function dispose() : void
      {
         UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 = null;
         UnknownVarFromContextInfoView_IWindowController_1_2 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromContextInfoView_IWindowController_1_1)
         {
            UnknownVarFromContextInfoView_IWindowController_1_1.dispose();
            UnknownVarFromContextInfoView_IWindowController_1_1 = null;
         }
         if(UnknownVarFromContextInfoView_Timer_1)
         {
            UnknownVarFromContextInfoView_Timer_1.removeEventListener("timerComplete",onTimerComplete);
            UnknownVarFromContextInfoView_Timer_1.reset();
            UnknownVarFromContextInfoView_Timer_1 = null;
         }
         _disposed = true;
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         UnknownVarFromContextInfoView_Boolean_4 = true;
         _fadeTime = 0;
         hide(true);
      }
      
      protected function addMouseClickListener(param1:IWindowModel, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.addEventListener("WME_CLICK",param2);
         }
      }
      
      protected function updateWindow() : void
      {
      }
      
      protected function clickHandler(param1:WindowMouseEvent) : void
      {
         UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_START_NAME_CHANGE"));
         UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.removeView(this,false);
      }
      
      public function setImageAsset(param1:IBitmapWrapperController, param2:String, param3:Boolean = false) : void
      {
         var _loc6_:Point = null;
         if(!param1 || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets)
         {
            return;
         }
         var _loc5_:BitmapDataAsset = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName(param2) as BitmapDataAsset;
         if(!_loc5_)
         {
            return;
         }
         var _loc4_:BitmapData = _loc5_.content as BitmapData;
         if(!_loc4_)
         {
            return;
         }
         if(param1.bitmap)
         {
            param1.bitmap.fillRect(param1.bitmap.rect,0);
         }
         else
         {
            param1.bitmap = new BitmapData(param1.width,param1.height,true,0);
         }
         if(param3)
         {
            _loc6_ = new Point((param1.bitmap.width - _loc4_.width) / 2,(param1.bitmap.height - _loc4_.height) / 2);
         }
         else
         {
            _loc6_ = new Point(0,0);
         }
         param1.bitmap.copyPixels(_loc4_,_loc4_.rect,_loc6_,null,null,true);
         param1.invalidate();
      }
      
      public function show() : void
      {
         if(UnknownVarFromContextInfoView_IWindowController_1_2 != null)
         {
            UnknownVarFromContextInfoView_IWindowController_1_2.visible = true;
            if(!(UnknownVarFromContextInfoView_IWindowController_1_2.parent is IDesktopController))
            {
               UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager.getDesktop(0).addChild(UnknownVarFromContextInfoView_IWindowController_1_2);
            }
            if(_forceActivateOnUpdate)
            {
               UnknownVarFromContextInfoView_IWindowController_1_2.activate();
            }
         }
      }
      
      public function hide(param1:Boolean) : void
      {
         if(UnknownVarFromContextInfoView_IWindowController_1_2 != null)
         {
            if(!UnknownVarFromContextInfoView_Boolean_3 && param1 && UnknownVarFromContextInfoView_Timer_1 != null)
            {
               UnknownVarFromContextInfoView_Boolean_3 = true;
               UnknownVarFromContextInfoView_Timer_1.start();
            }
            else
            {
               UnknownVarFromContextInfoView_IWindowController_1_2.visible = false;
               UnknownVarFromContextInfoView_IWindowController_1_2.parent = null;
            }
         }
      }
      
      protected function getOffset(param1:Rectangle) : int
      {
         var _loc2_:int = -UnknownVarFromContextInfoView_IWindowController_1_2.height;
         return _loc2_ - 4;
      }
      
      protected function getMaximumVerticalLead(param1:Rectangle) : int
      {
         return int(param1.height * 0.05);
      }
      
      public function update(param1:Rectangle, param2:Point, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:* = 0;
         if(!param1)
         {
            return;
         }
         if(!UnknownVarFromContextInfoView_IWindowController_1_2)
         {
            updateWindow();
         }
         if(UnknownVarFromContextInfoView_Boolean_4)
         {
            _fadeTime += param3;
            UnknownVarFromContextInfoView_Number_1 = (1 - _fadeTime / _fadeLength) * maximumBlend;
         }
         else
         {
            UnknownVarFromContextInfoView_Number_1 = maximumBlend;
         }
         if(UnknownVarFromContextInfoView_Number_1 <= 0)
         {
            UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.removeView(this,false);
            return;
         }
         if(!UnknownVarFromContextInfoView_Boolean_2 || _forcedPositionUpdate)
         {
            _loc4_ = getOffset(param1);
            _loc6_ = param2.y - param1.top;
            UnknownVarFromContextInfoView_FixedSizeStack_1.addValue(_loc6_);
            _loc7_ = UnknownVarFromContextInfoView_FixedSizeStack_1.getMax();
            if(_loc7_ < UnknownVarFromContextInfoView_Int_1 - 3)
            {
               _loc7_ = UnknownVarFromContextInfoView_Int_1 - 3;
            }
            _loc8_ = param2.y - _loc7_;
            UnknownVarFromContextInfoView_Int_1 = _loc7_;
            _loc10_ = param1.top + _loc4_;
            _loc5_ = _loc10_ - getMaximumVerticalLead(param1);
            _loc9_ = _loc8_ + _loc4_;
            if(_loc9_ < _loc5_)
            {
               _loc9_ = _loc5_;
            }
            UnknownVarFromContextInfoView_IWindowController_1_2.x = param2.x - UnknownVarFromContextInfoView_IWindowController_1_2.width / 2;
            UnknownVarFromContextInfoView_IWindowController_1_2.y = _loc9_;
            _forcedPositionUpdate = false;
         }
         UnknownVarFromContextInfoView_IWindowController_1_2.blend = UnknownVarFromContextInfoView_Number_1;
         show();
      }
      
      protected function onMouseHoverEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_OVER")
         {
            UnknownVarFromContextInfoView_Boolean_2 = true;
         }
         else if(param1.type == "WME_OUT")
         {
            if(!param1.window.hitTestGlobalPoint(new Point(param1.stageX,param1.stageY)))
            {
               UnknownVarFromContextInfoView_Boolean_2 = false;
            }
         }
      }
      
      protected function setMinimized(param1:Boolean) : void
      {
         UnknownVarFromContextInfoView_Boolean_1 = param1;
         _forcedPositionUpdate = true;
         updateWindow();
      }
      
      protected function getMinimizedView() : IWindowController_1
      {
         var _loc1_:XML = null;
         if(!UnknownVarFromContextInfoView_IWindowController_1_1)
         {
            _loc1_ = XmlAsset(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName("minimized_menu")).content as XML;
            UnknownVarFromContextInfoView_IWindowController_1_1 = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager.buildFromXML(_loc1_,0) as IWindowController_1;
            UnknownVarFromContextInfoView_IWindowController_1_1.findChildByName("minimize").addEventListener("WME_CLICK",onMaximize);
            UnknownVarFromContextInfoView_IWindowController_1_1.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
            UnknownVarFromContextInfoView_IWindowController_1_1.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            UnknownVarFromContextInfoView_IWindowController_1_1.addEventListener("WME_OVER",onMouseHoverEvent);
            UnknownVarFromContextInfoView_IWindowController_1_1.addEventListener("WME_OUT",onMouseHoverEvent);
         }
         return UnknownVarFromContextInfoView_IWindowController_1_1;
      }
      
      private function onMaximize(param1:WindowMouseEvent) : void
      {
         setMinimized(false);
      }
      
      protected function set activeView(param1:IWindowController_1) : void
      {
         if(!param1)
         {
            return;
         }
         if(UnknownVarFromContextInfoView_IWindowController_1_2)
         {
            UnknownVarFromContextInfoView_IWindowController_1_2.parent = null;
         }
         UnknownVarFromContextInfoView_IWindowController_1_2 = param1;
      }
      
      protected function onMinimize(param1:WindowMouseEvent) : void
      {
         setMinimized(true);
      }
      
      protected function onMinimizeHover(param1:WindowMouseEvent) : void
      {
         var _loc3_:IWindowModel = null;
         var _loc2_:IWindowController_1 = param1.window as IWindowController_1;
         if(_loc2_)
         {
            _loc3_ = _loc2_.findChildByName("icon");
            if(_loc3_)
            {
               if(param1.type == "WME_OVER")
               {
                  _loc3_.color = 4282950861;
               }
               else
               {
                  _loc3_.color = 16777215;
               }
            }
         }
      }
      
      public function set forceActivateOnUpdate(param1:Boolean) : void
      {
         _forceActivateOnUpdate = param1;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
   }
}


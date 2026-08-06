package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IInputEventTracker;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.RegionController;
   import com.sulake.core.window.enum.*;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.graphics.IWindowRenderer;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MouseEventProcessor implements IEventProcessor, IComponentInterfaceQueue
   {
      protected static var _mouseCursorTypes:Array;
      
      protected static var _mouseCursorStates:Array;
      
      protected static var GLOBAL_POINT:Point = new Point();
      
      protected var UnknownVarFromMouseEventProcessor_Point_1:Point;
      
      protected var UnknownVarFromMouseEventProcessor_WindowController_1:WindowController;
      
      protected var UnknownVarFromMouseEventProcessor_WindowController_2:WindowController;
      
      protected var UnknownVarFromMouseEventProcessor_WindowController_3:WindowController;
      
      protected var UnknownVarFromMouseEventProcessor_WindowController_4:WindowController;
      
      protected var UnknownVarFromMouseEventProcessor_IWindowRenderer_1:IWindowRenderer;
      
      protected var UnknownVarFromMouseEventProcessor_IDesktopController_1:IDesktopController;
      
      protected var _eventTrackers:Vector.<IInputEventTracker>;
      
      private var _disposed:Boolean = false;
      
      public function MouseEventProcessor()
      {
         super();
         UnknownVarFromMouseEventProcessor_Point_1 = new Point();
         if(_mouseCursorTypes == null)
         {
            _mouseCursorTypes = [];
            _mouseCursorTypes[0] = 2;
            _mouseCursorTypes[1] = 0;
            _mouseCursorTypes[2] = 2;
            _mouseCursorTypes[3] = 2;
            _mouseCursorTypes[4] = 2;
            _mouseCursorTypes[5] = 0;
            _mouseCursorTypes[6] = 2;
         }
         if(_mouseCursorStates == null)
         {
            _mouseCursorStates = [];
            _mouseCursorStates[0] = 1;
            _mouseCursorStates[1] = 2;
            _mouseCursorStates[2] = 4;
            _mouseCursorStates[3] = 64;
            _mouseCursorStates[4] = 8;
            _mouseCursorStates[5] = 16;
            _mouseCursorStates[6] = 32;
         }
      }
      
      public static function setMouseCursorByState(param1:uint, param2:uint) : void
      {
         var _loc3_:int = int(_mouseCursorStates.indexOf(param1));
         if(_loc3_ > -1)
         {
            _mouseCursorTypes[_loc3_] = param2;
         }
      }
      
      public static function getMouseCursorByState(param1:uint) : uint
      {
         var _loc2_:uint = _mouseCursorStates.length;
         while(_loc2_-- > 0)
         {
            if((param1 & _mouseCursorStates[_loc2_]) > 0)
            {
               return _mouseCursorTypes[_loc2_];
            }
         }
         return 0;
      }
      
      protected static function convertMouseEventType(param1:MouseEvent, param2:IWindowModel, param3:IWindowModel, param4:String = null) : WindowMouseEvent
      {
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc8_:Point = new Point(param1.stageX,param1.stageY);
         param2.convertPointFromGlobalToLocalSpace(_loc8_);
         var _loc5_:String;
         switch(_loc5_ = param4 == null ? param1.type : param4)
         {
            case "mouseMove":
               _loc6_ = "WME_MOVE";
               break;
            case "mouseOver":
               _loc6_ = "WME_OVER";
               break;
            case "mouseOut":
               _loc6_ = "WME_OUT";
               break;
            case "rollOut":
               _loc6_ = "WME_ROLL_OUT";
               break;
            case "rollOver":
               _loc6_ = "WME_ROLL_OVER";
               break;
            case "click":
               _loc6_ = "WME_CLICK";
               break;
            case "doubleClick":
               _loc6_ = "WME_DOUBLE_CLICK";
               break;
            case "mouseDown":
               _loc6_ = "WME_DOWN";
               break;
            case "mouseUp":
               _loc7_ = _loc8_.x > -1 && _loc8_.y > -1 && _loc8_.x < param2.width && _loc8_.y < param2.height;
               _loc6_ = _loc7_ ? "WME_UP" : "WME_UP_OUTSIDE";
               break;
            case "mouseWheel":
               _loc6_ = "WME_WHEEL";
               break;
            case "mouseWheelHorizontal":
               _loc6_ = "WME_WHEEL_HORIZONTAL";
               break;
            default:
               _loc6_ = "";
         }
         return WindowMouseEvent.allocate(_loc6_,param2,param3,_loc8_.x,_loc8_.y,param1.stageX,param1.stageY,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown,param1.delta);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
         }
      }
      
      public function process(param1:EventProcessorState, param2:IEventQueue) : void
      {
         var _loc5_:int = 0;
         var _loc12_:WindowController = null;
         var _loc7_:Array = null;
         var _loc11_:MouseEvent = null;
         var _loc9_:WindowEvent = null;
         var _loc10_:IWindowModel = null;
         var _loc6_:Boolean = false;
         var _loc8_:WindowMouseEvent = null;
         var _loc3_:IWindowModel = null;
         var _loc4_:IInteractiveWindow = null;
         if(param2.length == 0)
         {
            return;
         }
         UnknownVarFromMouseEventProcessor_IDesktopController_1 = param1.desktop;
         UnknownVarFromMouseEventProcessor_WindowController_4 = param1.UnknownVarFromEventProcessorState_IWindowModel_1 as WindowController;
         UnknownVarFromMouseEventProcessor_WindowController_1 = param1.lastClickTarget as WindowController;
         UnknownVarFromMouseEventProcessor_WindowController_2 = param1.lastMouseDownTarget as WindowController;
         UnknownVarFromMouseEventProcessor_WindowController_3 = param1.UnknownVarFromEventProcessorState_IWindowModel_2 as WindowController;
         UnknownVarFromMouseEventProcessor_IWindowRenderer_1 = param1.renderer;
         _eventTrackers = param1.eventTrackers;
         param2.begin();
         UnknownVarFromMouseEventProcessor_Point_1.x = -1;
         UnknownVarFromMouseEventProcessor_Point_1.y = -1;
         var _loc13_:int = 0;
         while(true)
         {
            _loc11_ = param2.next() as MouseEvent;
            if(_loc11_ == null)
            {
               break;
            }
            if(_loc11_.stageX != UnknownVarFromMouseEventProcessor_Point_1.x || _loc11_.stageY != UnknownVarFromMouseEventProcessor_Point_1.y)
            {
               UnknownVarFromMouseEventProcessor_Point_1.x = _loc11_.stageX;
               UnknownVarFromMouseEventProcessor_Point_1.y = _loc11_.stageY;
               _loc7_ = [];
               UnknownVarFromMouseEventProcessor_IDesktopController_1.groupParameterFilteredChildrenUnderPoint(UnknownVarFromMouseEventProcessor_Point_1,_loc7_,1);
            }
            _loc5_ = int(_loc7_ != null ? _loc7_.length : 0);
            if(_loc5_ == 0)
            {
               switch(_loc11_.type)
               {
                  case "mouseMove":
                     if(UnknownVarFromMouseEventProcessor_WindowController_4 != UnknownVarFromMouseEventProcessor_IDesktopController_1 && !UnknownVarFromMouseEventProcessor_WindowController_4.disposed)
                     {
                        UnknownVarFromMouseEventProcessor_WindowController_4.getGlobalPosition(GLOBAL_POINT);
                        _loc9_ = WindowMouseEvent.allocate("WME_OUT",UnknownVarFromMouseEventProcessor_WindowController_4,null,_loc11_.stageX - GLOBAL_POINT.x,_loc11_.stageY - GLOBAL_POINT.y,_loc11_.stageX,_loc11_.stageY,_loc11_.altKey,_loc11_.ctrlKey,_loc11_.shiftKey,_loc11_.buttonDown,_loc11_.delta);
                        UnknownVarFromMouseEventProcessor_WindowController_4.update(UnknownVarFromMouseEventProcessor_WindowController_4,_loc9_);
                        UnknownVarFromMouseEventProcessor_WindowController_4 = WindowController(UnknownVarFromMouseEventProcessor_IDesktopController_1);
                        _loc9_.recycle();
                     }
                     break;
                  case "mouseDown":
                     _loc10_ = UnknownVarFromMouseEventProcessor_IDesktopController_1.getActiveWindow();
                     if(_loc10_)
                     {
                        _loc10_.deactivate();
                     }
               }
            }
            if(_loc11_.type == "mouseUp" && UnknownVarFromMouseEventProcessor_WindowController_2 != null && _loc7_.indexOf(UnknownVarFromMouseEventProcessor_WindowController_2) == -1)
            {
               if(_loc7_ == null)
               {
                  _loc7_ = [];
               }
               _loc7_.push(UnknownVarFromMouseEventProcessor_WindowController_2);
               _loc5_++;
            }
            _loc6_ = false;
            while(true)
            {
               _loc5_--;
               if(_loc5_ <= -1)
               {
                  break;
               }
               _loc12_ = passMouseEvent(WindowController(_loc7_[_loc5_]),_loc11_);
               if(_loc12_ != null && _loc12_.visible)
               {
                  if(_loc11_.type == "mouseMove")
                  {
                     if(_loc12_ != UnknownVarFromMouseEventProcessor_WindowController_4)
                     {
                        if(!UnknownVarFromMouseEventProcessor_WindowController_4.disposed)
                        {
                           UnknownVarFromMouseEventProcessor_WindowController_4.getGlobalPosition(GLOBAL_POINT);
                           _loc9_ = WindowMouseEvent.allocate("WME_OUT",UnknownVarFromMouseEventProcessor_WindowController_4,_loc12_,_loc11_.stageX - GLOBAL_POINT.x,_loc11_.stageY - GLOBAL_POINT.y,_loc11_.stageX,_loc11_.stageY,_loc11_.altKey,_loc11_.ctrlKey,_loc11_.shiftKey,_loc11_.buttonDown,_loc11_.delta);
                           UnknownVarFromMouseEventProcessor_WindowController_4.update(UnknownVarFromMouseEventProcessor_WindowController_4,_loc9_);
                           _loc9_.recycle();
                        }
                        if(!_loc12_.disposed)
                        {
                           _loc12_.getGlobalPosition(GLOBAL_POINT);
                           _loc9_ = WindowMouseEvent.allocate("WME_OVER",_loc12_,null,_loc11_.stageX - GLOBAL_POINT.x,_loc11_.stageY - GLOBAL_POINT.y,_loc11_.stageX,_loc11_.stageY,_loc11_.altKey,_loc11_.ctrlKey,_loc11_.shiftKey,_loc11_.buttonDown,_loc11_.delta);
                           _loc12_.update(_loc12_,_loc9_);
                           _loc9_.recycle();
                        }
                        if(!_loc12_.disposed)
                        {
                           UnknownVarFromMouseEventProcessor_WindowController_4 = _loc12_;
                        }
                     }
                  }
                  if(_loc11_.type == "mouseDown")
                  {
                     if(UnknownVarFromMouseEventProcessor_WindowController_3 != null && !UnknownVarFromMouseEventProcessor_WindowController_3.disposed && _loc12_ != UnknownVarFromMouseEventProcessor_WindowController_3)
                     {
                        _loc8_ = WindowMouseEvent.allocate("WME_CLICK_AWAY",UnknownVarFromMouseEventProcessor_WindowController_3,_loc12_,NaN,NaN,_loc11_.stageX,_loc11_.stageY,_loc11_.altKey,_loc11_.ctrlKey,_loc11_.shiftKey,_loc11_.buttonDown,_loc11_.delta);
                        UnknownVarFromMouseEventProcessor_WindowController_3.update(UnknownVarFromMouseEventProcessor_WindowController_3,_loc8_);
                        _loc8_.recycle();
                     }
                     UnknownVarFromMouseEventProcessor_WindowController_3 = _loc12_;
                  }
                  if(!_loc6_)
                  {
                     _loc3_ = _loc12_.parent;
                     while(_loc6_ && _loc3_ && !_loc3_.disposed)
                     {
                        if(_loc3_ is IInputProcessorRoot)
                        {
                           _loc9_ = convertMouseEventType(_loc11_,_loc3_,_loc12_);
                           _loc6_ = Boolean(IInputProcessorRoot(_loc3_).process(_loc9_));
                           _loc9_.recycle();
                        }
                        _loc3_ = _loc3_.parent;
                     }
                  }
                  if(UnknownVarFromMouseEventProcessor_WindowController_4 is IInteractiveWindow)
                  {
                     _loc4_ = IInteractiveWindow(UnknownVarFromMouseEventProcessor_WindowController_4);
                     if(_loc4_.interactiveCursorDisabled)
                     {
                        _loc13_ = 0;
                        addr505:
                     }
                     else
                     {
                        _loc13_ = int(_loc4_.getMouseCursorByState(UnknownVarFromMouseEventProcessor_WindowController_4.state));
                        if(_loc13_ == 0)
                        {
                           _loc13_ = int(getMouseCursorByState(UnknownVarFromMouseEventProcessor_WindowController_4.state));
                        }
                        §§goto(addr505);
                     }
                     e = §§pop();
                     _loc13_ = 0;
                  }
                  if(_loc12_ != UnknownVarFromMouseEventProcessor_IDesktopController_1)
                  {
                     _loc11_.stopPropagation();
                     param2.remove();
                  }
                  break;
               }
            }
         }
         param2.end();
         MouseCursorControl.type = _loc13_;
         param1.desktop = UnknownVarFromMouseEventProcessor_IDesktopController_1;
         param1.UnknownVarFromEventProcessorState_IWindowModel_1 = UnknownVarFromMouseEventProcessor_WindowController_4;
         param1.lastClickTarget = UnknownVarFromMouseEventProcessor_WindowController_1;
         param1.lastMouseDownTarget = UnknownVarFromMouseEventProcessor_WindowController_2;
         param1.UnknownVarFromEventProcessorState_IWindowModel_2 = UnknownVarFromMouseEventProcessor_WindowController_3;
         param1.renderer = UnknownVarFromMouseEventProcessor_IWindowRenderer_1;
         param1.eventTrackers = _eventTrackers;
      }
      
      private function passMouseEvent(param1:WindowController, param2:MouseEvent, param3:Boolean = false) : WindowController
      {
         var _loc9_:BitmapData = null;
         var _loc6_:WindowMouseEvent = null;
         if(param1.disposed)
         {
            return null;
         }
         if(param1.testStateFlag(32) && param2.type == "mouseMove" && param1 is RegionController)
         {
            return param1;
         }
         if(param1.testStateFlag(32))
         {
            return null;
         }
         var _loc7_:* = false;
         var _loc12_:Point = new Point(param2.stageX,param2.stageY);
         param1.convertPointFromGlobalToLocalSpace(_loc12_);
         if(param2.type == "mouseUp")
         {
            if(UnknownVarFromMouseEventProcessor_WindowController_2 == null)
            {
               UnknownVarFromMouseEventProcessor_WindowController_1 = null;
               return null;
            }
            if(param1 != UnknownVarFromMouseEventProcessor_WindowController_2)
            {
               if(UnknownVarFromMouseEventProcessor_WindowController_2 && !UnknownVarFromMouseEventProcessor_WindowController_2.disposed)
               {
                  UnknownVarFromMouseEventProcessor_WindowController_2.update(UnknownVarFromMouseEventProcessor_WindowController_2,convertMouseEventType(new MouseEvent("mouseUp",false,true,param2.localX,param2.localY,null,param2.ctrlKey,param2.altKey,param2.shiftKey,param2.buttonDown,param2.delta),UnknownVarFromMouseEventProcessor_WindowController_2,param1));
                  UnknownVarFromMouseEventProcessor_WindowController_1 = null;
                  if(param1.disposed)
                  {
                     return null;
                  }
               }
            }
            else
            {
               _loc7_ = !param1.hitTestLocalPoint(_loc12_);
            }
            UnknownVarFromMouseEventProcessor_WindowController_2 = null;
         }
         if(!_loc7_)
         {
            if(param1.ignoreMouseEvents)
            {
               return null;
            }
            _loc9_ = UnknownVarFromMouseEventProcessor_IWindowRenderer_1.getDrawBufferForRenderable(param1);
            if(!param1.validateLocalPointIntersection(_loc12_,_loc9_))
            {
               return null;
            }
         }
         if(param1.testParamFlag(3))
         {
            if(param1.parent != null)
            {
               return passMouseEvent(WindowController(param1.parent),param2);
            }
         }
         if(!param3)
         {
            switch(param2.type)
            {
               case "mouseDown":
                  UnknownVarFromMouseEventProcessor_WindowController_1 = param1;
                  UnknownVarFromMouseEventProcessor_WindowController_2 = param1;
                  break;
               case "click":
                  if(UnknownVarFromMouseEventProcessor_WindowController_1 != param1)
                  {
                     UnknownVarFromMouseEventProcessor_WindowController_1 = null;
                     return null;
                  }
                  UnknownVarFromMouseEventProcessor_WindowController_1 = null;
                  break;
               case "doubleClick":
                  if(UnknownVarFromMouseEventProcessor_WindowController_1 != param1)
                  {
                     UnknownVarFromMouseEventProcessor_WindowController_1 = null;
                     return null;
                  }
                  UnknownVarFromMouseEventProcessor_WindowController_1 = null;
                  break;
            }
         }
         var _loc5_:IWindowModel = null;
         var _loc11_:Array = [];
         if(param2.type == "doubleClick")
         {
            _loc11_.push("click");
         }
         _loc11_.push(param2.type);
         var _loc4_:Boolean = false;
         for each(var _loc10_ in _loc11_)
         {
            _loc6_ = convertMouseEventType(param2,param1,_loc5_,_loc10_);
            if(param1.update(param1,_loc6_))
            {
               _loc4_ = true;
            }
            for each(var _loc8_ in _eventTrackers)
            {
               _loc8_.eventReceived(_loc6_,param1);
            }
            _loc6_.recycle();
         }
         if(!_loc4_ && !param3)
         {
            if(param1.parent)
            {
               return passMouseEvent(WindowController(param1.parent),param2);
            }
         }
         return param1;
      }
   }
}


package com.sulake.core.window.services
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IToolTipWindow;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class WindowToolTipAgent extends WindowMouseOperator implements IToolTipAgentService
   {
      protected var UnknownVarFromWindowToolTipAgent_String_1:String;
      
      protected var UnknownVarFromWindowToolTipAgent_IToolTipWindow_1:IToolTipWindow;
      
      protected var UnknownVarFromWindowToolTipAgent_Timer_1:Timer;
      
      protected var UnknownVarFromWindowToolTipAgent_Point_1:Point = new Point(20,20);
      
      protected var UnknownVarFromWindowToolTipAgent_Point_2:Point = new Point();
      
      protected var UnknownVarFromWindowToolTipAgent_Uint_1:uint = 500;
      
      public function WindowToolTipAgent(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function begin(param1:IWindowModel, param2:uint = 0) : IWindowModel
      {
         if(param1 && !param1.disposed)
         {
            if(param1 is IInteractiveWindow)
            {
               UnknownVarFromWindowToolTipAgent_String_1 = IInteractiveWindow(param1).toolTipCaption;
               UnknownVarFromWindowToolTipAgent_Uint_1 = IInteractiveWindow(param1).toolTipDelay;
            }
            else
            {
               UnknownVarFromWindowToolTipAgent_String_1 = param1.caption;
               UnknownVarFromWindowToolTipAgent_Uint_1 = 500;
            }
            _mouse.x = UnknownVarFromWindowMouseOperator_DisplayObject_1.mouseX;
            _mouse.y = UnknownVarFromWindowMouseOperator_DisplayObject_1.mouseY;
            getMousePositionRelativeTo(param1,_mouse,UnknownVarFromWindowToolTipAgent_Point_2);
            if(UnknownVarFromWindowToolTipAgent_Timer_1 == null)
            {
               UnknownVarFromWindowToolTipAgent_Timer_1 = new Timer(UnknownVarFromWindowToolTipAgent_Uint_1,1);
               UnknownVarFromWindowToolTipAgent_Timer_1.addEventListener("timer",showToolTip);
            }
            UnknownVarFromWindowToolTipAgent_Timer_1.reset();
            UnknownVarFromWindowToolTipAgent_Timer_1.start();
         }
         return super.begin(param1,param2);
      }
      
      override public function end(param1:IWindowModel) : IWindowModel
      {
         if(UnknownVarFromWindowToolTipAgent_Timer_1 != null)
         {
            UnknownVarFromWindowToolTipAgent_Timer_1.stop();
            UnknownVarFromWindowToolTipAgent_Timer_1.removeEventListener("timer",showToolTip);
            UnknownVarFromWindowToolTipAgent_Timer_1 = null;
         }
         hideToolTip();
         return super.end(param1);
      }
      
      override public function operate(param1:int, param2:int) : void
      {
         if(_window && !_window.disposed)
         {
            _mouse.x = param1;
            _mouse.y = param2;
            getMousePositionRelativeTo(_window,_mouse,UnknownVarFromWindowToolTipAgent_Point_2);
            if(UnknownVarFromWindowToolTipAgent_IToolTipWindow_1 != null && !UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.disposed)
            {
               UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.x = param1 + UnknownVarFromWindowToolTipAgent_Point_1.x;
               UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.y = param2 + UnknownVarFromWindowToolTipAgent_Point_1.y;
            }
         }
      }
      
      protected function showToolTip(param1:TimerEvent) : void
      {
         var _loc2_:Point = null;
         if(UnknownVarFromWindowToolTipAgent_Timer_1 != null)
         {
            UnknownVarFromWindowToolTipAgent_Timer_1.reset();
         }
         if(_window && !_window.disposed)
         {
            if(_window is IInteractiveWindow)
            {
               UnknownVarFromWindowToolTipAgent_String_1 = IInteractiveWindow(_window).toolTipCaption;
            }
            else
            {
               UnknownVarFromWindowToolTipAgent_String_1 = _window.caption;
            }
            if(UnknownVarFromWindowToolTipAgent_IToolTipWindow_1 == null || Boolean(UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.disposed))
            {
               UnknownVarFromWindowToolTipAgent_IToolTipWindow_1 = _window.context.create(_window.name + "::ToolTip",UnknownVarFromWindowToolTipAgent_String_1,8,_window.style,0x20 | 0,null,null,null,0,null,null) as IToolTipWindow;
            }
            _loc2_ = new Point();
            _window.getGlobalPosition(_loc2_);
            UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.x = _loc2_.x + UnknownVarFromWindowToolTipAgent_Point_2.x + UnknownVarFromWindowToolTipAgent_Point_1.x;
            UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.y = _loc2_.y + UnknownVarFromWindowToolTipAgent_Point_2.y + UnknownVarFromWindowToolTipAgent_Point_1.y;
            UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.visible = UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.caption.length > 0;
         }
      }
      
      protected function hideToolTip() : void
      {
         if(UnknownVarFromWindowToolTipAgent_IToolTipWindow_1 != null && !UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.disposed)
         {
            UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.destroy();
            UnknownVarFromWindowToolTipAgent_IToolTipWindow_1 = null;
         }
      }
      
      public function updateCaption(param1:IWindowModel) : void
      {
         var _loc2_:String = null;
         if(param1 == null || Boolean(param1.disposed) || UnknownVarFromWindowToolTipAgent_IToolTipWindow_1 == null || Boolean(UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.disposed))
         {
            return;
         }
         if(param1 is IInteractiveWindow)
         {
            _loc2_ = IInteractiveWindow(param1).toolTipCaption;
         }
         else
         {
            _loc2_ = param1.caption;
         }
         if(_loc2_ != UnknownVarFromWindowToolTipAgent_String_1)
         {
            UnknownVarFromWindowToolTipAgent_String_1 = _loc2_;
            if(_loc2_ == null || _loc2_.length == 0)
            {
               UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.visible = false;
            }
            else
            {
               UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.caption = _loc2_;
               UnknownVarFromWindowToolTipAgent_IToolTipWindow_1.visible = true;
            }
         }
      }
   }
}


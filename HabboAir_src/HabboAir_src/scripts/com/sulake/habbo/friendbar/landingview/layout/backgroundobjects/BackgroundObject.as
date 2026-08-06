package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import flash.events.EventDispatcher;
   
   public class BackgroundObject implements IComponentInterfaceQueue, IProfiler_1
   {
      private var _id:int;
      
      private var _window:IWindowModel;
      
      private var _events:EventDispatcher;
      
      private var _sprite:IStaticBitmapWrapperWindow;
      
      public function BackgroundObject(param1:int, param2:IWindowController_1, param3:EventDispatcher, param4:HabboLandingView, param5:String, param6:Boolean = false)
      {
         super();
         _id = param1;
         _window = param2;
         _events = param3;
         if(param6)
         {
            _sprite = IStaticBitmapWrapperWindow(param4.getXmlWindow("moving_object"));
         }
         else
         {
            _sprite = IStaticBitmapWrapperWindow(param4.getXmlWindow("moving_object_floating"));
         }
         param2.addChild(_sprite);
      }
      
      public function dispose() : void
      {
         _window = null;
         _sprite = null;
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function set sprite(param1:IStaticBitmapWrapperWindow) : void
      {
         _sprite = param1;
      }
      
      public function get sprite() : IStaticBitmapWrapperWindow
      {
         return _sprite;
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
      
      public function set window(param1:IWindowModel) : void
      {
         _window = param1;
      }
      
      public function get events() : EventDispatcher
      {
         return _events;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function update(param1:uint) : void
      {
         if(!_sprite)
         {
            return;
         }
      }
   }
}


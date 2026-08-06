package com.sulake.habbo.moderation.new_mod_tool_tabs
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.moderation.NewModerationTool;
   
   [SecureSWF(rename="true")]
   public class AbstractModToolTab implements IComponentInterfaceQueue
   {
      private var _tool:NewModerationTool;
      
      private var _window:IWindowController_1;
      
      private var _visible:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function AbstractModToolTab(param1:NewModerationTool, param2:IWindowController_1)
      {
         super();
         _tool = param1;
         _window = param2;
         param2.visible = false;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(_visible != param1)
         {
            _visible = param1;
            _window.visible = param1;
         }
      }
      
      public function get tool() : NewModerationTool
      {
         return _tool;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function onOpen() : void
      {
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _window = null;
         _tool = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}


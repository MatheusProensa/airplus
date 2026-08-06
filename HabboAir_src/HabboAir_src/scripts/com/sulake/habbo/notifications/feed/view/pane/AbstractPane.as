package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.notifications.feed.NotificationView;
   
   public class AbstractPane implements IAbstractPane
   {
      public static const PANE_VIEW_LEVEL_BASE:int = 0;
      
      public static const PANE_VIEW_LEVEL_FEED:int = 1;
      
      public static const PANE_VIEW_LEVEL_MODAL:int = 2;
      
      protected var _disposed:Boolean;
      
      protected var _isVisible:Boolean;
      
      private var _paneLevel:int;
      
      protected var _window:IWindowController_1;
      
      protected var UnknownVarFromAbstractPane_NotificationView_1:NotificationView;
      
      protected var _name:String;
      
      public function AbstractPane(param1:String, param2:NotificationView, param3:IWindowController_1, param4:int)
      {
         super();
         if(param3 == null)
         {
            throw new Exception("Window was null for feed pane: " + param1);
         }
         _name = param1;
         UnknownVarFromAbstractPane_NotificationView_1 = param2;
         _paneLevel = param4;
         _window = param3;
      }
      
      public function dispose() : void
      {
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get paneLevel() : int
      {
         return _paneLevel;
      }
      
      public function set isVisible(param1:Boolean) : void
      {
         _isVisible = param1;
         _window.visible = _isVisible;
      }
      
      public function get isVisible() : Boolean
      {
         return _isVisible;
      }
   }
}


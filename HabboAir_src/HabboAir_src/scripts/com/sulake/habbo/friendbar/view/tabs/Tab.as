package com.sulake.habbo.friendbar.view.tabs
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.friendbar.data.IHabboFriendBarData;
   import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
   import com.sulake.habbo.friendbar.view.utils.TextCropper;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.game.IHabboGameManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.geom.Point;
   
   public class Tab implements ITab
   {
      public static var WIDTH:int = 127;
      
      public static var HEIGHT:int = 36;
      
      public static var DATA:IHabboFriendBarData;
      
      public static var FRIENDS:IHabboFriendList;
      
      public static var GAMES:IHabboGameManager;
      
      public static var VIEW:IHabboFriendBarView;
      
      public static var ASSETS:IAssetLibraryCollection;
      
      public static var WINDOWING:IHabboWindowManagerComponent;
      
      public static var UnknownVarFromTab_IHabboLocalizationManager_1:IHabboLocalizationManager;
      
      public static var TRACKING:IHabboTracking;
      
      public static var CROPPER:TextCropper;
      
      public static var AVATAR_RENDER_MANAGER:IAvatarRenderManager;
      
      protected static const UnknownConstFromTab_Boolean_1:Boolean = false;
      
      protected static const _MOTION_TIME:int = 80;
      
      protected static const UnknownConstFromTab_Int_1:int = 3;
      
      protected var _window:IWindowController_1;
      
      protected var _recycled:Boolean;
      
      private var _exposed:Boolean;
      
      private var _selected:Boolean;
      
      private var _disposed:Boolean;
      
      public function Tab()
      {
         super();
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get recycled() : Boolean
      {
         return _recycled;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      protected function get exposed() : Boolean
      {
         return _exposed;
      }
      
      public function select(param1:Boolean) : void
      {
         conceal();
         _selected = true;
      }
      
      public function deselect(param1:Boolean) : void
      {
         _selected = false;
      }
      
      public function recycle() : void
      {
         conceal();
         _recycled = true;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            _disposed = true;
         }
      }
      
      protected function expose() : void
      {
         _exposed = true;
      }
      
      protected function conceal() : void
      {
         _exposed = false;
      }
      
      protected function onMouseClick(param1:WindowMouseEvent) : void
      {
         if(disposed || recycled)
         {
            return;
         }
         if(selected)
         {
            VIEW.deSelect(true);
         }
         else
         {
            VIEW.selectTab(this,true);
         }
      }
      
      protected function onMouseOver(param1:WindowMouseEvent) : void
      {
         if(disposed || recycled)
         {
            return;
         }
         if(!selected)
         {
            expose();
         }
      }
      
      protected function onMouseOut(param1:WindowMouseEvent) : void
      {
         if(disposed || recycled || _window == null)
         {
            return;
         }
         if(!selected)
         {
            if(!_window.hitTestGlobalPoint(new Point(param1.stageX,param1.stageY)))
            {
               conceal();
            }
         }
      }
   }
}


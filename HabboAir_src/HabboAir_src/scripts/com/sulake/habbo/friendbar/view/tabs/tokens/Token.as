package com.sulake.habbo.friendbar.view.tabs.tokens
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.motion.DropBounce;
   import com.sulake.core.window.motion.Motions;
   import com.sulake.habbo.friendbar.data.IFriendNotification;
   import com.sulake.habbo.game.IHabboGameManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.geom.Rectangle;
   
   public class Token implements IComponentInterfaceQueue
   {
      protected static var _WINDOW_MANAGER:IHabboWindowManagerComponent;
      
      protected static var UnknownVarFromToken_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      protected static var _GAMES:IHabboGameManager;
      
      protected static const TITLE:String = "title";
      
      protected static const MESSAGE:String = "message";
      
      protected static const ICON_RECTANGLE:Rectangle = new Rectangle(0,0,25,25);
      
      protected var _icon:IRegionWindow;
      
      protected var _window:IWindowController_1;
      
      protected var _disposed:Boolean;
      
      protected var _notification:IFriendNotification;
      
      public function Token(param1:IFriendNotification)
      {
         super();
         _notification = param1;
      }
      
      public static function set WINDOWING(param1:IHabboWindowManagerComponent) : void
      {
         _WINDOW_MANAGER = param1;
      }
      
      public static function set ASSETS(param1:IAssetLibraryCollection) : void
      {
         UnknownVarFromToken_IAssetLibraryCollection_1 = param1;
      }
      
      public static function set GAMES(param1:IHabboGameManager) : void
      {
         _GAMES = param1;
      }
      
      public function get typeCode() : int
      {
         return _notification.typeCode;
      }
      
      public function get viewOnce() : Boolean
      {
         return _notification.viewOnce;
      }
      
      public function get notification() : IFriendNotification
      {
         return _notification;
      }
      
      public function get iconElement() : IWindowModel
      {
         return _icon;
      }
      
      public function get windowElement() : IWindowModel
      {
         return _window;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(_icon)
         {
            _icon.dispose();
            _icon = null;
         }
         _notification = null;
         _disposed = true;
      }
      
      protected function prepare(param1:String, param2:String, param3:String, param4:String) : void
      {
         _window = _WINDOW_MANAGER.buildFromXML(UnknownVarFromToken_IAssetLibraryCollection_1.getAssetByName(param3).content as XML) as IWindowController_1;
         _window.findChildByName("title").caption = param1;
         _window.findChildByName("message").caption = !!param2 ? param2 : "";
         _icon = _WINDOW_MANAGER.create("ICON_" + typeCode,5,0,1,Token.ICON_RECTANGLE) as IRegionWindow;
         _icon.mouseThreshold = 0;
         var _loc5_:IStaticBitmapWrapperWindow = _WINDOW_MANAGER.create("BITMAP_" + typeCode,23,0,0,Token.ICON_RECTANGLE) as IStaticBitmapWrapperWindow;
         _loc5_.assetUri = param4;
         _icon.addChild(_loc5_);
         if(Motions.getMotionByTarget(_icon) == null)
         {
            Motions.runMotion(new DropBounce(_icon,600,32));
         }
      }
   }
}


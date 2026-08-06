package com.sulake.habbo.ui.widget.furniture.placeholder
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.geom.Rectangle;
   
   public class PlaceholderView
   {
      private var UnknownVarFromPlaceholderView_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _window:IWindowController_1;
      
      public function PlaceholderView(param1:IAssetLibraryCollection, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromPlaceholderView_IAssetLibraryCollection_1 = param1;
         _windowManager = param2;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function toggleWindow() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            hideWindow();
         }
         else
         {
            showWindow();
         }
      }
      
      public function showWindow() : void
      {
         if(_window == null)
         {
            createWindow();
         }
         if(_window == null)
         {
            return;
         }
         _window.visible = true;
         _window.x = 200;
      }
      
      private function createWindow() : void
      {
         var _loc2_:XmlAsset = UnknownVarFromPlaceholderView_IAssetLibraryCollection_1.getAssetByName("placeholder") as XmlAsset;
         if(_loc2_ == null || _loc2_.content == null)
         {
            return;
         }
         _window = _windowManager.createWindow("habbohelp_window","",4,0,131072 | 1,new Rectangle(-300,300,10,10),null) as IWindowController_1;
         _window.buildFromXML(_loc2_.content as XML);
         _window.tags.push("habbo_help_window");
         _window.background = true;
         _window.color = 33554431;
         var _loc1_:IWindowModel = _window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.procedure = onWindowClose;
         }
      }
      
      public function hideWindow() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideWindow();
      }
   }
}


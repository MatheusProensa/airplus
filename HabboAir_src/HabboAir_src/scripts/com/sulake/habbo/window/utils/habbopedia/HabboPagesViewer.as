package com.sulake.habbo.window.utils.habbopedia
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.HTMLTextController;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.text.StyleSheet;
   import flash.utils.ByteArray;
   
   public class HabboPagesViewer implements ILinkEventTracker
   {
      public static var habbopedia_window_layout:Class = habbopedia_1_xml;
      
      public static var habbopedia_edit_layout:Class = habbopedia_edit_1_xml;
      
      public static var habbopedia_css:Class = habbopedia_1_css;
      
      public static var styleSheet:StyleSheet = createStyleSheet();
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var _window:IWindowController_1;
      
      public function HabboPagesViewer(param1:HabboWindowManagerComponent)
      {
         super();
         _windowManager = param1;
         _windowManager.context.addLinkEventTracker(this);
         createStyleSheet();
      }
      
      private static function createStyleSheet() : StyleSheet
      {
         var _loc2_:StyleSheet = new StyleSheet();
         var _loc3_:ByteArray = new habbopedia_css() as ByteArray;
         var _loc1_:String = _loc3_.readUTFBytes(_loc3_.length);
         _loc2_.parseCSS(_loc1_);
         return _loc2_;
      }
      
      private function set visible(param1:Boolean) : void
      {
         if(_window == null || Boolean(_window.disposed))
         {
            _window = createWindow(habbopedia_window_layout,windowProcedure);
            (_window.findChildByName("content") as ITextWindow).styleSheet = styleSheet;
            (_window.findChildByName("content") as ITextWindow).addEventListener("WE_CHANGE",onChanged);
         }
         _window.visible = param1;
      }
      
      private function onChanged(param1:WindowEvent) : void
      {
         (_window.findChildByName("scroller") as IScrollbarWindow).scrollV = 0;
      }
      
      private function get visible() : Boolean
      {
         return _window != null && Boolean(_window.visible);
      }
      
      private function createWindow(param1:Class, param2:Function) : IWindowController_1
      {
         var _loc3_:ByteArray = new param1() as ByteArray;
         var _loc4_:XML = new XML(_loc3_.readUTFBytes(_loc3_.length));
         var _loc5_:IWindowController_1 = _windowManager.buildFromXML(_loc4_) as IWindowController_1;
         _loc5_.procedure = param2;
         return _loc5_;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               visible = false;
               break;
            case "close":
               _window.visible = false;
         }
      }
      
      private function parseAndSetHtml(param1:String, param2:String) : void
      {
         _window.caption = param2;
         (_window.findChildByName("content") as HTMLTextController).htmlText = param1;
         (_window.findChildByName("content") as ITextWindow).styleSheet = styleSheet;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _windowManager = null;
      }
      
      public function get disposed() : Boolean
      {
         return _windowManager == null;
      }
      
      public function get linkPattern() : String
      {
         return "habbopages/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         _loc2_.shift();
         var _loc3_:String = _loc2_.join("/");
         openPage(_loc3_);
      }
      
      public function openPage(param1:String) : void
      {
         var _loc4_:* = null;
         _loc4_ = this._windowManager.LilithCustomsInstance.OnHabboPageOpen(param1);
         if(_loc4_ != "")
         {
            this.LoadFromString(_loc4_);
            return;
         }
         var _loc2_:String = _windowManager.getProperty("habbopages.url");
         var _loc5_:String = _loc2_ + param1;
         if(_windowManager.assets.hasAsset(_loc5_))
         {
            Logger.log("[HabboPagesViewer] reload page: " + _loc5_);
            _windowManager.assets.removeAsset(_windowManager.assets.getAssetByName(_loc5_));
         }
         var _loc3_:URLRequest = new URLRequest(_loc2_ + param1);
         _loc4_ = _windowManager.assets.loadAssetFromFile(_loc5_,_loc3_,"text/plain");
         _loc4_.addEventListener("AssetLoaderEventComplete",onDownloadComplete);
         _loc4_.addEventListener("AssetLoaderEventError",onDownloadError);
      }
      
      private function onDownloadError(param1:Event = null) : void
      {
         var _loc3_:AssetLoaderEvent = param1 as AssetLoaderEvent;
         var _loc2_:int = 0;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.status;
         }
         HabboWebTools.logEventLog("habbopages download error " + _loc2_);
      }
      
      private function onDownloadComplete(param1:Event = null) : void
      {
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc5_:String = null;
         var _loc4_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:RegExp = /\n\r|\n|\r/gm;
         var _loc3_:String = _loc4_.assetLoader.content as String;
         if(_loc3_ != null)
         {
            _loc6_ = _loc3_.split(_loc2_);
            _loc7_ = _loc6_.shift();
            _loc5_ = _loc6_.join("");
            visible = true;
            parseAndSetHtml(_loc5_,_loc7_);
            _window.activate();
         }
      }
      
      public function LoadFromString(param1:String) : void
      {
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc5_:String = null;
         var _loc2_:RegExp = /\n\r|\n|\r/gm;
         var _loc3_:* = param1;
         if(_loc3_ != null)
         {
            _loc6_ = _loc3_.split(_loc2_);
            _loc7_ = _loc6_.shift();
            _loc5_ = _loc6_.join("");
            visible = true;
            parseAndSetHtml(_loc5_,_loc7_);
            _window.activate();
         }
      }
   }
}


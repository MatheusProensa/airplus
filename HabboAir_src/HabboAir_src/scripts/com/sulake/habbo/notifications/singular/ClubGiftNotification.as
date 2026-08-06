package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class ClubGiftNotification
   {
      private static const TOOLBAR_EXTENSION_ID:String = "club_gift_notification";
      
      private static const LINK_COLOR_NORMAL:uint = 16777215;
      
      private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;
      
      private static const ICON_STYLE_CLUB:int = 13;
      
      private static const ICON_STYLE_VIP:int = 14;
      
      private var _window:UnknownICoreWindowComponents6;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolbar:IHabboToolbar;
      
      private var UnknownVarFromClubGiftNotification_ITextWindow_1:ITextWindow;
      
      private var _isCancelled:Boolean = false;
      
      public function ClubGiftNotification(param1:int, param2:IAssetLibraryCollection, param3:IHabboWindowManagerComponent, param4:IHabboCatalog, param5:IHabboToolbar)
      {
         super();
         if(!param2 || !param3 || !param4)
         {
            return;
         }
         _catalog = param4;
         _toolbar = param5;
         var _loc6_:XmlAsset = param2.getAssetByName("club_gift_notification_xml") as XmlAsset;
         if(_loc6_ == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc6_.content as XML) as UnknownICoreWindowComponents6;
         if(_window == null)
         {
            return;
         }
         _window.procedure = eventHandler;
         _toolbar.extensionView.attachExtension("club_gift_notification",_window);
         UnknownVarFromClubGiftNotification_ITextWindow_1 = _window.findChildByName("cancel_link") as ITextWindow;
         var _loc7_:IRegionWindow = _window.findChildByName("cancel_link_region") as IRegionWindow;
         if(_loc7_)
         {
            _loc7_.addEventListener("WME_OVER",onMouseOver);
            _loc7_.addEventListener("WME_OUT",onMouseOut);
         }
         setClubIcon(13);
      }
      
      public function get visible() : Boolean
      {
         return _window && _window.visible;
      }
      
      public function get isCancelled() : Boolean
      {
         return _isCancelled;
      }
      
      public function dispose() : void
      {
         if(_toolbar)
         {
            _toolbar.extensionView.detachExtension("club_gift_notification");
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _catalog = null;
      }
      
      private function setImage(param1:String, param2:BitmapData) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:IBitmapWrapperController = _window.findChildByName(param1) as IBitmapWrapperController;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         var _loc5_:int = _loc4_.width * 0.5 - param2.width;
         var _loc6_:int = _loc4_.height * 0.5 - param2.height;
         _loc4_.draw(param2,new Matrix(2,0,0,2,_loc5_,_loc6_));
         _loc3_.bitmap = _loc4_;
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "open_catalog_button":
               if(_catalog)
               {
                  _catalog.openCatalogPage("club_gifts");
               }
               dispose();
            default:
               return;
            case "cancel_link_region":
            case "cancel_link":
         }
         _isCancelled = true;
         dispose();
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromClubGiftNotification_ITextWindow_1.textColor = 12247545;
      }
      
      private function onMouseOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromClubGiftNotification_ITextWindow_1.textColor = 16777215;
      }
      
      private function setClubIcon(param1:int) : void
      {
         var _loc2_:IIconWindow = null;
         if(_window)
         {
            _loc2_ = _window.findChildByName("club_icon") as IIconWindow;
            if(_loc2_)
            {
               _loc2_.style = param1;
               _loc2_.invalidate();
            }
         }
      }
   }
}


package com.sulake.habbo.ui.widget.furniture.mysterybox
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.MysteryBoxKeysUpdateEvent;
   import com.sulake.habbo.ui.handler.FurnitureContextMenuWidgetHandler;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.utils.Dictionary;
   
   public class MysteryBoxToolbarExtension implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromMysteryBoxToolbarExtension_String_1:String = "mystery_box_toolbar_extension_minimised";
      
      public static const KEY_COLORS:Dictionary = new Dictionary();
      
      KEY_COLORS["purple"] = 9452386;
      KEY_COLORS["blue"] = 3891856;
      KEY_COLORS["green"] = 6459451;
      KEY_COLORS["yellow"] = 10658089;
      KEY_COLORS["lilac"] = 6897548;
      KEY_COLORS["orange"] = 10841125;
      KEY_COLORS["turquoise"] = 2661026;
      KEY_COLORS["red"] = 10104881;
      
      private var _disposed:Boolean;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1:FurnitureContextMenuWidgetHandler;
      
      public function MysteryBoxToolbarExtension(param1:FurnitureContextMenuWidgetHandler)
      {
         super();
         UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1 = param1;
      }
      
      public function createWindow() : void
      {
         var _loc1_:XML = UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1.widget.assets.getAssetByName("mystery_box_toolbar_extension").content as XML;
         _window = UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1.container.windowManager.buildFromXML(_loc1_) as IWindowController_1;
         _window.findChildByName("faq_link").visible = UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1.container.config.getProperty("mysterybox.faq.url") != "";
         _window.procedure = windowProcedure;
         UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1.container.toolbar.extensionView.attachExtension("mystery_box",_window);
         var _loc2_:ISessionDataManager = UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1.container.sessionDataManager;
         _loc2_.events.addEventListener("mbke_update",onKeysUpdated);
         setMinimised(minimised);
         setKeyColors(_loc2_.mysteryBoxColor,_loc2_.mysteryKeyColor);
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "minimize_region":
               setMinimised(true);
               break;
            case "maximize_region":
               setMinimised(false);
               break;
            case "faq_link":
               HabboWebTools.openWebPage(UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1.container.config.getProperty("mysterybox.faq.url"),"habboMain");
         }
      }
      
      private function setKeyColors(param1:String, param2:String) : void
      {
         var _loc3_:* = 0;
         var _loc6_:* = 0;
         if(_window == null)
         {
            return;
         }
         var _loc5_:Boolean = param1 != null && param1 != "";
         _window.findChildByName("box_colour").visible = _loc5_;
         _window.findChildByName("box_overlay").visible = _loc5_;
         _window.findChildByName("small_box").visible = _loc5_ && minimised;
         IRegionWindow(_window.findChildByName("box_region")).toolTipCaption = _loc5_ ? "${mysterybox.tracker.box." + param1.toLowerCase() + "}" : "";
         if(_loc5_)
         {
            _loc3_ = uint(KEY_COLORS[param1.toLowerCase()]);
            _window.findChildByName("box_colour").color = _loc3_;
            _window.findChildByName("small_box").color = _loc3_;
         }
         var _loc4_:Boolean = param2 != null && param2 != "";
         _window.findChildByName("key_colour").visible = _loc4_;
         _window.findChildByName("key_overlay").visible = _loc4_;
         _window.findChildByName("small_key").visible = _loc4_ && minimised;
         IRegionWindow(_window.findChildByName("key_region")).toolTipCaption = _loc4_ ? "${mysterybox.tracker.key." + param2.toLowerCase() + "}" : "";
         if(_loc4_)
         {
            _loc6_ = uint(KEY_COLORS[param2.toLowerCase()]);
            _window.findChildByName("key_colour").color = _loc6_;
            _window.findChildByName("small_key").color = _loc6_;
         }
      }
      
      private function onKeysUpdated(param1:MysteryBoxKeysUpdateEvent) : void
      {
         setKeyColors(param1.boxColor,param1.keyColor);
      }
      
      private function get minimised() : Boolean
      {
         return UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1 != null && UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1.container.config.getBoolean("mystery_box_toolbar_extension_minimised");
      }
      
      private function setMinimised(param1:Boolean) : void
      {
         if(UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1 != null && _window != null)
         {
            if(param1)
            {
               _window.findChildByName("minimize_region").visible = false;
               _window.findChildByName("maximize_region").visible = true;
               _window.findChildByName("small_box").visible = _window.findChildByName("box_colour").visible;
               _window.findChildByName("small_key").visible = _window.findChildByName("key_colour").visible;
               _window.height = 25;
            }
            else
            {
               _window.findChildByName("minimize_region").visible = true;
               _window.findChildByName("maximize_region").visible = false;
               _window.findChildByName("small_box").visible = false;
               _window.findChildByName("small_key").visible = false;
               _window.height = 137;
            }
            UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1.container.config.setProperty("mystery_box_toolbar_extension_minimised",param1.toString());
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1 != null)
         {
            if(UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1.container)
            {
               UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1.container.toolbar.extensionView.detachExtension("mystery_box");
               UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1.container.sessionDataManager.events.removeEventListener("mbke_update",onKeysUpdated);
            }
            UnknownVarFromMysteryBoxToolbarExtension_FurnitureContextMenuWidgetHandler_1 = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}


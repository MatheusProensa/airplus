package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class MOTDNotification
   {
      private var _window:IFrameController;
      
      private var UnknownVarFromMOTDNotification_IHabboLocalizationManager_1:IHabboLocalizationManager;
      
      private var _messages:Array;
      
      private const LIST_ITEM_HEIGHT_MARGIN:int = 20;
      
      public function MOTDNotification(param1:Array, param2:IAssetLibraryCollection, param3:IHabboWindowManagerComponent)
      {
         var _loc9_:* = null;
         var _loc8_:IWindowController_1 = null;
         var _loc7_:ITextWindow = null;
         super();
         if(!param3 || !param2)
         {
            return;
         }
         _messages = param1;
         var _loc6_:XmlAsset = param2.getAssetByName("motd_notification_xml") as XmlAsset;
         if(_loc6_ == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc6_.content as XML) as IFrameController;
         if(_window == null)
         {
            return;
         }
         _window.procedure = eventHandler;
         _window.center();
         var _loc5_:XmlAsset = param2.getAssetByName("motd_notification_item_xml") as XmlAsset;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:IWindowController_1 = param3.buildFromXML(_loc5_.content as XML) as IWindowController_1;
         var _loc10_:IItemListWindow = _window.findChildByName("message_list") as IItemListWindow;
         for each(_loc9_ in _messages)
         {
            _loc8_ = _loc4_.clone() as IWindowController_1;
            _loc7_ = _loc8_.findChildByName("message_text") as ITextWindow;
            _loc7_.text = _loc9_;
            _loc8_.height = _loc7_.textHeight + 20;
            _loc10_.addListItem(_loc8_);
         }
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromMOTDNotification_IHabboLocalizationManager_1 = null;
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "close":
            case "header_button_close":
               break;
            default:
               return;
         }
         dispose();
      }
   }
}


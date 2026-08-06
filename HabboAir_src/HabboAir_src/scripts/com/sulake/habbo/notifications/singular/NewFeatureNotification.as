package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.competition.SecondsUntilMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.competition.GetSecondsUntilMessageComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.ICountdownWidget;
   import com.sulake.room.utils.ColorConverter;
   
   public class NewFeatureNotification implements IComponentInterfaceQueue
   {
      private static const FEATURE_TYPE_NORMAL:String = "normal";
      
      private static const FEATURE_TYPE_PROMO:String = "promo";
      
      private static const UnknownConstFromNewFeatureNotification_String_1:String = "countdown";
      
      private static const BG_COLOR_NORMAL:String = "#686661";
      
      private static const LINK_COLOR_NORMAL:uint = 16777215;
      
      private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;
      
      private var _window:IWindowController_1;
      
      private var _toolbar:IHabboToolbar;
      
      private var UnknownVarFromNewFeatureNotification_IHabboLocalizationManager_1:IHabboLocalizationManager;
      
      private var UnknownVarFromNewFeatureNotification_ITextWindow_1:ITextWindow;
      
      private var _key:String;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromNewFeatureNotification_Boolean_1:Boolean;
      
      private var UnknownVarFromNewFeatureNotification_SecondsUntilMessageEvent_1:SecondsUntilMessageEvent;
      
      private var _notifications:HabboNotifications;
      
      private var UnknownVarFromNewFeatureNotification_String_1:String;
      
      private var UnknownVarFromNewFeatureNotification_String_2:String;
      
      private var UnknownVarFromNewFeatureNotification_Boolean_2:Boolean;
      
      private var UnknownVarFromNewFeatureNotification_Boolean_3:Boolean;
      
      private var UnknownVarFromNewFeatureNotification_Int_1:int = 0;
      
      private var UnknownVarFromNewFeatureNotification_String_3:String = "normal";
      
      private var _disposed:Boolean;
      
      public function NewFeatureNotification(param1:IAssetLibraryCollection, param2:IHabboWindowManagerComponent, param3:IHabboToolbar, param4:IHabboLocalizationManager, param5:HabboNotifications, param6:String)
      {
         super();
         if(!param1 || !param2)
         {
            return;
         }
         _key = param6;
         _toolbar = param3;
         UnknownVarFromNewFeatureNotification_IHabboLocalizationManager_1 = param4;
         _assets = param1;
         _windowManager = param2;
         _notifications = param5;
         UnknownVarFromNewFeatureNotification_Boolean_1 = false;
         UnknownVarFromNewFeatureNotification_String_3 = getString("notifications.new_feature.type." + _key);
         if(UnknownVarFromNewFeatureNotification_String_3 == null || UnknownVarFromNewFeatureNotification_String_3.length == 0)
         {
            UnknownVarFromNewFeatureNotification_String_3 = "normal";
         }
         UnknownVarFromNewFeatureNotification_String_1 = getString("notifications.new_feature.expiry." + _key);
         UnknownVarFromNewFeatureNotification_String_2 = getString("notifications.new_feature.count_down_to." + _key);
         UnknownVarFromNewFeatureNotification_Boolean_2 = UnknownVarFromNewFeatureNotification_String_1 != null && UnknownVarFromNewFeatureNotification_String_1.length > 0;
         UnknownVarFromNewFeatureNotification_Boolean_3 = UnknownVarFromNewFeatureNotification_String_3 == "countdown" && UnknownVarFromNewFeatureNotification_String_2 != null && UnknownVarFromNewFeatureNotification_String_2.length > 0;
         if(UnknownVarFromNewFeatureNotification_Boolean_2 || UnknownVarFromNewFeatureNotification_Boolean_3)
         {
            UnknownVarFromNewFeatureNotification_SecondsUntilMessageEvent_1 = new SecondsUntilMessageEvent(onTime);
            param5.communication.addHabboConnectionMessageEvent(UnknownVarFromNewFeatureNotification_SecondsUntilMessageEvent_1);
            if(UnknownVarFromNewFeatureNotification_Boolean_2)
            {
               param5.communication.connection.send(new GetSecondsUntilMessageComposer(UnknownVarFromNewFeatureNotification_String_1));
            }
            if(UnknownVarFromNewFeatureNotification_Boolean_3)
            {
               param5.communication.connection.send(new GetSecondsUntilMessageComposer(UnknownVarFromNewFeatureNotification_String_2));
            }
         }
         else
         {
            UnknownVarFromNewFeatureNotification_Boolean_1 = true;
            init();
         }
      }
      
      private function onTime(param1:SecondsUntilMessageEvent) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc3_:String = param1.getParser().timeStr;
         var _loc2_:int = param1.getParser().secondsUntil;
         if(UnknownVarFromNewFeatureNotification_Boolean_2 && _loc3_ == UnknownVarFromNewFeatureNotification_String_1)
         {
            UnknownVarFromNewFeatureNotification_Boolean_2 = false;
            if(_loc2_ <= 0)
            {
               dispose();
               return;
            }
         }
         if(UnknownVarFromNewFeatureNotification_Boolean_3 && _loc3_ == UnknownVarFromNewFeatureNotification_String_2)
         {
            UnknownVarFromNewFeatureNotification_Boolean_3 = false;
            UnknownVarFromNewFeatureNotification_Int_1 = Math.max(0,_loc2_);
         }
         tryInitialize();
      }
      
      private function tryInitialize() : void
      {
         if(UnknownVarFromNewFeatureNotification_Boolean_1 || UnknownVarFromNewFeatureNotification_Boolean_2 || UnknownVarFromNewFeatureNotification_Boolean_3)
         {
            return;
         }
         UnknownVarFromNewFeatureNotification_Boolean_1 = true;
         if(UnknownVarFromNewFeatureNotification_SecondsUntilMessageEvent_1 != null)
         {
            _notifications.communication.removeHabboConnectionMessageEvent(UnknownVarFromNewFeatureNotification_SecondsUntilMessageEvent_1);
            UnknownVarFromNewFeatureNotification_SecondsUntilMessageEvent_1 = null;
         }
         init();
      }
      
      private function init() : void
      {
         var _loc2_:IRegionWindow = null;
         var _loc3_:IWindowModel = null;
         var _loc1_:XmlAsset = _assets.getAssetByName(UnknownVarFromNewFeatureNotification_String_3 == "normal" ? "new_feature_notification_xml" : "new_feature_notification_" + UnknownVarFromNewFeatureNotification_String_3 + "_xml") as XmlAsset;
         if(_loc1_ == null)
         {
            return;
         }
         _window = _windowManager.buildFromXML(_loc1_.content as XML) as IWindowController_1;
         if(_window == null)
         {
            return;
         }
         _window.procedure = eventHandler;
         _toolbar.extensionView.attachExtension("new_feature_" + _key,_window);
         if(UnknownVarFromNewFeatureNotification_String_3 == "normal")
         {
            UnknownVarFromNewFeatureNotification_ITextWindow_1 = _window.findChildByName("cancel_link") as ITextWindow;
            _loc2_ = _window.findChildByName("cancel_link_region") as IRegionWindow;
         }
         else if(UnknownVarFromNewFeatureNotification_String_3 == "promo" || UnknownVarFromNewFeatureNotification_String_3 == "countdown")
         {
            UnknownVarFromNewFeatureNotification_ITextWindow_1 = _window.findChildByName("desc") as ITextWindow;
            _loc2_ = _window as IRegionWindow;
         }
         if(_loc2_)
         {
            _loc2_.addEventListener("WME_OVER",onMouseOver);
            _loc2_.addEventListener("WME_OUT",onMouseOut);
         }
         if(UnknownVarFromNewFeatureNotification_String_3 == "countdown")
         {
            _loc3_ = _window.findChildByName("cancel_link_region");
            if(_loc3_ != null && !_loc3_.visible)
            {
               _loc3_.visible = true;
            }
         }
         initLayout();
      }
      
      private function initLayout() : void
      {
         var _loc3_:* = 0;
         var _loc1_:IWidgetWindowController = null;
         var _loc4_:ICountdownWidget = null;
         var _loc2_:String = getString("notifications.new_feature.image." + _key);
         var _loc5_:String = getString("notifications.new_feature.color." + _key);
         if(_loc5_ == "")
         {
            _loc5_ = "#686661";
         }
         var _loc10_:ITextWindow = _window.findChildByName("desc") as ITextWindow;
         _loc10_.text = UnknownVarFromNewFeatureNotification_IHabboLocalizationManager_1.getLocalization("notifications.new_feature." + _key + ".desc");
         var _loc7_:IStaticBitmapWrapperWindow = _window.findChildByName("static_bitmap") as IStaticBitmapWrapperWindow;
         _loc7_.assetUri = _loc2_;
         var _loc8_:uint = ColorConverter.hexToUint(_loc5_);
         var _loc9_:IWindowModel = _window.findChildByName("border");
         if(_loc9_ == null)
         {
            _loc9_ = _window;
         }
         _loc9_.color = _loc8_;
         var _loc6_:uint = ColorConverter.rgbToHSL(_loc8_);
         var _loc11_:UnknownICoreWindowComponents4 = _window.findChildByName("open_button") as UnknownICoreWindowComponents4;
         if(_loc11_ != null)
         {
            _loc3_ = uint(255 - int((255 - (_loc6_ & 0xFF)) / 2) | _loc6_ & 0xFFFF00);
            _loc11_.color = ColorConverter.hslToRGB(_loc3_);
         }
         if(UnknownVarFromNewFeatureNotification_String_3 == "countdown")
         {
            _loc1_ = _window.findChildByName("countdown_widget") as IWidgetWindowController;
            if(_loc1_ != null)
            {
               _loc4_ = ICountdownWidget(_loc1_.widget);
               _loc4_.seconds = UnknownVarFromNewFeatureNotification_Int_1;
               _loc4_.running = true;
            }
         }
      }
      
      private function getBoolean(param1:String) : Boolean
      {
         return (_toolbar as Component).getBoolean(param1);
      }
      
      private function getString(param1:String) : String
      {
         return (_toolbar as Component).getProperty(param1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromNewFeatureNotification_SecondsUntilMessageEvent_1 != null)
         {
            _notifications.communication.removeHabboConnectionMessageEvent(UnknownVarFromNewFeatureNotification_SecondsUntilMessageEvent_1);
            UnknownVarFromNewFeatureNotification_SecondsUntilMessageEvent_1 = null;
         }
         if(_toolbar && UnknownVarFromNewFeatureNotification_Boolean_1)
         {
            _toolbar.extensionView.detachExtension("new_feature_" + _key);
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _windowManager = null;
         _assets = null;
         UnknownVarFromNewFeatureNotification_ITextWindow_1 = null;
         _toolbar = null;
         _notifications = null;
         _disposed = true;
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:IWindowModel = null;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "open_button":
            case "main_region":
               openConfiguredLink();
               _loc3_ = _window.findChildByName("cancel_link_region");
               if(_loc3_ != null && !_loc3_.visible)
               {
                  _loc3_.visible = true;
               }
               break;
            default:
               break;
            case "cancel_link_region":
            case "cancel_link":
               dispose();
               return;
         }
      }
      
      private function openConfiguredLink() : void
      {
         var _loc2_:String = getString("notifications.new_feature.internal_link." + _key);
         if(_loc2_ != "")
         {
            (_toolbar as Component).context.createLinkEvent(_loc2_);
            return;
         }
         var _loc1_:String = getString("notifications.new_feature.external_link." + _key);
         if(_loc1_ != "")
         {
            HabboWebTools.openWebPage(_loc1_,"habboMain");
         }
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromNewFeatureNotification_ITextWindow_1.textColor = 12247545;
      }
      
      private function onMouseOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromNewFeatureNotification_ITextWindow_1.textColor = 16777215;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}


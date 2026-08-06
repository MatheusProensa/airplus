package com.sulake.habbo.inventory.trading.namescam
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TradingNameScamWarningView implements IComponentInterfaceQueue
   {
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private static const CLOSE_LOCK_SECONDS:int = 6;
      
      private static const SECTION_PADDING:int = 6;
      
      private var UnknownVarFromTradingNameScamWarningView_TradingNameScamWarningController_1:TradingNameScamWarningController;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromTradingNameScamWarningView_Timer_1:Timer;
      
      private var UnknownVarFromTradingNameScamWarningView_Int_1:int = 0;
      
      private var _disposed:Boolean;
      
      public function TradingNameScamWarningView(param1:TradingNameScamWarningController, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager)
      {
         super();
         UnknownVarFromTradingNameScamWarningView_TradingNameScamWarningController_1 = param1;
         _windowManager = param2;
         _localization = param4;
         _window = param2.buildFromXML(XML(XmlAsset(param3.getAssetByName("inventory_trading_name_scam_warning_xml")).content),1) as IFrameController;
         _window.enableLookupCache();
         UnknownVarFromTradingNameScamWarningView_Timer_1 = new Timer(1000,6);
         UnknownVarFromTradingNameScamWarningView_Timer_1.addEventListener("timer",onCloseLockTimer);
         headerCloseButton.addEventListener("WME_CLICK",onWindowClose);
         dismissButton.addEventListener("WME_CLICK",onWindowClose);
         openProfileButton.addEventListener("WME_CLICK",onOpenProfileClicked);
      }
      
      public function show(param1:TradingNameScamWarningData) : void
      {
         var _loc2_:IDesktopController = null;
         if(_disposed || param1 == null)
         {
            return;
         }
         _window.caption = _localization.getLocalization("inventory.trading.namescam.title");
         warningText.text = _localization.getLocalizationWithParams("inventory.trading.namescam.warning","","trader_name",param1.tradedUserName);
         warningText.height = warningText.textHeight + 6;
         traderLabel.text = _localization.getLocalization("inventory.trading.namescam.trader");
         traderNameText.text = param1.tradedUserName;
         openProfileButton.id = param1.tradedUserId;
         var _loc3_:IAvatarImageWidget = traderAvatar.widget as IAvatarImageWidget;
         if(_loc3_ != null)
         {
            _loc3_.figure = param1.tradedUserFigure;
            _loc3_.userId = param1.tradedUserId;
         }
         updateMatchesSection(roomMatchesSection,roomMatchesHeader,roomMatchesText,"inventory.trading.namescam.similar_in_room",param1.similarInRoom);
         updateMatchesSection(friendMatchesSection,friendMatchesHeader,friendMatchesText,"inventory.trading.namescam.similar_in_friends",param1.similarInFriends);
         startCloseLockCountdown();
         if(_window.parent == null)
         {
            _loc2_ = _windowManager.getDesktop(1);
            if(_loc2_ != null)
            {
               _loc2_.addChild(_window);
            }
         }
         _window.center();
         _window.activate();
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         stopCloseLockCountdown();
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function startCloseLockCountdown() : void
      {
         UnknownVarFromTradingNameScamWarningView_Int_1 = 6;
         UnknownVarFromTradingNameScamWarningView_Timer_1.reset();
         UnknownVarFromTradingNameScamWarningView_Timer_1.start();
         updateCloseLockUI();
      }
      
      private function stopCloseLockCountdown() : void
      {
         if(UnknownVarFromTradingNameScamWarningView_Timer_1 != null)
         {
            UnknownVarFromTradingNameScamWarningView_Timer_1.stop();
            UnknownVarFromTradingNameScamWarningView_Timer_1.reset();
         }
         UnknownVarFromTradingNameScamWarningView_Int_1 = 0;
         updateCloseLockUI();
      }
      
      private function onCloseLockTimer(param1:TimerEvent) : void
      {
         UnknownVarFromTradingNameScamWarningView_Int_1 -= 1;
         if(UnknownVarFromTradingNameScamWarningView_Int_1 <= 0)
         {
            stopCloseLockCountdown();
            return;
         }
         updateCloseLockUI();
      }
      
      private function updateCloseLockUI() : void
      {
         var _loc1_:* = UnknownVarFromTradingNameScamWarningView_Int_1 > 0;
         if(_loc1_)
         {
            dismissButton.disable();
            headerCloseButton.disable();
            closeCountdownText.visible = true;
            closeCountdownText.text = _localization.getLocalizationWithParams("inventory.trading.namescam.close_countdown","","seconds",String(UnknownVarFromTradingNameScamWarningView_Int_1));
         }
         else
         {
            dismissButton.enable();
            headerCloseButton.enable();
            closeCountdownText.text = "";
            closeCountdownText.visible = false;
         }
      }
      
      private function updateMatchesSection(param1:IWindowController_1, param2:ITextWindow, param3:ITextWindow, param4:String, param5:Array) : void
      {
         var _loc6_:Boolean = param5 != null && param5.length > 0;
         param1.visible = _loc6_;
         if(!_loc6_)
         {
            param1.height = 0;
            param3.text = "";
            return;
         }
         param2.text = _localization.getLocalization(param4);
         param3.text = param5.join("\r");
         param3.height = param3.textHeight + 6;
         param1.height = param3.y + param3.height + 6;
      }
      
      private function onOpenProfileClicked(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromTradingNameScamWarningView_TradingNameScamWarningController_1.openProfile(openProfileButton.id);
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(UnknownVarFromTradingNameScamWarningView_Int_1 > 0)
         {
            return;
         }
         hide();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         headerCloseButton.removeEventListener("WME_CLICK",onWindowClose);
         dismissButton.removeEventListener("WME_CLICK",onWindowClose);
         openProfileButton.removeEventListener("WME_CLICK",onOpenProfileClicked);
         UnknownVarFromTradingNameScamWarningView_Timer_1.removeEventListener("timer",onCloseLockTimer);
         hide();
         UnknownVarFromTradingNameScamWarningView_Timer_1 = null;
         _window.dispose();
         _window = null;
         _windowManager = null;
         _localization = null;
         UnknownVarFromTradingNameScamWarningView_TradingNameScamWarningController_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get headerCloseButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get contentList() : IItemListWindow
      {
         return _window.findChildByName("content_list") as IItemListWindow;
      }
      
      private function get warningText() : ITextWindow
      {
         return _window.findChildByName("warning_text") as ITextWindow;
      }
      
      private function get traderLabel() : ITextWindow
      {
         return _window.findChildByName("trader_label") as ITextWindow;
      }
      
      private function get traderNameText() : ITextWindow
      {
         return _window.findChildByName("trader_name_text") as ITextWindow;
      }
      
      private function get traderAvatar() : IWidgetWindowController
      {
         return _window.findChildByName("trader_avatar") as IWidgetWindowController;
      }
      
      private function get openProfileButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("open_profile_button") as UnknownICoreWindowComponents4;
      }
      
      private function get roomMatchesSection() : IWindowController_1
      {
         return _window.findChildByName("room_matches_section") as IWindowController_1;
      }
      
      private function get roomMatchesHeader() : ITextWindow
      {
         return _window.findChildByName("room_matches_header") as ITextWindow;
      }
      
      private function get roomMatchesText() : ITextWindow
      {
         return _window.findChildByName("room_matches_text") as ITextWindow;
      }
      
      private function get friendMatchesSection() : IWindowController_1
      {
         return _window.findChildByName("friend_matches_section") as IWindowController_1;
      }
      
      private function get friendMatchesHeader() : ITextWindow
      {
         return _window.findChildByName("friend_matches_header") as ITextWindow;
      }
      
      private function get friendMatchesText() : ITextWindow
      {
         return _window.findChildByName("friend_matches_text") as ITextWindow;
      }
      
      private function get dismissButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("close_button") as UnknownICoreWindowComponents4;
      }
      
      private function get closeCountdownText() : ITextWindow
      {
         return _window.findChildByName("close_countdown_text") as ITextWindow;
      }
   }
}


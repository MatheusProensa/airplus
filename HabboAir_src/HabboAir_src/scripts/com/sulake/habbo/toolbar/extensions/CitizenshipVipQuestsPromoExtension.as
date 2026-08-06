package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.perk.CitizenshipVipOfferPromoEnabledEvent;
   import com.sulake.habbo.communication.messages.outgoing.quest.StartCampaignMessageComposer;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.IExtensionView;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   
   public class CitizenshipVipQuestsPromoExtension
   {
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromCitizenshipVipQuestsPromoExtension_IEventDispatcher_1:IEventDispatcher;
      
      private var _localization:ICoreLocalizationManager;
      
      private var UnknownVarFromCitizenshipVipQuestsPromoExtension_IConnection_1:IConnection;
      
      private var UnknownVarFromCitizenshipVipQuestsPromoExtension_IExtensionView_1:IExtensionView;
      
      private var UnknownVarFromCitizenshipVipQuestsPromoExtension_UnknownICoreWindowComponents6_1:UnknownICoreWindowComponents6;
      
      private var _disposed:Boolean = false;
      
      private var _expanded:Boolean = true;
      
      private var UnknownVarFromCitizenshipVipQuestsPromoExtension_Int_1:int = 216;
      
      private var _vipQuestsCampaignName:String;
      
      private var UnknownVarFromCitizenshipVipQuestsPromoExtension_IMessageEvent_1:IMessageEvent = null;
      
      public function CitizenshipVipQuestsPromoExtension(param1:HabboToolbar, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IEventDispatcher, param5:ICoreLocalizationManager, param6:IConnection)
      {
         super();
         _windowManager = param2;
         _assets = param3;
         UnknownVarFromCitizenshipVipQuestsPromoExtension_IEventDispatcher_1 = param4;
         _localization = param5;
         UnknownVarFromCitizenshipVipQuestsPromoExtension_IConnection_1 = param6;
         UnknownVarFromCitizenshipVipQuestsPromoExtension_IExtensionView_1 = param1.extensionView;
         UnknownVarFromCitizenshipVipQuestsPromoExtension_IMessageEvent_1 = new CitizenshipVipOfferPromoEnabledEvent(onCitizenshipQuestPromoEnabled);
         UnknownVarFromCitizenshipVipQuestsPromoExtension_IConnection_1.addMessageEvent(UnknownVarFromCitizenshipVipQuestsPromoExtension_IMessageEvent_1);
         _vipQuestsCampaignName = param1.getProperty("citizenship.vip.tutorial.quest.campaign.name");
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromCitizenshipVipQuestsPromoExtension_IConnection_1 && UnknownVarFromCitizenshipVipQuestsPromoExtension_IMessageEvent_1)
         {
            UnknownVarFromCitizenshipVipQuestsPromoExtension_IConnection_1.removeMessageEvent(UnknownVarFromCitizenshipVipQuestsPromoExtension_IMessageEvent_1);
            UnknownVarFromCitizenshipVipQuestsPromoExtension_IMessageEvent_1 = null;
         }
         destroyWindow();
         _localization = null;
         _assets = null;
         UnknownVarFromCitizenshipVipQuestsPromoExtension_IEventDispatcher_1 = null;
         _windowManager = null;
         UnknownVarFromCitizenshipVipQuestsPromoExtension_IConnection_1 = null;
         UnknownVarFromCitizenshipVipQuestsPromoExtension_IExtensionView_1 = null;
         _disposed = true;
      }
      
      private function createWindow() : UnknownICoreWindowComponents6
      {
         var _loc1_:UnknownICoreWindowComponents6 = null;
         var _loc2_:ISoundAsset = _assets.getAssetByName("vip_quests_promo_xml");
         if(_loc2_)
         {
            _loc1_ = _windowManager.buildFromXML(_loc2_.content as XML,1) as UnknownICoreWindowComponents6;
            if(_loc1_)
            {
               UnknownICoreWindowComponents4(_loc1_.findChildByName("quests_button").addEventListener("WME_CLICK",onButtonClicked));
               IRegionWindow(_loc1_.findChildByName("minimize_region")).addEventListener("WME_CLICK",onMinMax);
               IRegionWindow(_loc1_.findChildByName("maximize_region")).addEventListener("WME_CLICK",onMinMax);
               UnknownVarFromCitizenshipVipQuestsPromoExtension_Int_1 = _loc1_.height;
            }
         }
         return _loc1_;
      }
      
      private function destroyWindow() : void
      {
         if(UnknownVarFromCitizenshipVipQuestsPromoExtension_IExtensionView_1)
         {
            UnknownVarFromCitizenshipVipQuestsPromoExtension_IExtensionView_1.detachExtension("vip_quests");
         }
         if(UnknownVarFromCitizenshipVipQuestsPromoExtension_UnknownICoreWindowComponents6_1)
         {
            UnknownVarFromCitizenshipVipQuestsPromoExtension_UnknownICoreWindowComponents6_1.dispose();
            UnknownVarFromCitizenshipVipQuestsPromoExtension_UnknownICoreWindowComponents6_1 = null;
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromCitizenshipVipQuestsPromoExtension_IConnection_1)
         {
            UnknownVarFromCitizenshipVipQuestsPromoExtension_IConnection_1.send(new StartCampaignMessageComposer(_vipQuestsCampaignName));
         }
         destroyWindow();
      }
      
      private function onMinMax(param1:WindowMouseEvent) : void
      {
         _expanded = !_expanded;
         assignState();
      }
      
      private function assignState() : void
      {
         IItemListWindow(UnknownVarFromCitizenshipVipQuestsPromoExtension_UnknownICoreWindowComponents6_1.findChildByName("content_itemlist")).visible = _expanded;
         IStaticBitmapWrapperWindow(UnknownVarFromCitizenshipVipQuestsPromoExtension_UnknownICoreWindowComponents6_1.findChildByName("promo_img")).visible = _expanded;
         UnknownVarFromCitizenshipVipQuestsPromoExtension_UnknownICoreWindowComponents6_1.height = _expanded ? UnknownVarFromCitizenshipVipQuestsPromoExtension_Int_1 : 33;
      }
      
      private function onCitizenshipQuestPromoEnabled(param1:IMessageEvent) : void
      {
         if(UnknownVarFromCitizenshipVipQuestsPromoExtension_UnknownICoreWindowComponents6_1 == null)
         {
            UnknownVarFromCitizenshipVipQuestsPromoExtension_UnknownICoreWindowComponents6_1 = createWindow();
         }
         assignState();
         UnknownVarFromCitizenshipVipQuestsPromoExtension_IExtensionView_1.detachExtension("club_promo");
         UnknownVarFromCitizenshipVipQuestsPromoExtension_IExtensionView_1.attachExtension("vip_quests",UnknownVarFromCitizenshipVipQuestsPromoExtension_UnknownICoreWindowComponents6_1,10);
      }
   }
}


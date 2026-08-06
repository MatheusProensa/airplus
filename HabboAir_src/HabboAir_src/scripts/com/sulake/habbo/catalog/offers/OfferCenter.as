package com.sulake.habbo.catalog.offers
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.notifications.OfferRewardDeliveredMessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.OfferRewardDeliveredMessageParser;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class OfferCenter implements IOfferCenter, IComponentInterfaceQueue
   {
      private static const PROVIDER_POLLING_FREQUENCY:int = 1800000;
      
      private var _disposed:Boolean;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _catalog:IHabboCatalog;
      
      private var _offerExtension:IOfferExtension;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromOfferCenter_IOfferProvider_1:IOfferProvider;
      
      private var _providers:Vector.<IOfferProvider>;
      
      private var UnknownVarFromOfferCenter_Vector_1:Vector.<OfferReward>;
      
      private var UnknownVarFromOfferCenter_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromOfferCenter_Timer_1:Timer;
      
      private var _offerRewardDeliveredMessageEvent:OfferRewardDeliveredMessageEvent;
      
      public function OfferCenter(param1:IHabboWindowManagerComponent, param2:IAssetLibraryCollection, param3:IHabboCatalog)
      {
         super();
         _windowManager = param1;
         _assets = param2;
         _catalog = param3;
         _offerRewardDeliveredMessageEvent = new OfferRewardDeliveredMessageEvent(onOfferRewardDelivered);
         _catalog.connection.addMessageEvent(_offerRewardDeliveredMessageEvent);
         _providers = new Vector.<IOfferProvider>(0);
         _providers.push(new SupersonicProvider(this));
         _providers.push(new SponsorPayProvider(this));
         UnknownVarFromOfferCenter_Vector_1 = new Vector.<OfferReward>(0);
         UnknownVarFromOfferCenter_Timer_1 = new Timer(1800000);
         UnknownVarFromOfferCenter_Timer_1.addEventListener("timer",onPollTimer);
         UnknownVarFromOfferCenter_Timer_1.start();
         onPollTimer(null);
      }
      
      private function onPollTimer(param1:TimerEvent) : void
      {
         if(_providers == null)
         {
            return;
         }
         for each(var _loc2_ in _providers)
         {
            if(_loc2_.enabled)
            {
               _loc2_.load();
            }
         }
      }
      
      private function getNextProvider() : IOfferProvider
      {
         if(_providers == null)
         {
            return null;
         }
         for each(var _loc1_ in _providers)
         {
            if(_loc1_.enabled && _loc1_.videoAvailable)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function onOfferRewardDelivered(param1:OfferRewardDeliveredMessageEvent) : void
      {
         var _loc2_:OfferRewardDeliveredMessageParser = param1.getParser();
         addReward(_loc2_.name,_loc2_.contentType,_loc2_.classId);
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
         if(_providers != null)
         {
            for each(var _loc1_ in _providers)
            {
               _loc1_.dispose();
            }
            _providers = null;
         }
         if(UnknownVarFromOfferCenter_Timer_1 != null)
         {
            UnknownVarFromOfferCenter_Timer_1.stop();
            UnknownVarFromOfferCenter_Timer_1 = null;
         }
         _catalog.connection.removeMessageEvent(_offerRewardDeliveredMessageEvent);
         _offerRewardDeliveredMessageEvent = null;
         UnknownVarFromOfferCenter_Vector_1 = null;
         _offerExtension = null;
         _windowManager = null;
         _catalog = null;
         _assets = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set offerExtension(param1:IOfferExtension) : void
      {
         _offerExtension = param1;
      }
      
      public function showRewards() : void
      {
         hide();
         _window = _windowManager.buildFromXML(_assets.getAssetByName("offer_center_xml").content as XML) as IWindowController_1;
         _window.procedure = windowProcedure;
         _window.center();
         UnknownVarFromOfferCenter_IWindowModel_1 = IItemListWindow(_window.findChildByName("reward_list")).removeListItemAt(0);
         populateRewardList();
      }
      
      public function showVideo() : void
      {
         if(UnknownVarFromOfferCenter_IOfferProvider_1 != null)
         {
            UnknownVarFromOfferCenter_IOfferProvider_1.showVideo();
         }
      }
      
      public function get showingVideo() : Boolean
      {
         return UnknownVarFromOfferCenter_IOfferProvider_1 != null && UnknownVarFromOfferCenter_IOfferProvider_1.showingPopup;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK" || !visible)
         {
            return;
         }
         var _loc3_:* = param2.name;
         if("header_button_close" === _loc3_)
         {
            hide();
         }
      }
      
      private function hide() : void
      {
         if(_window != null)
         {
            UnknownVarFromOfferCenter_IWindowModel_1.dispose();
            UnknownVarFromOfferCenter_IWindowModel_1 = null;
            _window.dispose();
            _window = null;
         }
      }
      
      private function addReward(param1:String, param2:String, param3:int) : void
      {
         var _loc4_:OfferReward = new OfferReward(param1,param2,param3);
         UnknownVarFromOfferCenter_Vector_1.unshift(_loc4_);
         if(visible)
         {
            IItemListWindow(_window.findChildByName("reward_list")).addListItemAt(createRewardItem(_loc4_),0);
         }
         else if(_offerExtension != null)
         {
            _offerExtension.indicateRewards();
         }
      }
      
      public function get configuration() : IComponent_1
      {
         return _catalog as IComponent_1;
      }
      
      public function updateVideoStatus() : void
      {
         if(_offerExtension != null)
         {
            UnknownVarFromOfferCenter_IOfferProvider_1 = getNextProvider();
            _offerExtension.indicateVideoAvailable(UnknownVarFromOfferCenter_IOfferProvider_1 != null && UnknownVarFromOfferCenter_IOfferProvider_1.videoAvailable);
         }
      }
      
      private function populateRewardList() : void
      {
         if(!visible)
         {
            return;
         }
         var _loc2_:IItemListWindow = _window.findChildByName("reward_list") as IItemListWindow;
         _loc2_.destroyListItems();
         for each(var _loc1_ in UnknownVarFromOfferCenter_Vector_1)
         {
            _loc2_.addListItem(createRewardItem(_loc1_));
         }
      }
      
      private function createRewardItem(param1:OfferReward) : IWindowModel
      {
         var _loc2_:IWindowController_1 = UnknownVarFromOfferCenter_IWindowModel_1.clone() as IWindowController_1;
         _loc2_.findChildByName("reward_date").caption = new Date().toLocaleString();
         _loc2_.findChildByName("reward_name").caption = param1.name;
         _catalog.displayProductIcon(param1.contentType,param1.classId,IBitmapWrapperController(_loc2_.findChildByName("reward_icon")));
         return _loc2_;
      }
      
      private function get visible() : Boolean
      {
         return _window != null && !_window.disposed && Boolean(_window.visible);
      }
      
      public function showSuccess() : void
      {
      }
   }
}


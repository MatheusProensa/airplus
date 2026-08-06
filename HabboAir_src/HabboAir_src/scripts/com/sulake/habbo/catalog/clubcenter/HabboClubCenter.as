package com.sulake.habbo.catalog.clubcenter
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.clubcenter.util.BadgeResolver;
   import com.sulake.habbo.catalog.offers.IOfferCenter;
   import com.sulake.habbo.catalog.offers.IOfferExtension;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrKickbackData;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendKickbackInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubGiftMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.ScrGetKickbackInfoMessageComposer;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesParser;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendKickbackInfoMessageParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.Stage;
   import flash.utils.getTimer;
   
   public class HabboClubCenter extends Component implements ILinkEventTracker, IOfferExtension
   {
      private static const USE_FAKE_DATA:Boolean = false;
      
      private static const DATA_UPDATE_INTERVAL_MSEC:int = 10000;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolbar:IHabboToolbar;
      
      private var _offerCenter:IOfferCenter;
      
      private var UnknownVarFromHabboClubCenter_Boolean_1:Boolean = false;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromHabboClubCenter_ClubCenterView_1:ClubCenterView;
      
      private var UnknownVarFromHabboClubCenter_ClubSpecialInfoBubbleView_1:ClubSpecialInfoBubbleView;
      
      private var UnknownVarFromHabboClubCenter_ScrKickbackData_1:ScrKickbackData;
      
      private var UnknownVarFromHabboClubCenter_Int_1:int = -10000;
      
      private var UnknownVarFromHabboClubCenter_Boolean_2:Boolean = false;
      
      private var UnknownVarFromHabboClubCenter_String_1:String;
      
      private var _giftsAvailable:int;
      
      private var UnknownVarFromHabboClubCenter_Vector_1:Vector.<Map>;
      
      public function HabboClubCenter(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new ClubGiftInfoEvent(onClubGiftInfo));
         addMessageEvent(new ScrSendKickbackInfoMessageEvent(onKickbackInfoMessageEvent));
         addMessageEvent(new BadgesEvent(onBadges));
         context.addLinkEventTracker(this);
         if(getBoolean("offers.enabled") && getBoolean("offers.habboclub.enabled"))
         {
            _offerCenter = catalog.getOfferCenter(this);
         }
      }
      
      override public function dispose() : void
      {
         if(_messageEvents != null && _communicationManager != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         if(_sessionDataManager != null && _sessionDataManager.events)
         {
            _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeReady);
         }
         if(_offerCenter != null)
         {
            _offerCenter = null;
         }
         removeView();
         UnknownVarFromHabboClubCenter_ScrKickbackData_1 = null;
         _messageEvents = null;
         super.dispose();
      }
      
      public function get linkPattern() : String
      {
         return "habboUI/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 3)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            var _loc3_:* = _loc2_[2];
            if("hccenter" === _loc3_)
            {
               showClubCenter();
            }
         }
      }
      
      private function showClubCenter() : void
      {
         if(!UnknownVarFromHabboClubCenter_ClubCenterView_1)
         {
            UnknownVarFromHabboClubCenter_ClubCenterView_1 = new ClubCenterView(this,_windowManager,_sessionDataManager.figure);
         }
         if(updateNeeded())
         {
            updateData();
         }
         else
         {
            populate();
         }
         if(_offerCenter && UnknownVarFromHabboClubCenter_ClubCenterView_1 && UnknownVarFromHabboClubCenter_Boolean_1)
         {
            UnknownVarFromHabboClubCenter_Boolean_1 = false;
            indicateVideoAvailable(true);
         }
      }
      
      public function removeView() : void
      {
         if(UnknownVarFromHabboClubCenter_ClubCenterView_1)
         {
            UnknownVarFromHabboClubCenter_ClubCenterView_1.dispose();
            UnknownVarFromHabboClubCenter_ClubCenterView_1 = null;
         }
         removeBreakdown();
         UnknownVarFromHabboClubCenter_Boolean_2 = false;
      }
      
      public function removeBreakdown() : void
      {
         if(UnknownVarFromHabboClubCenter_ClubSpecialInfoBubbleView_1)
         {
            UnknownVarFromHabboClubCenter_ClubSpecialInfoBubbleView_1.dispose();
            UnknownVarFromHabboClubCenter_ClubSpecialInfoBubbleView_1 = null;
         }
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(param1));
      }
      
      private function onKickbackInfoMessageEvent(param1:ScrSendKickbackInfoMessageEvent) : void
      {
         var _loc2_:ScrSendKickbackInfoMessageParser = param1.getParser();
         UnknownVarFromHabboClubCenter_ScrKickbackData_1 = _loc2_.data;
         UnknownVarFromHabboClubCenter_Boolean_2 = false;
         UnknownVarFromHabboClubCenter_Int_1 = getTimer();
         populate();
      }
      
      private function onClubGiftInfo(param1:ClubGiftInfoEvent) : void
      {
         _giftsAvailable = param1.getParser().giftsAvailable;
         populate();
      }
      
      private function onBadgeReady(param1:BadgeImageReadyEvent) : void
      {
         if(param1.badgeId != UnknownVarFromHabboClubCenter_String_1 || !_sessionDataManager)
         {
            return;
         }
         _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeReady);
         populate();
      }
      
      public function onBadges(param1:IMessageEvent) : void
      {
         var _loc3_:BadgesParser = (param1 as BadgesEvent).getParser();
         if(UnknownVarFromHabboClubCenter_Vector_1 == null)
         {
            UnknownVarFromHabboClubCenter_Vector_1 = new Vector.<Map>(_loc3_.totalFragments,true);
         }
         var _loc4_:Map = new Map();
         _loc4_.concatenate(_loc3_.currentFragment);
         var _loc2_:Map = addMessageFragment(_loc4_,_loc3_.totalFragments,_loc3_.fragmentNo,UnknownVarFromHabboClubCenter_Vector_1);
         if(!_loc2_)
         {
            return;
         }
         UnknownVarFromHabboClubCenter_Vector_1 = null;
         UnknownVarFromHabboClubCenter_String_1 = BadgeResolver.resolveClubBadgeId(_loc2_.getKeys());
      }
      
      private function updateNeeded() : Boolean
      {
         return !UnknownVarFromHabboClubCenter_Boolean_2 && getTimer() - UnknownVarFromHabboClubCenter_Int_1 > 10000;
      }
      
      private function updateData() : void
      {
         UnknownVarFromHabboClubCenter_Boolean_2 = true;
         _communicationManager.connection.send(new GetBadgesComposer());
         _communicationManager.connection.send(new GetClubGiftMessageComposer());
         if(true)
         {
            _communicationManager.connection.send(new ScrGetKickbackInfoMessageComposer());
         }
         else
         {
            UnknownVarFromHabboClubCenter_ScrKickbackData_1 = new ScrKickbackData();
            populate();
         }
      }
      
      private function populate() : void
      {
         if(UnknownVarFromHabboClubCenter_ClubCenterView_1)
         {
            UnknownVarFromHabboClubCenter_ClubCenterView_1.dataReceived(UnknownVarFromHabboClubCenter_ScrKickbackData_1,getPurse(),getGiftsAvailable(),BadgeResolver.resolveBadgeBitmap(UnknownVarFromHabboClubCenter_String_1,onBadgeReady,_sessionDataManager));
         }
      }
      
      private function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      private function getPurse() : IPurse
      {
         return catalog != null ? catalog.getPurse() : null;
      }
      
      private function getGiftsAvailable() : int
      {
         return _giftsAvailable;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return catalog != null ? catalog.localization : null;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function resolveClubStatus() : String
      {
         if(!catalog)
         {
            return "none";
         }
         var _loc1_:IPurse = getPurse();
         if(_loc1_.clubDays > 0)
         {
            return "active";
         }
         if(_loc1_.pastClubDays > 0 || _loc1_.pastVipDays > 0)
         {
            return "expired";
         }
         return "none";
      }
      
      public function openPurchasePage() : void
      {
         if(catalog)
         {
            catalog.openCatalogPage("hc_membership","NORMAL");
         }
      }
      
      public function openClubGiftPage() : void
      {
         if(catalog)
         {
            catalog.openCatalogPage("club_gifts","NORMAL");
         }
      }
      
      public function showPaydayBreakdownView() : void
      {
         if(UnknownVarFromHabboClubCenter_ClubSpecialInfoBubbleView_1)
         {
            removeBreakdown();
            return;
         }
         UnknownVarFromHabboClubCenter_ClubSpecialInfoBubbleView_1 = new ClubSpecialInfoBubbleView(this,_windowManager,UnknownVarFromHabboClubCenter_ScrKickbackData_1,UnknownVarFromHabboClubCenter_ClubCenterView_1.getSpecialCalloutAnchor());
      }
      
      public function openPaydayHelpPage() : void
      {
         context.createLinkEvent("habbopages/hcpayday");
      }
      
      public function openHelpPage() : void
      {
         context.createLinkEvent("habbopages/habboclub");
      }
      
      public function processHotelLink(param1:String) : void
      {
         context.createLinkEvent(param1);
      }
      
      public function isKickbackEnabled() : Boolean
      {
         var _loc1_:String = getProperty("hccenter.activity.enabled");
         if(_loc1_ == null || _loc1_ == "")
         {
            return true;
         }
         return _loc1_ == "1" || _loc1_ == "true";
      }
      
      public function get stage() : Stage
      {
         return context && context.displayObjectContainer ? context.displayObjectContainer.stage : null;
      }
      
      public function getOffers() : void
      {
         _catalog.getHabboClubOffers(3);
      }
      
      public function get offerCenter() : IOfferCenter
      {
         return _offerCenter;
      }
      
      public function indicateRewards() : void
      {
      }
      
      public function indicateVideoAvailable(param1:Boolean) : void
      {
         if(UnknownVarFromHabboClubCenter_ClubCenterView_1)
         {
            UnknownVarFromHabboClubCenter_ClubCenterView_1.setVideoOfferButtonVisibility(param1,_offerCenter != null && !_offerCenter.showingVideo);
         }
         else
         {
            UnknownVarFromHabboClubCenter_Boolean_1 = param1;
         }
      }
      
      private function addMessageFragment(param1:Map, param2:int, param3:int, param4:Vector.<Map>) : Map
      {
         if(param2 == 1)
         {
            return param1;
         }
         param4[param3] = param1;
         for each(var _loc5_ in param4)
         {
            if(_loc5_ == null)
            {
               return null;
            }
         }
         var _loc6_:Map = new Map();
         for each(var _loc7_ in param4)
         {
            _loc6_.concatenate(_loc7_);
            _loc7_.dispose();
         }
         param4 = null;
         return _loc6_;
      }
   }
}


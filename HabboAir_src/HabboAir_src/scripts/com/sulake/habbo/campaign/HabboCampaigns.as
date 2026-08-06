package com.sulake.habbo.campaign
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.campaign.calendar.CalendarView;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.campaign.CampaignCalendarDataMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.campaign.CampaignCalendarDoorOpenedMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.campaign.OpenCampaignCalendarDoorAsStaffComposer;
   import com.sulake.habbo.communication.messages.outgoing.campaign.OpenCampaignCalendarDoorComposer;
   import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarData;
   import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarDataMessageParser;
   import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarDoorOpenedMessageParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   
   public class HabboCampaigns extends Component implements ILinkEventTracker
   {
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _catalog:IHabboCatalog;
      
      private var _roomEngine:IRoomEngine;
      
      private var UnknownVarFromHabboCampaigns_CalendarView_1:CalendarView;
      
      private var _calendarData:CampaignCalendarData;
      
      private var UnknownVarFromHabboCampaigns_Int_1:int = -1;
      
      private var UnknownVarFromHabboCampaigns_Boolean_1:Boolean = false;
      
      public function HabboCampaigns(param1:IComponent_2, param2:uint, param3:IAssetLibraryCollection)
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
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         if(false && UnknownVarFromHabboCampaigns_Boolean_1)
         {
            _calendarData = new CampaignCalendarData();
            _calendarData.campaignDays = 24;
            _calendarData.currentDay = 5;
            _calendarData.campaignName = "summer";
            _calendarData.openedDays = new <int>[0,1];
            _calendarData.missedDays = new <int>[2,3];
            showCalendar();
         }
         _communicationManager.addHabboConnectionMessageEvent(new CampaignCalendarDataMessageEvent(onCampaignCalendarDataMessageEvent));
         _communicationManager.addHabboConnectionMessageEvent(new CampaignCalendarDoorOpenedMessageEvent(onCampaignCalendarDoorOpenedMessageEvent));
         context.addLinkEventTracker(this);
      }
      
      private function onCampaignCalendarDataMessageEvent(param1:CampaignCalendarDataMessageEvent) : void
      {
         if(false && UnknownVarFromHabboCampaigns_Boolean_1)
         {
            return;
         }
         var _loc2_:CampaignCalendarDataMessageParser = param1.getParser();
         _calendarData = _loc2_.cloneData();
      }
      
      private function onCampaignCalendarDoorOpenedMessageEvent(param1:CampaignCalendarDoorOpenedMessageEvent) : void
      {
         var _loc2_:CampaignCalendarDoorOpenedMessageParser = param1.getParser();
         if(_loc2_.doorOpened)
         {
            showProductNotification(_loc2_.productName,_loc2_.customImage,_loc2_.furnitureClassName);
         }
      }
      
      public function openPackage(param1:int) : void
      {
         UnknownVarFromHabboCampaigns_Int_1 = param1;
         if(false && UnknownVarFromHabboCampaigns_Boolean_1)
         {
            showProductNotification("A1 KUMIANKKA","","duck");
         }
         else
         {
            _communicationManager.connection.send(new OpenCampaignCalendarDoorComposer(_calendarData.campaignName,param1));
         }
      }
      
      public function openPackageAsStaff(param1:int) : void
      {
         UnknownVarFromHabboCampaigns_Int_1 = param1;
         if(false && UnknownVarFromHabboCampaigns_Boolean_1)
         {
            showProductNotification("hween_c15_evilcrystal2","targetedoffers/web_offer_credits_small.png","hween_c15_evilcrystal2");
         }
         else
         {
            _communicationManager.connection.send(new OpenCampaignCalendarDoorAsStaffComposer(_calendarData.campaignName,param1));
         }
      }
      
      private function showProductNotification(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:IProductData = _sessionDataManager.getProductData(param1);
         if(_loc4_ != null)
         {
            _calendarData.openedDays.push(UnknownVarFromHabboCampaigns_Int_1);
            UnknownVarFromHabboCampaigns_Int_1 = -1;
            if(param2 && param2 != "")
            {
               UnknownVarFromHabboCampaigns_CalendarView_1.setReceivedProduct(_loc4_,getImageGalleryUrl() + param2);
            }
            else if(param3 && param3 != "")
            {
               UnknownVarFromHabboCampaigns_CalendarView_1.setReceivedProduct(_loc4_);
               requestIconFromRoomEngine(UnknownVarFromHabboCampaigns_CalendarView_1,param3);
            }
         }
      }
      
      private function requestIconFromRoomEngine(param1:UnknownIHabboRoom1, param2:String) : UnknownHabboRoom1
      {
         var _loc3_:UnknownHabboRoom1 = null;
         var _loc4_:IFurnitureData = null;
         _loc4_ = _sessionDataManager.getFloorItemDataByName(param2);
         if(_loc4_)
         {
            _loc3_ = _roomEngine.getFurnitureIcon(_loc4_.id,param1);
         }
         else
         {
            _loc4_ = _sessionDataManager.getWallItemDataByName(param2);
            if(_loc4_)
            {
               _loc3_ = _roomEngine.getWallItemIcon(_loc4_.id,param1);
            }
         }
         if(_loc3_ && _loc3_.data)
         {
            param1.imageReady(_loc3_.id,_loc3_.data);
         }
         return _loc3_;
      }
      
      public function get linkPattern() : String
      {
         return "openView/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "calendar")
         {
            showCalendar();
         }
      }
      
      private function showCalendar() : void
      {
         if(!UnknownVarFromHabboCampaigns_CalendarView_1 && _calendarData)
         {
            UnknownVarFromHabboCampaigns_CalendarView_1 = new CalendarView(this,_windowManager);
         }
      }
      
      public function hideCalendar() : void
      {
         if(UnknownVarFromHabboCampaigns_CalendarView_1)
         {
            UnknownVarFromHabboCampaigns_CalendarView_1.dispose();
            UnknownVarFromHabboCampaigns_CalendarView_1 = null;
         }
      }
      
      private function getImageGalleryUrl() : String
      {
         return getProperty("image.library.url");
      }
      
      public function get calendarData() : CampaignCalendarData
      {
         return _calendarData;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         return _sessionDataManager.isAnyRoomController;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
   }
}


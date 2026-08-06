package com.sulake.habbo.campaign.calendar
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.campaign.HabboCampaigns;
   import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarData;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.IModalDialog;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.events.Event;
   
   public class CalendarView implements UnknownIHabboRoom1
   {
      private static const MARGIN:int = 75;
      
      private var UnknownVarFromCalendarView_HabboCampaigns_1:HabboCampaigns;
      
      private var UnknownVarFromCalendarView_IModalDialog_1:IModalDialog;
      
      private var UnknownVarFromCalendarView_Int_1:int = -1;
      
      private var _itemsOnScreen:int;
      
      public function CalendarView(param1:HabboCampaigns, param2:IHabboWindowManagerComponent)
      {
         var _loc7_:int = 0;
         var _loc5_:IWindowController_1 = null;
         super();
         UnknownVarFromCalendarView_HabboCampaigns_1 = param1;
         UnknownVarFromCalendarView_IModalDialog_1 = param2.buildModalDialogFromXML(XML(UnknownVarFromCalendarView_HabboCampaigns_1.assets.getAssetByName("campaign_calendar_xml").content));
         if(!UnknownVarFromCalendarView_IModalDialog_1 || !UnknownVarFromCalendarView_IModalDialog_1.rootWindow || !itemList)
         {
            return;
         }
         var _loc3_:IWindowController_1 = itemList.getListItemAt(0) as IWindowController_1;
         itemList.removeListItems();
         var _loc6_:int = calendarData.campaignDays;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = CalendarItem.populateItem(_loc3_,calendarData,_loc7_);
            _loc5_.procedure = onInput;
            itemList.addListItem(_loc5_);
            _loc7_++;
         }
         var _loc4_:Stage = UnknownVarFromCalendarView_HabboCampaigns_1.context.displayObjectContainer.stage;
         _loc4_.addEventListener("resize",onResize);
         window.procedure = onInput;
         onResize(null);
         setSelectedIndex(UnknownVarFromCalendarView_HabboCampaigns_1.calendarData.currentDay);
      }
      
      public function dispose() : void
      {
         var _loc1_:Stage = null;
         if(UnknownVarFromCalendarView_IModalDialog_1 != null)
         {
            _loc1_ = UnknownVarFromCalendarView_HabboCampaigns_1.context.displayObjectContainer.stage;
            _loc1_.removeEventListener("resize",onResize);
            UnknownVarFromCalendarView_IModalDialog_1.dispose();
            UnknownVarFromCalendarView_IModalDialog_1 = null;
         }
      }
      
      public function setReceivedProduct(param1:IProductData, param2:String = null) : void
      {
         setInfoText("${campaign.calendar.heading.product.received}",param1.name);
         updateThumbnail(param2);
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         updateThumbnail(param2);
      }
      
      private function updateThumbnail(param1:Object) : void
      {
         var _loc2_:IWindowController_1 = itemList.getListItemAt(UnknownVarFromCalendarView_Int_1) as IWindowController_1;
         if(!_loc2_)
         {
            return;
         }
         CalendarItem.updateThumbnail(_loc2_,param1);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function hide() : void
      {
         UnknownVarFromCalendarView_HabboCampaigns_1.hideCalendar();
      }
      
      private function onResize(param1:Event) : void
      {
         var _loc2_:Stage = UnknownVarFromCalendarView_HabboCampaigns_1.context.displayObjectContainer.stage;
         _itemsOnScreen = Math.floor((_loc2_.stageWidth - 75 * 2) / (itemWidth + itemGap));
         UnknownVarFromCalendarView_IModalDialog_1.rootWindow.width = calculateItemListWidth(_itemsOnScreen);
         var _loc3_:IWindowModel = window.findChildByName("btn_forward");
         if(_loc3_)
         {
            _loc3_.x = scrollerWidth - window.findChildByName("btn_back").x - _loc3_.width;
         }
         _loc3_ = window.findChildByName("calendar_scrollbar");
         if(_loc3_)
         {
            _loc3_.width = scrollerWidth;
         }
         window.center();
         if(UnknownVarFromCalendarView_Int_1 > -1)
         {
            setSelectedIndex(UnknownVarFromCalendarView_Int_1);
         }
      }
      
      private function onInput(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:int = 0;
         if(param1.type != "WME_DOWN")
         {
            return;
         }
         switch(param2.name)
         {
            case "btn_present":
               _loc3_ = itemList.getListItemIndex(param1.target.parent);
               if(_loc3_ < 0)
               {
                  return;
               }
               if(_loc3_ != UnknownVarFromCalendarView_Int_1)
               {
                  setSelectedIndex(_loc3_);
               }
               else
               {
                  UnknownVarFromCalendarView_HabboCampaigns_1.openPackage(UnknownVarFromCalendarView_Int_1);
               }
               break;
            case "btn_back":
               setSelectedIndex(UnknownVarFromCalendarView_Int_1 - 1);
               break;
            case "btn_forward":
               setSelectedIndex(UnknownVarFromCalendarView_Int_1 + 1);
               break;
            case "btn_force_open":
               UnknownVarFromCalendarView_HabboCampaigns_1.openPackageAsStaff(UnknownVarFromCalendarView_Int_1);
               break;
            case "header_button_close":
               hide();
         }
      }
      
      private function setSelectedIndex(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc2_:IWindowController_1 = null;
         var _loc7_:UnknownICoreWindowComponents4 = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         if(param1 < 0 || param1 >= calendarData.campaignDays)
         {
            return;
         }
         UnknownVarFromCalendarView_Int_1 = param1;
         itemList.scrollH = calculateCenteredItemScrollH(UnknownVarFromCalendarView_Int_1);
         _loc6_ = 0;
         while(_loc6_ < calendarData.campaignDays)
         {
            _loc2_ = itemList.getListItemAt(_loc6_) as IWindowController_1;
            CalendarItem.updateState(_loc2_,calendarData,_loc6_,param1);
            _loc6_++;
         }
         CalendarSpinnerUtil.createGradients(this,UnknownVarFromCalendarView_Int_1);
         if(UnknownVarFromCalendarView_HabboCampaigns_1.isAnyRoomController)
         {
            _loc7_ = window.findChildByName("btn_force_open") as UnknownICoreWindowComponents4;
            _loc7_.visible = true;
         }
         var _loc3_:int = CalendarItem.resolveDayState(calendarData,param1);
         if(UnknownVarFromCalendarView_Int_1 < 0)
         {
            setInfoText(null,null);
            if(_loc7_)
            {
               _loc7_.disable();
            }
         }
         else
         {
            switch(_loc3_ - 1)
            {
               case 0:
                  _loc5_ = "${campaign.calendar.info.unlocked}";
                  break;
               case 1:
                  _loc5_ = "${campaign.calendar.info.available.desktop}";
                  break;
               case 2:
                  _loc5_ = "${campaign.calendar.info.expired}";
                  break;
               case 3:
                  _loc5_ = "${campaign.calendar.info.future}";
            }
            _loc4_ = UnknownVarFromCalendarView_HabboCampaigns_1.localizationManager.getLocalization("campaign.calendar.heading.day") || "";
            _loc4_ = _loc4_.replace("%number%",UnknownVarFromCalendarView_Int_1 + 1);
            setInfoText(_loc4_,_loc5_);
            if(_loc7_)
            {
               if(_loc3_ != 1)
               {
                  _loc7_.enable();
               }
               else
               {
                  _loc7_.disable();
               }
            }
         }
      }
      
      private function setInfoText(param1:String, param2:String) : void
      {
         (window.findChildByName("info_heading") as ITextWindow).text = param1 || "";
         (window.findChildByName("info_body") as ITextWindow).text = param2 || "";
      }
      
      private function startItemWiggle(param1:int) : void
      {
      }
      
      public function get window() : IFrameController
      {
         return !!UnknownVarFromCalendarView_IModalDialog_1 ? UnknownVarFromCalendarView_IModalDialog_1.rootWindow as IFrameController : null;
      }
      
      private function getItemIndexAt(param1:int) : int
      {
         return Math.floor((itemList.scrollH * itemList.maxScrollH + param1) / ((itemList.maxScrollH + scrollerWidth) / itemList.numListItems));
      }
      
      private function calculateCenteredItemScrollH(param1:int) : Number
      {
         return (calculateItemListWidth(param1) - (scrollerWidth - itemWidth) * 0.5) / itemList.maxScrollH;
      }
      
      public function calculateItemListWidth(param1:int) : Number
      {
         return param1 * itemWidth + Math.max(0,param1 - 1) * itemGap;
      }
      
      public function get itemList() : IItemListWindow
      {
         return !!window ? window.findChildByName("calendar_itemlist") as IItemListWindow : null;
      }
      
      public function get itemWidth() : int
      {
         return itemList && itemList.numListItems > 0 ? itemList.getListItemAt(0).width : 0;
      }
      
      public function get itemGap() : int
      {
         return !!itemList ? itemList.spacing : 0;
      }
      
      public function get scrollerWidth() : int
      {
         return window && window.content ? window.content.width : 0;
      }
      
      private function get calendarData() : CampaignCalendarData
      {
         return UnknownVarFromCalendarView_HabboCampaigns_1.calendarData;
      }
   }
}


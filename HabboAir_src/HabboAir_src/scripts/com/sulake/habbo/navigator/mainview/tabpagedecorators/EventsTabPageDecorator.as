package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNavigator;
   
   public class EventsTabPageDecorator implements ITabPageDecorator
   {
      private var _navigator:HabboNavigator;
      
      private var UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1:IDropBaseController_1;
      
      public function EventsTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function refreshCustomContent(param1:IWindowController_1) : void
      {
         var _loc2_:IWindowController_1 = param1.getChildByName("room_ad_header") as IWindowController_1;
         if(UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1 == null || Boolean(UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.disposed))
         {
            UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1 = _loc2_.getChildByName("roomAdFilter") as IDropBaseController_1;
            prepareFilter();
            UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.addEventListener("WE_SELECTED",onFilterSelected);
         }
         _loc2_.visible = true;
      }
      
      public function tabSelected() : void
      {
         if(UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1 != null && !UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.disposed)
         {
            UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.removeEventListener("WE_SELECTED",onFilterSelected);
            UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.selection = 0;
            UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.addEventListener("WE_SELECTED",onFilterSelected);
         }
      }
      
      public function refreshFooter(param1:IWindowController_1) : void
      {
         var _loc2_:IWindowController_1 = param1.getChildByName("room_ads_footer") as IWindowController_1;
         var _loc3_:IWindowModel = _loc2_.findChildByName("get_event_but");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onGetEventClick);
         }
         _loc2_.visible = true;
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         startSearch();
      }
      
      private function prepareFilter() : void
      {
         if(UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1 == null || Boolean(UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.disposed))
         {
            return;
         }
         var _loc1_:Array = [];
         _loc1_.push(_navigator.getText("navigator.roomad.topads"));
         _loc1_.push(_navigator.getText("navigator.roomad.newads"));
         UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.populate(_loc1_);
         UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.selection = 0;
      }
      
      private function onFilterSelected(param1:WindowEvent) : void
      {
         startSearch();
      }
      
      private function onGetEventClick(param1:WindowEvent) : void
      {
         _navigator.openCatalogRoomAdsPage();
      }
      
      private function startSearch() : void
      {
         var _loc1_:int = 16;
         if(UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1 != null && !UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.disposed)
         {
            _loc1_ = getSearchType(UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.selection);
         }
         _navigator.mainViewCtrl.startSearch(1,_loc1_);
      }
      
      private function getSearchType(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 16;
            case 1:
               return 17;
            default:
               Logger.log("Invalid index when searching Room ad search type: " + param1);
               return 0;
         }
      }
      
      public function get filterCategory() : String
      {
         if(UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1 == null || Boolean(UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.disposed))
         {
            return null;
         }
         return UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.enumerateSelection()[UnknownVarFromEventsTabPageDecorator_IDropBaseController_1_1.selection];
      }
      
      public function setSubSelection(param1:int) : void
      {
      }
      
      public function processSearchParam(param1:String) : String
      {
         return param1;
      }
   }
}


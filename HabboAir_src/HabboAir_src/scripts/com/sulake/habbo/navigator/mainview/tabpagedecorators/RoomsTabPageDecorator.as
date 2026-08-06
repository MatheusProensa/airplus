package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.events.*;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   import com.sulake.habbo.navigator.HabboNavigator;
   
   public class RoomsTabPageDecorator implements ITabPageDecorator
   {
      private var _navigator:HabboNavigator;
      
      private var UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1:IDropBaseController_1;
      
      private var UnknownVarFromRoomsTabPageDecorator_Boolean_1:Boolean = false;
      
      public function RoomsTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function refreshCustomContent(param1:IWindowController_1) : void
      {
         var _loc2_:String = "rooms_header";
         var _loc3_:IWindowController_1 = param1.getChildByName(_loc2_) as IWindowController_1;
         if(UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1 == null || Boolean(UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.disposed))
         {
            UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1 = IDropBaseController_1(_loc3_.findChildByName("roomCtgFilter"));
            prepareRoomCategories();
            UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.addEventListener("WE_SELECTED",onFilterSelected);
         }
         _loc3_.visible = true;
      }
      
      public function prepareRoomCategories() : void
      {
         if(UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1 == null || Boolean(UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.disposed))
         {
            return;
         }
         var _loc1_:Array = [_navigator.getText("navigator.navisel.popularrooms"),_navigator.getText("navigator.navisel.highestscore")];
         UnknownVarFromRoomsTabPageDecorator_Boolean_1 = _navigator.context.configuration.getBoolean("navigator.2014.personalized.navigator");
         if(UnknownVarFromRoomsTabPageDecorator_Boolean_1)
         {
            _loc1_.push(_navigator.getText("navigator.navisel.recommendedrooms"));
         }
         for each(var _loc2_ in _navigator.data.visibleCategories)
         {
            _loc1_.push(_loc2_.nodeName);
         }
         UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.populate(_loc1_);
         UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.selection = defaultSelection;
      }
      
      private function get defaultSelection() : int
      {
         return UnknownVarFromRoomsTabPageDecorator_Boolean_1 ? 2 : 0;
      }
      
      public function tabSelected() : void
      {
         if(UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1 != null && !UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.disposed)
         {
            UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.removeEventListener("WE_SELECTED",onFilterSelected);
            UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.selection = defaultSelection;
            UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.addEventListener("WE_SELECTED",onFilterSelected);
         }
      }
      
      public function refreshFooter(param1:IWindowController_1) : void
      {
         _navigator.officialRoomEntryManager.refreshAdFooter(param1);
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         startSearch();
      }
      
      private function onFilterSelected(param1:WindowEvent) : void
      {
         startSearch();
      }
      
      private function startSearch() : void
      {
         var _loc3_:int = 0;
         var _loc4_:FlatCategory = null;
         var _loc1_:int = 0;
         var _loc2_:int = UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1 && !UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.disposed ? UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.selection : defaultSelection;
         Logger.log("Room filter changed: " + _loc2_);
         if(_loc2_ == 0)
         {
            _navigator.mainViewCtrl.startSearch(2,1);
         }
         else if(_loc2_ == 1)
         {
            _navigator.mainViewCtrl.startSearch(2,2);
         }
         else if(_loc2_ == 2 && UnknownVarFromRoomsTabPageDecorator_Boolean_1)
         {
            _navigator.mainViewCtrl.startSearch(2,22);
         }
         else
         {
            _loc3_ = 2;
            if(UnknownVarFromRoomsTabPageDecorator_Boolean_1)
            {
               _loc3_++;
            }
            _loc4_ = _navigator.data.visibleCategories[_loc2_ - _loc3_];
            if(_loc4_ == null)
            {
               Logger.log("No fc found: " + _loc2_ + ", " + _navigator.data.visibleCategories.length);
               return;
            }
            _loc1_ = _loc4_.nodeId;
            Logger.log("Searching with catId: " + _loc1_);
            _navigator.mainViewCtrl.startSearch(2,1,"" + _loc1_);
         }
         if(UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1 && !UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.disposed)
         {
            _navigator.trackNavigationDataPoint(UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.enumerateSelection()[UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.selection],"category.view");
         }
      }
      
      public function get filterCategory() : String
      {
         return UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1 && !UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.disposed ? UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.enumerateSelection()[UnknownVarFromRoomsTabPageDecorator_IDropBaseController_1_1.selection] : null;
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


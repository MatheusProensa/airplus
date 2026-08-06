package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNavigator;
   
   public class SearchTabPageDecorator implements ITabPageDecorator
   {
      private var _navigator:HabboNavigator;
      
      public function SearchTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function refreshCustomContent(param1:IWindowController_1) : void
      {
         refreshRoomCompetitionsHeader(param1);
      }
      
      public function tabSelected() : void
      {
      }
      
      public function refreshFooter(param1:IWindowController_1) : void
      {
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         _navigator.mainViewCtrl.open();
      }
      
      public function get filterCategory() : String
      {
         return null;
      }
      
      private function refreshRoomCompetitionsHeader(param1:IWindowController_1) : void
      {
         var _loc2_:IWindowController_1 = param1.getChildByName("room_competitions_header") as IWindowController_1;
         if(_navigator.data == null || _navigator.data.competitionRoomsData == null)
         {
            _loc2_.visible = false;
            return;
         }
         var _loc6_:int = _navigator.data.competitionRoomsData.pageIndex;
         var _loc4_:int = _navigator.data.competitionRoomsData.pageCount;
         var _loc5_:int = _loc6_ + 1;
         if(_loc4_ < 2)
         {
            _loc2_.visible = false;
            return;
         }
         _loc2_.visible = true;
         _navigator.registerParameter("navigator.roomcompetitionspager","page","" + _loc5_);
         _navigator.registerParameter("navigator.roomcompetitionspager","total","" + _loc4_);
         var _loc3_:IWindowModel = _loc2_.findChildByName("next_button");
         var _loc7_:IWindowModel = _loc2_.findChildByName("prev_button");
         _loc3_.visible = _loc5_ < _loc4_;
         _loc7_.visible = _loc5_ > 1;
         _loc3_.procedure = onNextButton;
         _loc7_.procedure = onPrevButton;
      }
      
      private function onNextButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK" && _navigator.data.competitionRoomsData != null)
         {
            _navigator.performCompetitionRoomsSearch(_navigator.data.competitionRoomsData.goalId,_navigator.data.competitionRoomsData.pageIndex + 1);
         }
      }
      
      private function onPrevButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK" && _navigator.data.competitionRoomsData != null)
         {
            _navigator.performCompetitionRoomsSearch(_navigator.data.competitionRoomsData.goalId,_navigator.data.competitionRoomsData.pageIndex - 1);
         }
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


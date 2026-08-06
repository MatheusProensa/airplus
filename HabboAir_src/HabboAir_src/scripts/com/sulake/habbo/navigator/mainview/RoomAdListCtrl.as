package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdEventTabAdClickedComposer;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.Util;
   
   public class RoomAdListCtrl extends GuestRoomListCtrl
   {
      public function RoomAdListCtrl(param1:HabboNavigator, param2:int, param3:Boolean)
      {
         super(param1,param2,param3);
      }
      
      override protected function getListEntry(param1:int) : IWindowController_1
      {
         var _loc2_:IWindowController_1 = IWindowController_1(_navigator.getXmlWindow("grs_room_ads_details_phase_one"));
         _loc2_.background = true;
         _loc2_.addEventListener("WME_MOVE",onMouseMove);
         _loc2_.addEventListener("WME_OVER",onMouseOver);
         _loc2_.addEventListener("WME_OUT",onMouseOut);
         _loc2_.addEventListener("WME_CLICK",onMouseClick);
         _loc2_.setParamFlag(1,true);
         _loc2_.setParamFlag(128,true);
         _loc2_.color = getBgColor(param1);
         _loc2_.tags.push(param1);
         return _loc2_;
      }
      
      override protected function refreshEntryDetails(param1:IWindowController_1, param2:GuestRoomData) : void
      {
         param1.visible = true;
         var _loc3_:ITextWindow = ITextWindow(param1.getChildByName("adname"));
         _loc3_.visible = true;
         Util.cutTextToWidth(_loc3_,param2.roomAdName,param1.width);
         _navigator.refreshButton(param1,"doormode_doorbell_small",param2.doorMode == 1,null,0);
         _navigator.refreshButton(param1,"doormode_password_small",param2.doorMode == 2,null,0);
         _navigator.refreshButton(param1,"doormode_invisible_small",param2.doorMode == 3,null,0);
         UnknownVarFromGuestRoomListCtrl_UserCountRenderer_1.refreshUserCount(param2.maxUserCount,param1,param2.userCount,"${navigator.usercounttooltip.users}",308,2);
      }
      
      private function getRoomAt(param1:int) : GuestRoomData
      {
         return getRooms()[param1];
      }
      
      override protected function onMouseClick(param1:WindowEvent) : void
      {
         var _loc4_:IWindowModel = param1.target;
         var _loc3_:int = int(_loc4_.tags[0]);
         var _loc2_:GuestRoomData = getRoomAt(_loc3_);
         if(_navigator)
         {
            _navigator.send(new RoomAdEventTabAdClickedComposer(_loc2_.flatId,_loc2_.roomAdName,_loc2_.roomAdExpiresInMin));
         }
         super.onMouseClick(param1);
      }
   }
}


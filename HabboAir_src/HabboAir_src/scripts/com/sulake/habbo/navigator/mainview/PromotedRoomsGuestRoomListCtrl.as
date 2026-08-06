package com.sulake.habbo.navigator.mainview
{
   import com.sulake.habbo.communication.messages.incoming.navigator.PromotedRoomCategoryData;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.domain.RoomSessionTags;
   
   public class PromotedRoomsGuestRoomListCtrl extends GuestRoomListCtrl
   {
      private var UnknownVarFromPromotedRoomsGuestRoomListCtrl_PromotedRoomCategoryData_1:PromotedRoomCategoryData;
      
      public function PromotedRoomsGuestRoomListCtrl(param1:HabboNavigator)
      {
         super(param1,-6,false);
      }
      
      public function set category(param1:PromotedRoomCategoryData) : void
      {
         UnknownVarFromPromotedRoomsGuestRoomListCtrl_PromotedRoomCategoryData_1 = param1;
      }
      
      override public function getRooms() : Array
      {
         return UnknownVarFromPromotedRoomsGuestRoomListCtrl_PromotedRoomCategoryData_1.rooms;
      }
      
      override public function beforeEnterRoom(param1:int) : void
      {
         navigator.data.roomSessionTags = new RoomSessionTags(UnknownVarFromPromotedRoomsGuestRoomListCtrl_PromotedRoomCategoryData_1.code,"" + (param1 + 2));
      }
   }
}


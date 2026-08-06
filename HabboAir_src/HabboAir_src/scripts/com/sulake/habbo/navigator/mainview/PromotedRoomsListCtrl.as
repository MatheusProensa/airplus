package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.PromotedRoomCategoryData;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.navigator.*;
   import com.sulake.habbo.navigator.domain.RoomSessionTags;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   
   public class PromotedRoomsListCtrl implements IComponentInterfaceQueue
   {
      private static const CATEGORY_SPACING:int = 5;
      
      private var _navigator:HabboNavigator;
      
      private var UnknownVarFromPromotedRoomsListCtrl_UserCountRenderer_1:UserCountRenderer;
      
      private var UnknownVarFromPromotedRoomsListCtrl_PromotedRoomsGuestRoomListCtrl_1:PromotedRoomsGuestRoomListCtrl;
      
      public function PromotedRoomsListCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         UnknownVarFromPromotedRoomsListCtrl_UserCountRenderer_1 = new UserCountRenderer(_navigator);
         UnknownVarFromPromotedRoomsListCtrl_PromotedRoomsGuestRoomListCtrl_1 = new PromotedRoomsGuestRoomListCtrl(_navigator);
      }
      
      public function dispose() : void
      {
         _navigator = null;
         if(UnknownVarFromPromotedRoomsListCtrl_UserCountRenderer_1)
         {
            UnknownVarFromPromotedRoomsListCtrl_UserCountRenderer_1.dispose();
            UnknownVarFromPromotedRoomsListCtrl_UserCountRenderer_1 = null;
         }
         if(UnknownVarFromPromotedRoomsListCtrl_PromotedRoomsGuestRoomListCtrl_1)
         {
            UnknownVarFromPromotedRoomsListCtrl_PromotedRoomsGuestRoomListCtrl_1.dispose();
            UnknownVarFromPromotedRoomsListCtrl_PromotedRoomsGuestRoomListCtrl_1 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      private function getCategoryContainer(param1:IWindowController_1, param2:int) : IWindowController_1
      {
         return IWindowController_1(param1.getChildByID(param2));
      }
      
      public function refresh(param1:IWindowController_1, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:IWindowController_1 = null;
         Util.hideChildren(param1);
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = getCategoryContainer(param1,_loc4_);
            if(_loc5_ == null)
            {
               _loc5_ = createEntry(_loc4_);
               _loc5_.id = _loc4_;
               param1.addChild(_loc5_);
            }
            refreshEntry(_loc5_,param2[_loc4_]);
            _loc5_.y = _loc3_;
            _loc3_ += _loc5_.height + 5;
            _loc5_.visible = true;
            _loc4_++;
         }
         param1.height = Util.getLowestPoint(param1) > 0 ? Util.getLowestPoint(param1) + 5 : 0;
      }
      
      public function createEntry(param1:int) : IWindowController_1
      {
         var _loc2_:IWindowController_1 = IWindowController_1(_navigator.getXmlWindow("grs_promoted_room_category"));
         setProcedureAndId(_loc2_,param1,"enter_room_button",onEnterRoomButton);
         setProcedureAndId(_loc2_,param1,"leader_region",onLeaderRegion);
         setProcedureAndId(_loc2_,param1,"toggle_open_region",onToggleOpenRegion);
         _navigator.refreshButton(_loc2_,"navi_room_icon",true,null,0);
         return _loc2_;
      }
      
      private function getLocationAfter(param1:IWindowController_1, param2:String, param3:int = 3) : int
      {
         var _loc4_:IWindowModel = param1.findChildByName(param2);
         return _loc4_.x + _loc4_.width + param3;
      }
      
      private function setProcedureAndId(param1:IWindowController_1, param2:int, param3:String, param4:Function) : void
      {
         param1.findChildByName(param3).procedure = param4;
         param1.findChildByName(param3).id = param2;
      }
      
      public function refreshEntry(param1:IWindowController_1, param2:PromotedRoomCategoryData) : void
      {
         var _loc4_:String = _navigator.getText("promotedroomcategory." + param2.code);
         param1.findChildByName("category_name_txt").caption = _loc4_;
         param1.findChildByName("category_header").width = param1.findChildByName("category_name_txt").width + 13;
         _navigator.registerParameter("navigator.promotedrooms.hidetopten","category",_loc4_);
         _navigator.registerParameter("navigator.promotedrooms.viewtopten","category",_loc4_);
         param1.findChildByName("open_txt").caption = _navigator.getText("navigator.promotedrooms.viewtopten");
         param1.findChildByName("close_txt").caption = _navigator.getText("navigator.promotedrooms.hidetopten");
         param1.findChildByName("room_name_txt").caption = param2.bestRoom.roomName;
         var _loc3_:IWindowModel = param1.findChildByName("leader_name_txt");
         _loc3_.caption = param2.bestRoom.showOwner ? param2.bestRoom.ownerName : "";
         _loc3_.x = getLocationAfter(param1,"leader_name_caption_txt",0);
         param1.findChildByName("arrow_down_icon").visible = param2.open;
         param1.findChildByName("arrow_right_icon").visible = !param2.open;
         param1.findChildByName("close_txt").visible = param2.open;
         param1.findChildByName("open_txt").visible = !param2.open;
         param1.findChildByName("arrow_down_icon").x = getLocationAfter(param1,"close_txt");
         param1.findChildByName("arrow_right_icon").x = getLocationAfter(param1,"open_txt");
         UnknownVarFromPromotedRoomsListCtrl_UserCountRenderer_1.refreshUserCount(param2.bestRoom.maxUserCount,IWindowController_1(param1.findChildByName("enter_room_button")),param2.bestRoom.userCount,"${navigator.usercounttooltip.users}",222,35);
         refreshAvatarImage(param1,param2);
         param1.findChildByName("item_list").visible = param2.open;
         if(param2.open)
         {
            param1.findChildByName("item_list").height = param2.rooms.length * 17;
            UnknownVarFromPromotedRoomsListCtrl_PromotedRoomsGuestRoomListCtrl_1.content = param1;
            UnknownVarFromPromotedRoomsListCtrl_PromotedRoomsGuestRoomListCtrl_1.category = param2;
            UnknownVarFromPromotedRoomsListCtrl_PromotedRoomsGuestRoomListCtrl_1.refresh();
         }
         param1.height = param2.open ? Util.getLowestPoint(param1) + 3 : 90;
      }
      
      private function onEnterRoomButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:PromotedRoomCategoryData = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = findCategory(param2);
            _navigator.data.roomSessionTags = new RoomSessionTags(_loc3_.code,"1");
            _navigator.goToPrivateRoom(_loc3_.bestRoom.flatId);
            _navigator.closeNavigator();
         }
      }
      
      private function onLeaderRegion(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:PromotedRoomCategoryData = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = findCategory(param2);
            _navigator.trackGoogle("extendedProfile","navigator_promotedRoom");
            _navigator.send(new GetExtendedProfileMessageComposer(_loc3_.bestRoom.ownerId));
         }
      }
      
      private function onToggleOpenRegion(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:int = 0;
         var _loc5_:PromotedRoomCategoryData = null;
         var _loc3_:PromotedRoomCategoryData = null;
         if(param1.type == "WME_CLICK")
         {
            while(_loc4_ < _navigator.data.promotedRooms.entries.length)
            {
               _loc5_ = _navigator.data.promotedRooms.entries[_loc4_];
               if(param2.id != _loc4_)
               {
                  _loc5_.open = false;
               }
               _loc4_++;
            }
            _loc3_ = findCategory(param2);
            _loc3_.toggleOpen();
            _navigator.mainViewCtrl.refresh();
         }
      }
      
      private function findCategory(param1:IWindowModel) : PromotedRoomCategoryData
      {
         return _navigator.data.promotedRooms.entries[param1.id];
      }
      
      private function refreshAvatarImage(param1:IWindowController_1, param2:PromotedRoomCategoryData) : void
      {
         var _loc3_:IWidgetWindowController = IWidgetWindowController(param1.findChildByName("avatar_image_widget"));
         var _loc4_:IAvatarImageWidget = IAvatarImageWidget(_loc3_.widget);
         _loc4_.figure = param2.leaderFigure;
      }
   }
}


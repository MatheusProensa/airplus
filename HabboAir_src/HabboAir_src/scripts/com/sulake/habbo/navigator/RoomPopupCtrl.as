package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.utils.ExtendedProfileIcon;
   import com.sulake.habbo.utils.FriendlyTime;
   
   public class RoomPopupCtrl extends PopupCtrl
   {
      private var _details:IWindowController_1;
      
      private var UnknownVarFromRoomPopupCtrl_GuestRoomData_1:GuestRoomData;
      
      private var UnknownVarFromRoomPopupCtrl_TagRenderer_1:TagRenderer;
      
      private var _navigator:IHabboNavigator_2;
      
      private var UnknownVarFromRoomPopupCtrl_GuildInfoCtrl_1:GuildInfoCtrl;
      
      public function RoomPopupCtrl(param1:IHabboNavigator_2, param2:int, param3:int)
      {
         super(HabboNavigator(param1),param2,param3,"grs_guest_room_details_long");
         _navigator = param1;
         UnknownVarFromRoomPopupCtrl_TagRenderer_1 = new TagRenderer(param1,hideInstantly);
         UnknownVarFromRoomPopupCtrl_GuildInfoCtrl_1 = new GuildInfoCtrl(_navigator);
      }
      
      public function set room(param1:GuestRoomData) : void
      {
         UnknownVarFromRoomPopupCtrl_GuestRoomData_1 = param1;
      }
      
      override public function refreshContent(param1:IWindowController_1) : void
      {
         if(_details == null)
         {
            _details = IWindowController_1(param1.findChildByName("details_container"));
         }
         _details.visible = true;
         UnknownVarFromRoomPopupCtrl_TagRenderer_1.useHashTags = true;
         Util.hideChildren(_details);
         UnknownVarFromRoomPopupCtrl_GuildInfoCtrl_1.refresh(_details,UnknownVarFromRoomPopupCtrl_GuestRoomData_1);
         refreshRoomName(_details,UnknownVarFromRoomPopupCtrl_GuestRoomData_1);
         refreshOwnerName();
         refreshTextWithCaption("roomctg",_details,getRoomCtg(UnknownVarFromRoomPopupCtrl_GuestRoomData_1.categoryId));
         refreshRoomDesc(_details,UnknownVarFromRoomPopupCtrl_GuestRoomData_1);
         refreshExtraCont();
         refreshEventInfo(UnknownVarFromRoomPopupCtrl_GuestRoomData_1);
         refreshRoomSettings();
         refreshInfo(_details,"trading_allowed",UnknownVarFromRoomPopupCtrl_GuestRoomData_1.tradeMode == 2);
         refreshInfo(_details,"doormode_doorbell",UnknownVarFromRoomPopupCtrl_GuestRoomData_1.doorMode == 1);
         refreshInfo(_details,"doormode_password",UnknownVarFromRoomPopupCtrl_GuestRoomData_1.doorMode == 2);
         refreshInfo(_details,"doormode_invisible",UnknownVarFromRoomPopupCtrl_GuestRoomData_1.doorMode == 3);
         Util.moveChildrenToColumn(_details,["guild_info","roomname","roomctg_cont","roomowner_cont","roomdesc","extra_cont","doormode_doorbell","doormode_password","doormode_invisible","trading_allowed","eventinfo_cont","roomsettings_cont"],0,0);
         _details.findChildByName("guild_info").x = 2;
         _details.height = Util.getLowestPoint(_details);
      }
      
      private function refreshOwnerName() : void
      {
         var _loc1_:ITextWindow = ITextWindow(_details.findChildByName("roomowner"));
         var _loc2_:IRegionWindow = IRegionWindow(_details.findChildByName("roomowner_cont"));
         _loc2_.procedure = onOwnerName;
         _loc1_.caption = UnknownVarFromRoomPopupCtrl_GuestRoomData_1.showOwner ? UnknownVarFromRoomPopupCtrl_GuestRoomData_1.ownerName : "";
         _loc2_.visible = UnknownVarFromRoomPopupCtrl_GuestRoomData_1.showOwner && UnknownVarFromRoomPopupCtrl_GuestRoomData_1.ownerName != "" && UnknownVarFromRoomPopupCtrl_GuestRoomData_1.ownerName != "-";
         ExtendedProfileIcon.setUserInfoState(false,_loc2_);
         Util.layoutChildrenInArea(_loc2_,1000,10,2);
      }
      
      private function refreshRoomSettings() : void
      {
         var _loc2_:IRegionWindow = null;
         var _loc1_:ITextWindow = null;
         var _loc3_:Boolean = true;
         if(_loc3_)
         {
            _loc2_ = IRegionWindow(_details.findChildByName("roomsettings_cont"));
            _loc1_ = ITextWindow(_details.findChildByName("roomsettings"));
            _loc2_.procedure = onRoomSettings;
            _loc2_.visible = _loc3_ && _navigator.sessionData.userId == UnknownVarFromRoomPopupCtrl_GuestRoomData_1.ownerId;
            Util.layoutChildrenInArea(_loc2_,1000,10,2);
         }
      }
      
      private function refreshExtraCont() : void
      {
         var _loc1_:IWindowController_1 = IWindowController_1(_details.findChildByName("extra_cont"));
         Util.hideChildren(_loc1_);
         UnknownVarFromRoomPopupCtrl_TagRenderer_1.refreshTags(_loc1_,UnknownVarFromRoomPopupCtrl_GuestRoomData_1.tags);
         if(UnknownVarFromRoomPopupCtrl_GuestRoomData_1.score > 0)
         {
            refreshTextWithCaption("rating",_loc1_,"" + UnknownVarFromRoomPopupCtrl_GuestRoomData_1.score);
            _loc1_.findChildByName("rating_cont").visible = true;
         }
         if(Util.hasVisibleChildren(_loc1_))
         {
            Util.moveChildrenToColumn(_loc1_,["tags","startedat_cont","rating_cont"],0,3);
            _loc1_.height = Util.getLowestPoint(_loc1_) + 4;
            _loc1_.visible = true;
         }
      }
      
      private function refreshEventInfo(param1:GuestRoomData) : void
      {
         if(param1.roomAdName == null || param1.roomAdName.length == 0)
         {
            return;
         }
         var _loc2_:IWindowController_1 = IWindowController_1(_details.findChildByName("eventinfo_cont"));
         Util.hideChildren(_loc2_);
         var _loc4_:ITextWindow = ITextWindow(_loc2_.findChildByName("eventinfo_name"));
         var _loc7_:ITextWindow = ITextWindow(_loc2_.findChildByName("eventinfo_desc"));
         var _loc3_:ITextWindow = ITextWindow(_loc2_.findChildByName("eventinfo_expirationtime"));
         var _loc6_:ITextWindow = ITextWindow(_loc2_.findChildByName("eventinfo.caption"));
         _loc4_.caption = param1.roomAdName;
         _loc7_.caption = param1.roomAdDescription;
         _loc3_.caption = FriendlyTime.getFriendlyTime(_navigator.localization,param1.roomAdExpiresInMin * 60);
         _loc7_.height = _loc7_.textHeight + 10;
         _loc3_.y = _loc7_.y + _loc7_.height;
         _loc2_.height = _loc4_.height + _loc7_.height + _loc3_.height + 20;
         var _loc5_:IWindowController_1 = _loc2_.findChildByName("eventinfo_child_container") as IWindowController_1;
         _loc5_.x = _loc6_.textWidth + 5;
         _loc5_.height = Util.getLowestPoint(_loc5_) + 5;
         _loc2_.visible = true;
         _loc6_.visible = true;
         _loc5_.visible = true;
      }
      
      private function refreshRoomName(param1:IWindowController_1, param2:GuestRoomData) : void
      {
         var _loc3_:ITextWindow = ITextWindow(param1.getChildByName("roomname"));
         _loc3_.visible = true;
         _loc3_.text = param2.roomName;
         _loc3_.height = _loc3_.textHeight + 3;
      }
      
      private function refreshRoomDesc(param1:IWindowController_1, param2:GuestRoomData) : void
      {
         if(param2.description == "")
         {
            return;
         }
         var _loc3_:String = "roomdesc";
         var _loc4_:ITextWindow = ITextWindow(param1.getChildByName(_loc3_));
         _loc4_.text = param2.description;
         _loc4_.height = _loc4_.textHeight + 10;
         _loc4_.y = Util.getLowestPoint(param1);
         _loc4_.visible = true;
      }
      
      private function refreshTextWithCaption(param1:String, param2:IWindowController_1, param3:String) : void
      {
         var _loc5_:IWindowController_1 = IWindowController_1(param2.findChildByName(param1 + "_cont"));
         _loc5_.visible = true;
         var _loc6_:ITextWindow = ITextWindow(_loc5_.getChildByName(param1));
         var _loc4_:ITextWindow = ITextWindow(_loc5_.getChildByName(param1 + ".caption"));
         _loc6_.text = param3;
         Util.moveChildrenToRow(_loc5_,[param1 + ".caption",param1],_loc4_.x,0,2);
      }
      
      private function refreshInfo(param1:IWindowController_1, param2:String, param3:Boolean) : void
      {
         if(!param3)
         {
            return;
         }
         var _loc4_:IWindowController_1 = IWindowController_1(param1.findChildByName(param2));
         _loc4_.visible = true;
         navigator.refreshButton(_loc4_,param2,true,null,0);
      }
      
      private function getEventCtg(param1:int) : String
      {
         var _loc3_:String = "roomevent_type_" + param1;
         var _loc2_:String = navigator.getText(_loc3_);
         return _loc2_ == null ? "" : _loc2_;
      }
      
      private function getRoomCtg(param1:int) : String
      {
         for each(var _loc2_ in navigator.data.allCategories)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_.nodeName;
            }
         }
         return "";
      }
      
      private function onOwnerName(param1:WindowEvent, param2:IWindowModel) : void
      {
         ExtendedProfileIcon.onEntry(param1,param2);
         if(param1.type == "WME_CLICK")
         {
            _navigator.trackGoogle("extendedProfile","navigator_roomPopup");
            _navigator.send(new GetExtendedProfileMessageComposer(UnknownVarFromRoomPopupCtrl_GuestRoomData_1.ownerId));
            this.hideInstantly();
         }
      }
      
      private function onRoomSettings(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.trackGoogle("roomInfo","editRoomSettings");
            _navigator.roomSettingsCtrl.startRoomSettingsEditFromNavigator(UnknownVarFromRoomPopupCtrl_GuestRoomData_1.flatId,UnknownVarFromRoomPopupCtrl_GuestRoomData_1.habboGroupId);
            this.hideInstantly();
         }
      }
   }
}


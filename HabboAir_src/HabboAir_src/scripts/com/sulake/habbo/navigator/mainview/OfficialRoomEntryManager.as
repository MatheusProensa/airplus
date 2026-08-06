package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
   import com.sulake.habbo.navigator.IHabboNavigator_2;
   import com.sulake.habbo.navigator.UserCountRenderer;
   import com.sulake.habbo.navigator.Util;
   import flash.display.BitmapData;
   
   public class OfficialRoomEntryManager implements IComponentInterfaceQueue
   {
      private static const HOTTEST_GROUPS_TAG:String = "hottest_groups";
      
      private static const IMAGE_WIDTH_WIDE:int = 267;
      
      private static const IMAGE_WIDTH_NARROW:int = 65;
      
      private static const NARROW_IMAGE_OFFSET:int = -70;
      
      private var _disposed:Boolean;
      
      private var _navigator:IHabboNavigator_2;
      
      private var UnknownVarFromOfficialRoomEntryManager_UserCountRenderer_1:UserCountRenderer;
      
      public function OfficialRoomEntryManager(param1:IHabboNavigator_2)
      {
         super();
         _navigator = param1;
         UnknownVarFromOfficialRoomEntryManager_UserCountRenderer_1 = new UserCountRenderer(_navigator);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromOfficialRoomEntryManager_UserCountRenderer_1)
         {
            UnknownVarFromOfficialRoomEntryManager_UserCountRenderer_1.dispose();
            UnknownVarFromOfficialRoomEntryManager_UserCountRenderer_1 = null;
         }
         _disposed = true;
      }
      
      public function refreshAdFooter(param1:IWindowController_1) : void
      {
         if(_navigator.data.adRoom == null)
         {
            return;
         }
         var _loc4_:String = "ad_footer";
         var _loc5_:IWindowController_1 = IWindowController_1(param1.getChildByName("ad_footer"));
         var _loc2_:IWindowController_1 = IWindowController_1(_loc5_.getChildByName("ad_cont"));
         if(_loc2_.numChildren < 1)
         {
            _loc2_.addChild(createEntry(true));
         }
         var _loc3_:IWindowController_1 = IWindowController_1(_loc2_.getChildAt(0));
         refreshEntry(_loc3_,true,_navigator.data.adRoom);
         _loc5_.visible = true;
         _navigator.data.adIndex++;
      }
      
      public function createEntry(param1:Boolean) : IWindowController_1
      {
         var _loc3_:IBitmapWrapperController = null;
         var _loc4_:IWindowController_1 = IWindowController_1(_navigator.getXmlWindow("grs_official_room_row_phase_one"));
         var _loc5_:IWindowController_1 = IWindowController_1(_loc4_.findChildByName("image_cont"));
         var _loc2_:String = !param1 ? "_b" : "";
         _navigator.refreshButton(_loc5_,"rico_rnd_l" + _loc2_,true,null,0);
         _navigator.refreshButton(_loc5_,"rico_rnd_r" + _loc2_,true,null,0);
         _loc3_ = _loc5_.findChildByName("rico_rnd_m") as IBitmapWrapperController;
         _loc3_.bitmap = _navigator.getButtonImage("rico_rnd_m");
         _loc3_.disposesBitmap = false;
         var _loc6_:IWindowController_1 = IWindowController_1(_loc4_.findChildByName("folder_cont"));
         _navigator.refreshButton(_loc6_,"rico_rnd_l" + _loc2_,true,null,0);
         _navigator.refreshButton(_loc6_,"rico_rnd_r" + _loc2_,true,null,0);
         _loc3_ = _loc6_.findChildByName("rico_rnd_m") as IBitmapWrapperController;
         _loc3_.bitmap = _navigator.getButtonImage("rico_rnd_m");
         _loc3_.disposesBitmap = false;
         _loc4_.addEventListener("WME_OVER",onCellMouseOver);
         _loc4_.addEventListener("WME_OUT",onCellMouseOut);
         _loc4_.addEventListener("WME_CLICK",onCellMouseClick);
         _loc4_.color = param1 ? 4294967295 : 4292797682;
         return _loc4_;
      }
      
      public function refreshEntry(param1:IWindowController_1, param2:Boolean, param3:OfficialRoomEntryData) : void
      {
         Util.hideChildren(param1);
         if(param2)
         {
            param1.id = param3.index;
            if(param3.type == 4)
            {
               refreshFolderEntry(param1,param3);
            }
            else
            {
               refreshNormalEntry(param1,param3);
            }
            param1.visible = true;
         }
         else
         {
            param1.height = 0;
            param1.visible = false;
         }
      }
      
      private function refreshNormalEntry(param1:IWindowController_1, param2:OfficialRoomEntryData) : void
      {
         refreshCell(param1,param2);
         refreshDetails(param1,param2);
         refreshUserCount(param1,param2);
         param1.height = 68;
      }
      
      private function refreshFolderEntry(param1:IWindowController_1, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:IWindowController_1 = IWindowController_1(param1.findChildByName("folder_cont"));
         _loc3_.visible = true;
         var _loc5_:ITextWindow = ITextWindow(_loc3_.findChildByName("folder_name_text"));
         _loc5_.text = param2.popupCaption;
         var _loc6_:ITextWindow = ITextWindow(_loc3_.findChildByName("arrow_label"));
         _loc6_.text = param2.open ? "${navigator.folder.hide}" : "${navigator.folder.show}";
         _navigator.refreshButton(_loc3_,"arrow_down_white",param2.open,null,0);
         _navigator.refreshButton(_loc3_,"arrow_right_white",!param2.open,null,0);
         this.refreshFolderImage(_loc3_,param2);
         param1.height = 68;
         var _loc4_:IWindowController_1 = IWindowController_1(param1.findChildByName("folderNameContainer"));
         if(_loc5_.text == "")
         {
            _loc4_.visible = false;
            return;
         }
         _loc4_.visible = true;
         if(!_navigator.isPerkAllowed("NAVIGATOR_PHASE_ONE_2014"))
         {
            _loc4_.width = _loc5_.textWidth + 20;
         }
      }
      
      private function refreshUserCount(param1:IWindowController_1, param2:OfficialRoomEntryData) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         if(param2.showDetails && param2.type == 2)
         {
            _loc4_ = 3;
            _loc3_ = 34;
            _loc5_ = 13;
            UnknownVarFromOfficialRoomEntryManager_UserCountRenderer_1.refreshUserCount(param2.maxUsers,param1,param2.userCount,"${navigator.usercounttooltip.users}",param1.width - _loc4_ - _loc3_,param1.height - _loc4_ - _loc5_);
         }
      }
      
      private function refreshCell(param1:IWindowController_1, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:IWindowController_1 = IWindowController_1(param1.findChildByName("image_cont"));
         _loc3_.visible = true;
         _loc3_.width = param2.showDetails ? 65 : 267;
         refreshPicText(_loc3_,param2);
         refreshRoomImage(_loc3_,param2);
      }
      
      private function refreshPicText(param1:IWindowController_1, param2:OfficialRoomEntryData) : void
      {
         var _loc6_:IWindowController_1 = IWindowController_1(param1.findChildByName("picTextContainer"));
         if(param2.picText == "" || param2.showDetails)
         {
            _loc6_.visible = false;
            return;
         }
         var _loc3_:int = 5;
         _loc6_.visible = true;
         var _loc4_:ITextWindow = ITextWindow(_loc6_.findChildByName("picText"));
         _loc4_.text = param2.picText;
         _loc4_.height = _loc4_.textHeight + 10;
         var _loc5_:* = _loc4_.textHeight > 10;
         _loc6_.height = _loc4_.height + 4;
      }
      
      private function refreshFolderImage(param1:IWindowController_1, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:IBitmapWrapperController = IBitmapWrapperController(param1.findChildByName("folder_image"));
         _loc3_.visible = false;
         if(param2.picRef != "")
         {
            refreshCustomImage(param2,_loc3_);
         }
      }
      
      private function refreshRoomImage(param1:IWindowController_1, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:IBitmapWrapperController = IBitmapWrapperController(param1.findChildByName("room_image"));
         _loc3_.visible = false;
         if(param2.picRef != "")
         {
            refreshCustomImage(param2,_loc3_);
         }
         else if(param2.guestRoomData != null)
         {
            refreshGuestRoomImage(param1,param2,_loc3_);
         }
         else
         {
            refreshEmptyImage(param1,param2,_loc3_);
         }
      }
      
      private function refreshCustomImage(param1:OfficialRoomEntryData, param2:IBitmapWrapperController) : void
      {
         var _loc4_:String = "customImage." + param1.picRef;
         if(param2.tags[0] == _loc4_)
         {
            param2.visible = true;
            return;
         }
         Logger.log("Loading custom image: " + param1.picRef);
         param2.x = 0;
         param2.visible = false;
         var _loc3_:OfficialRoomImageLoader = new OfficialRoomImageLoader(_navigator,param1.picRef,param2);
         _loc3_.startLoad();
         param2.tags.splice(0,param2.tags.length);
         param2.tags.push(_loc4_);
      }
      
      private function refreshGuestRoomImage(param1:IWindowController_1, param2:OfficialRoomEntryData, param3:IBitmapWrapperController) : void
      {
         var _loc4_:String = "guestRoom." + param2.guestRoomData.thumbnail.getAsString();
         if(param3.tags[0] == _loc4_)
         {
            param3.visible = true;
            return;
         }
         Logger.log("Redrawing guest room image");
         param3.x = 0;
         param3.width = 64;
         param3.bitmap = new BitmapData(64,64);
         param3.bitmap.fillRect(param3.bitmap.rect,4294967295);
         param3.tags.splice(0,param3.tags.length);
         param3.tags.push(_loc4_);
         param3.visible = true;
      }
      
      private function refreshEmptyImage(param1:IWindowController_1, param2:OfficialRoomEntryData, param3:IBitmapWrapperController) : void
      {
         var _loc4_:String = "empty";
         if(param3.tags[0] == _loc4_)
         {
            param3.visible = true;
            return;
         }
         Logger.log("Redrawing empty image");
         param3.x = 0;
         param3.width = 64;
         param3.bitmap = new BitmapData(64,64,false,4291611852);
         param3.tags.splice(0,param3.tags.length);
         param3.tags.push(_loc4_);
         param3.visible = true;
      }
      
      private function onCellMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = param1.target;
         this.setEnterArrowVisibility(_loc2_,true);
      }
      
      private function onCellMouseOut(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = param1.target;
         this.setEnterArrowVisibility(_loc2_,false);
      }
      
      private function onCellMouseClick(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = param1.target;
         this.handleClick(_loc2_);
      }
      
      private function setEnterArrowVisibility(param1:IWindowModel, param2:Boolean) : void
      {
         var _loc4_:IBitmapWrapperController = null;
         var _loc5_:IWindowController_1 = IWindowController_1(param1);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc3_:IWindowController_1 = IWindowController_1(_loc5_.findChildByName("enter_room"));
         if(_loc3_ == null)
         {
            return;
         }
         if(param2)
         {
            _navigator.refreshButton(_loc3_,"enter_room_l",true,null,0);
            _navigator.refreshButton(_loc3_,"enter_room_r",true,null,0);
            _loc4_ = IBitmapWrapperController(_loc3_.findChildByName("enter_room_m"));
            if(_loc4_.bitmap == null)
            {
               _loc4_.bitmap = _navigator.getButtonImage("enter_room_m");
               _loc4_.disposesBitmap = false;
            }
            _navigator.refreshButton(_loc3_,"enter_room_a",true,null,0);
         }
         _loc3_.visible = param2;
      }
      
      private function handleClick(param1:IWindowModel) : void
      {
         var _loc2_:OfficialRoomEntryData = this.getEntry(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.guestRoomData != null)
         {
            Logger.log("ENTERING ROOM: " + _loc2_.guestRoomData.flatId);
            if(_loc2_.guestRoomData.doorMode == 2)
            {
               _navigator.passwordInput.show(_loc2_.guestRoomData);
            }
            else
            {
               _navigator.goToRoom(_loc2_.guestRoomData.flatId,true);
            }
         }
         else if(_loc2_.tag != null)
         {
            Logger.log("MAKING TAG SEARCH: " + _loc2_.tag);
            if(_loc2_.tag == "hottest_groups")
            {
               _navigator.performGuildBaseSearch();
            }
            else
            {
               _navigator.mainViewCtrl.startSearch(5,9,_loc2_.tag);
            }
         }
         else
         {
            Logger.log("FOLDER CLICKD: " + _loc2_.index);
            _loc2_.toggleOpen();
            this._navigator.mainViewCtrl.refresh();
         }
      }
      
      private function getEntry(param1:IWindowModel) : OfficialRoomEntryData
      {
         var _loc2_:IWindowController_1 = param1 as IWindowController_1;
         if(_loc2_ == null || _loc2_.name != "cont")
         {
            Logger.log("Target not cont");
            return null;
         }
         Logger.log("PARENT NAME: " + param1.parent.name);
         return _loc2_.parent.name == "ad_cont" ? findAdEntry() : findEntryInOfficialRoomList(_loc2_);
      }
      
      private function findAdEntry() : OfficialRoomEntryData
      {
         return _navigator.data.adRoom;
      }
      
      private function findEntryInOfficialRoomList(param1:IWindowController_1) : OfficialRoomEntryData
      {
         if(_navigator.data.officialRooms == null)
         {
            Logger.log("No official rooms data click");
            return null;
         }
         var _loc3_:int = int(param1.id);
         Logger.log("Got index: " + _loc3_);
         for each(var _loc2_ in _navigator.data.officialRooms.entries)
         {
            if(_loc2_.index == _loc3_)
            {
               return _loc2_;
            }
         }
         Logger.log("No room found " + _loc3_ + ", " + _navigator.data.officialRooms.entries.length);
         return null;
      }
      
      private function refreshDetails(param1:IWindowController_1, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:IWindowController_1 = IWindowController_1(param1.findChildByName("details_container"));
         _loc3_.visible = param2.showDetails;
         Logger.log("Refreshing details: " + _loc3_.visible);
         if(!param2.showDetails)
         {
            return;
         }
         Util.hideChildren(_loc3_);
         refreshEntryCaption(_loc3_,param2);
         refreshEntryDesc(_loc3_,param2);
      }
      
      private function refreshEntryCaption(param1:IWindowController_1, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:ITextWindow = ITextWindow(param1.getChildByName("entry_caption"));
         _loc3_.visible = true;
         _loc3_.text = getPopupCaption(param2);
      }
      
      private function refreshEntryDesc(param1:IWindowController_1, param2:OfficialRoomEntryData) : void
      {
         var _loc4_:String = getPopupDesc(param2);
         if(_loc4_ == "")
         {
            return;
         }
         var _loc3_:String = "entry_desc";
         var _loc5_:ITextWindow = ITextWindow(param1.getChildByName(_loc3_));
         _loc5_.text = _loc4_;
         _loc5_.visible = true;
      }
      
      public function getPopupCaption(param1:OfficialRoomEntryData) : String
      {
         if(param1.popupCaption != null && param1.popupCaption != "")
         {
            return param1.popupCaption;
         }
         if(param1.guestRoomData != null)
         {
            return param1.guestRoomData.roomName;
         }
         if(param1.tag != null && param1.tag != "")
         {
            return param1.tag;
         }
         return "NA";
      }
      
      public function getPopupDesc(param1:OfficialRoomEntryData) : String
      {
         if(param1.popupCaption != null && param1.popupCaption != "")
         {
            return param1.popupDesc;
         }
         if(param1.guestRoomData != null)
         {
            return param1.guestRoomData.description;
         }
         return "";
      }
   }
}


package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomData;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomModerationData;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorRoomInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomChatlogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModerateRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModeratorActionMessageComposer;
   
   public class RoomToolCtrl implements IComponentInterfaceQueue, ITrackedWindow
   {
      private var _main:ModerationManager;
      
      private var _flatId:int;
      
      private var UnknownVarFromRoomToolCtrl_RoomModerationData_1:RoomModerationData;
      
      private var _frame:IFrameController;
      
      private var UnknownVarFromRoomToolCtrl_IItemListWindow_1:IItemListWindow;
      
      private var _disposed:Boolean;
      
      private var _msgSelect:IDropBaseController_1;
      
      private var UnknownVarFromRoomToolCtrl_ITextFieldWindow_1:ITextFieldWindow;
      
      private var _includeInfo:Boolean = true;
      
      private var UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_1:UnknownICoreWindowComponents2;
      
      private var UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_2:UnknownICoreWindowComponents2;
      
      private var UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_3:UnknownICoreWindowComponents2;
      
      private var UnknownVarFromRoomToolCtrl_IWindowController_1_1:IWindowController_1;
      
      public function RoomToolCtrl(param1:ModerationManager, param2:int)
      {
         super();
         _main = param1;
         _flatId = param2;
      }
      
      public static function getLowestPoint(param1:IWindowController_1) : int
      {
         var _loc2_:int = 0;
         var _loc4_:IWindowModel = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc2_);
            if(_loc4_.visible)
            {
               _loc3_ = Math.max(_loc3_,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function moveChildrenToColumn(param1:IWindowController_1, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:IWindowModel = null;
         _loc4_ = 0;
         while(_loc4_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc4_);
            if(_loc5_ != null && _loc5_.visible && _loc5_.height > 0)
            {
               _loc5_.y = param2;
               param2 += _loc5_.height + param3;
            }
            _loc4_++;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = IFrameController(_main.getXmlWindow("roomtool_frame"));
         var _loc1_:IItemListWindow = _frame.findChildByName("list_cont") as IItemListWindow;
         var _loc2_:IWindowController_1 = _loc1_.getListItemByName("room_cont") as IWindowController_1;
         UnknownVarFromRoomToolCtrl_IWindowController_1_1 = _loc2_.findChildByName("room_data") as IWindowController_1;
         _loc2_.removeChild(UnknownVarFromRoomToolCtrl_IWindowController_1_1);
         _main.messageHandler.addRoomInfoListener(this);
         _main.connection.send(new GetModeratorRoomInfoMessageComposer(_flatId));
         Logger.log("BEGINNING TO SHOW: " + _flatId);
      }
      
      public function getType() : int
      {
         return 9;
      }
      
      public function getId() : String
      {
         return "" + _flatId;
      }
      
      public function getFrame() : IFrameController
      {
         return _frame;
      }
      
      private function onClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _main.messageHandler.removeRoomEnterListener(this);
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         if(UnknownVarFromRoomToolCtrl_RoomModerationData_1 != null)
         {
            UnknownVarFromRoomToolCtrl_RoomModerationData_1.dispose();
            UnknownVarFromRoomToolCtrl_RoomModerationData_1 = null;
         }
         _main = null;
         UnknownVarFromRoomToolCtrl_IItemListWindow_1 = null;
         _msgSelect = null;
         UnknownVarFromRoomToolCtrl_ITextFieldWindow_1 = null;
         UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_1 = null;
         UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_2 = null;
         UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_3 = null;
      }
      
      public function onRoomChange() : void
      {
         setSendButtonState("send_caution_but");
         setSendButtonState("send_message_but");
      }
      
      private function setSendButtonState(param1:String) : void
      {
         var _loc3_:Boolean = UnknownVarFromRoomToolCtrl_RoomModerationData_1 != null && UnknownVarFromRoomToolCtrl_RoomModerationData_1.flatId == _main.currentFlatId;
         var _loc2_:UnknownICoreWindowComponents4 = UnknownICoreWindowComponents4(_frame.findChildByName(param1));
         if(_loc3_ && _main.initMsg.roomAlertPermission)
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      public function onRoomInfo(param1:RoomModerationData) : void
      {
         if(_disposed)
         {
            return;
         }
         Logger.log("GOT ROOM INFO: " + param1.flatId + ", " + _flatId);
         if(param1.flatId != _flatId)
         {
            Logger.log("NOT THE SAME FLAT: " + param1.flatId + ", " + _flatId);
            return;
         }
         UnknownVarFromRoomToolCtrl_RoomModerationData_1 = param1;
         populate();
         _main.messageHandler.removeRoomInfoListener(this);
         _frame.visible = true;
         _main.messageHandler.addRoomEnterListener(this);
      }
      
      public function populate() : void
      {
         UnknownVarFromRoomToolCtrl_IItemListWindow_1 = IItemListWindow(_frame.findChildByName("list_cont"));
         var _loc1_:IWindowModel = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         UnknownVarFromRoomToolCtrl_ITextFieldWindow_1 = ITextFieldWindow(_frame.findChildByName("message_input"));
         UnknownVarFromRoomToolCtrl_ITextFieldWindow_1.procedure = onInputClick;
         _msgSelect = IDropBaseController_1(_frame.findChildByName("msgTemplatesSelect"));
         prepareMsgSelect(_msgSelect);
         _msgSelect.procedure = onSelectTemplate;
         UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_1 = UnknownICoreWindowComponents2(_frame.findChildByName("kick_check"));
         UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_2 = UnknownICoreWindowComponents2(_frame.findChildByName("lock_check"));
         UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_3 = UnknownICoreWindowComponents2(_frame.findChildByName("changename_check"));
         refreshRoomData(UnknownVarFromRoomToolCtrl_RoomModerationData_1.room,"room_cont");
         setTxt("owner_name_txt",UnknownVarFromRoomToolCtrl_RoomModerationData_1.ownerName);
         setTxt("owner_in_room_txt",UnknownVarFromRoomToolCtrl_RoomModerationData_1.ownerInRoom ? "Yes" : "No");
         setTxt("user_count_txt","" + UnknownVarFromRoomToolCtrl_RoomModerationData_1.userCount);
         _frame.findChildByName("enter_room_but").procedure = onEnterRoom;
         _frame.findChildByName("chatlog_but").procedure = onChatlog;
         _frame.findChildByName("edit_in_hk_but").procedure = onEditInHk;
         _frame.findChildByName("send_caution_but").procedure = onSendCaution;
         _frame.findChildByName("send_message_but").procedure = onSendMessage;
         _main.initMsg.chatlogsPermission ? null : _frame.findChildByName("chatlog_but").disable();
         if(!_main.initMsg.roomKickPermission)
         {
            UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_1.disable();
         }
         _frame.findChildByName("owner_name_txt").procedure = onOwnerName;
         this.onRoomChange();
      }
      
      private function disposeItemFromList(param1:IItemListWindow, param2:IWindowModel) : void
      {
         var _loc3_:IWindowModel = param1.removeListItem(param2);
         if(_loc3_ != null)
         {
            _loc3_.dispose();
         }
      }
      
      private function refreshRoomData(param1:RoomData, param2:String) : void
      {
         var _loc6_:IWindowController_1 = IWindowController_1(UnknownVarFromRoomToolCtrl_IItemListWindow_1.getListItemByName(param2));
         var _loc7_:IWindowController_1 = IWindowController_1(_loc6_.findChildByName("room_data"));
         if(_loc7_ == null)
         {
            _loc7_ = _loc6_.addChild(UnknownVarFromRoomToolCtrl_IWindowController_1_1.clone()) as IWindowController_1;
         }
         if(!param1.exists)
         {
            disposeItemFromList(UnknownVarFromRoomToolCtrl_IItemListWindow_1,_loc6_);
            disposeItemFromList(UnknownVarFromRoomToolCtrl_IItemListWindow_1,UnknownVarFromRoomToolCtrl_IItemListWindow_1.getListItemByName("event_spacing"));
            return;
         }
         var _loc4_:ITextWindow = ITextWindow(_loc7_.findChildByName("name"));
         _loc4_.caption = param1.name;
         _loc4_.height = _loc4_.textHeight + 5;
         var _loc3_:ITextWindow = ITextWindow(_loc7_.findChildByName("desc"));
         _loc3_.caption = param1.desc;
         _loc3_.height = _loc3_.textHeight + 5;
         var _loc5_:IWindowController_1 = IWindowController_1(_loc7_.findChildByName("tags_cont"));
         var _loc8_:ITextWindow = ITextWindow(_loc5_.findChildByName("tags_txt"));
         _loc8_.caption = getTagsAsString(param1.tags);
         _loc8_.height = _loc8_.textHeight + 5;
         _loc5_.height = _loc8_.height;
         if(param1.tags.length < 1)
         {
            _loc7_.removeChild(_loc5_);
         }
         moveChildrenToColumn(_loc7_,_loc4_.y,0);
         _loc7_.height = getLowestPoint(_loc7_);
         _loc6_.height = _loc7_.height + 2 * _loc7_.y;
         Logger.log("XXXX: " + _loc6_.height + ", " + _loc7_.height + ", " + _loc4_.height + ", " + _loc3_.height + ", " + _loc5_.height + ", " + _loc8_.height);
      }
      
      private function getTagsAsString(param1:Array) : String
      {
         var _loc3_:* = null;
         var _loc2_:* = "";
         for each(_loc3_ in param1)
         {
            if(_loc2_ == "")
            {
               _loc2_ = _loc3_;
            }
            else
            {
               _loc2_ = _loc2_ + ", " + _loc3_;
            }
         }
         return _loc2_;
      }
      
      private function setTxt(param1:String, param2:String) : void
      {
         var _loc3_:ITextWindow = ITextWindow(_frame.findChildByName(param1));
         _loc3_.text = param2;
      }
      
      private function onOwnerName(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new UserInfoFrameCtrl(_main,UnknownVarFromRoomToolCtrl_RoomModerationData_1.ownerId),_frame,false,false,true);
      }
      
      private function onEnterRoom(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         Logger.log("Enter room clicked");
         _main.goToRoom(UnknownVarFromRoomToolCtrl_RoomModerationData_1.flatId);
      }
      
      private function onChatlog(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new ChatlogCtrl(new GetRoomChatlogMessageComposer(0,UnknownVarFromRoomToolCtrl_RoomModerationData_1.flatId),_main,4,UnknownVarFromRoomToolCtrl_RoomModerationData_1.flatId),_frame,false,false,true);
      }
      
      private function onEditInHk(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         Logger.log("Edit in hk clicked");
         _main.openHkPage("roomadmin.url","" + UnknownVarFromRoomToolCtrl_RoomModerationData_1.flatId);
      }
      
      private function onSendCaution(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         Logger.log("Sending caution...");
         act(true);
      }
      
      private function onSendMessage(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         Logger.log("Sending message...");
         act(false);
      }
      
      private function act(param1:Boolean) : void
      {
         if(_includeInfo || UnknownVarFromRoomToolCtrl_ITextFieldWindow_1.text == "")
         {
            _main.windowManager.alert("Alert","You must input a message to the user",0,onAlertClose);
            return;
         }
         var _loc2_:int = determineAction(param1,UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_1.isSelected);
         _main.connection.send(new ModeratorActionMessageComposer(_loc2_,UnknownVarFromRoomToolCtrl_ITextFieldWindow_1.text,""));
         if(UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_2.isSelected || Boolean(UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_3.isSelected) || Boolean(UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_1.isSelected))
         {
            _main.connection.send(new ModerateRoomMessageComposer(UnknownVarFromRoomToolCtrl_RoomModerationData_1.flatId,UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_2.isSelected,UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_3.isSelected,UnknownVarFromRoomToolCtrl_UnknownICoreWindowComponents2_1.isSelected));
         }
         this.dispose();
      }
      
      private function determineAction(param1:Boolean, param2:Boolean) : int
      {
         if(param2)
         {
            return param1 ? 1 : 4;
         }
         return param1 ? 0 : 3;
      }
      
      private function onInputClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WE_FOCUSED")
         {
            return;
         }
         if(!_includeInfo)
         {
            return;
         }
         UnknownVarFromRoomToolCtrl_ITextFieldWindow_1.text = "";
         _includeInfo = false;
      }
      
      private function onAlertClose(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function prepareMsgSelect(param1:IDropBaseController_1) : void
      {
         Logger.log("MSG TEMPLATES: " + _main.initMsg.roomMessageTemplates.length);
         param1.populate(_main.initMsg.roomMessageTemplates);
      }
      
      private function onSelectTemplate(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WE_SELECTED")
         {
            return;
         }
         var _loc3_:String = _main.initMsg.roomMessageTemplates[_msgSelect.selection];
         if(_loc3_ != null)
         {
            _includeInfo = false;
            UnknownVarFromRoomToolCtrl_ITextFieldWindow_1.text = _loc3_;
         }
      }
   }
}


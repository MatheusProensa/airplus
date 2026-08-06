package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.SendRoomInviteMessageComposer;
   import com.sulake.habbo.friendlist.domain.Friend;
   
   public class RoomInviteView extends AlertView
   {
      private var _selected:Array;
      
      private var _inputMessage:ITextFieldWindow;
      
      public function RoomInviteView(param1:HabboFriendList)
      {
         super(param1,"room_invite_confirm");
         _selected = param1.categories.getSelectedFriends();
      }
      
      override public function dispose() : void
      {
         _selected = null;
         _inputMessage = null;
         super.dispose();
      }
      
      override internal function setupContent(param1:IWindowController_1) : void
      {
         friendList.registerParameter("friendlist.invite.summary","count","" + _selected.length);
         _inputMessage = ITextFieldWindow(param1.findChildByName("message_input"));
         _inputMessage.addEventListener("WKE_KEY_DOWN",onMessageInput);
         param1.findChildByName("cancel").procedure = onClose;
         param1.findChildByName("ok").procedure = onInvite;
      }
      
      private function onInvite(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         Logger.log("Invite Ok clicked");
         sendMsg();
         dispose();
      }
      
      private function onMessageInput(param1:WindowKeyboardEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:IWindowModel = IWindowModel(param1.target);
         Logger.log("Test key event " + param1 + ", " + param1.type + " " + _loc4_.name);
         if(param1.charCode == 13)
         {
            sendMsg();
         }
         else
         {
            _loc2_ = 120;
            _loc3_ = _inputMessage.text;
            if(_loc3_.length > _loc2_)
            {
               _inputMessage.text = _loc3_.substring(0,_loc2_);
            }
         }
      }
      
      private function sendMsg() : void
      {
         var _loc3_:String = _inputMessage.text;
         Logger.log("Send msg: " + _loc3_);
         if(_loc3_ == "")
         {
            friendList.simpleAlert("${friendlist.invite.emptyalert.title}","${friendlist.invite.emptyalert.text}");
            return;
         }
         var _loc1_:SendRoomInviteMessageComposer = new SendRoomInviteMessageComposer(_loc3_);
         for each(var _loc2_ in _selected)
         {
            _loc1_.addInvitedFriend(_loc2_.id);
         }
         friendList.resetLastRoomInvitationTime();
         friendList.send(_loc1_);
         dispose();
      }
   }
}


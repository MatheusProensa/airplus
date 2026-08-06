package com.sulake.habbo.help.cfh.registry.chat
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   
   public class ChatEventHandler implements IComponentInterfaceQueue
   {
      private var UnknownVarFromChatEventHandler_HabboHelp_1:HabboHelp;
      
      public function ChatEventHandler(param1:HabboHelp)
      {
         super();
         UnknownVarFromChatEventHandler_HabboHelp_1 = param1;
         UnknownVarFromChatEventHandler_HabboHelp_1.roomSessionManager.events.addEventListener("RSCE_CHAT_EVENT",onRoomChat);
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromChatEventHandler_HabboHelp_1)
            {
               UnknownVarFromChatEventHandler_HabboHelp_1.roomSessionManager.events.removeEventListener("RSCE_CHAT_EVENT",onRoomChat);
               UnknownVarFromChatEventHandler_HabboHelp_1 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromChatEventHandler_HabboHelp_1 == null;
      }
      
      private function onRoomChat(param1:RoomSessionChatEvent) : void
      {
         var _loc2_:IUserData = UnknownVarFromChatEventHandler_HabboHelp_1.roomSessionManager.getSession(param1.session.roomId).userDataManager.getUserDataByIndex(param1.userId);
         var _loc3_:GuestRoomData = UnknownVarFromChatEventHandler_HabboHelp_1.navigator.enteredGuestRoomData;
         if(!_loc2_ || _loc2_.type != 1 || !_loc3_)
         {
            return;
         }
         if(UnknownVarFromChatEventHandler_HabboHelp_1.sessionDataManager.isBlocked(_loc2_.webID))
         {
            return;
         }
         var _loc4_:String = !!_loc3_ ? _loc3_.roomName : "Unknown Room";
         var _loc5_:ChatStyle = UnknownVarFromChatEventHandler_HabboHelp_1.freeFlowChat.chatStyleLibrary.getStyle(param1.style) as ChatStyle;
         if(!_loc5_.isNotification)
         {
            UnknownVarFromChatEventHandler_HabboHelp_1.chatRegistry.addItem(param1.session.roomId,_loc4_,_loc2_.webID,_loc2_.name,param1.text);
         }
      }
   }
}


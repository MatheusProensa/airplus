package com.sulake.habbo.freeflowchat.data
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.game.events.GameChatEvent;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IVector3d;
   import flash.utils.getTimer;
   
   public class ChatEventHandler implements IComponentInterfaceQueue
   {
      public static const CHAT_STYLE_SNOWWAR_RED:int = 120;
      
      public static const CHAT_STYLE_SNOWWAR_BLUE:int = 121;
      
      private var UnknownVarFromChatEventHandler_HabboFreeFlowChat_1:HabboFreeFlowChat;
      
      private var UnknownVarFromChatEventHandler_Uint_1:uint = 0;
      
      private var UnknownVarFromChatEventHandler_Uint_2:uint = 0;
      
      public function ChatEventHandler(param1:HabboFreeFlowChat)
      {
         super();
         UnknownVarFromChatEventHandler_HabboFreeFlowChat_1 = param1;
         UnknownVarFromChatEventHandler_HabboFreeFlowChat_1.roomSessionManager.events.addEventListener("RSCE_CHAT_EVENT",onRoomChat);
         if(UnknownVarFromChatEventHandler_HabboFreeFlowChat_1.gameManager)
         {
            UnknownVarFromChatEventHandler_HabboFreeFlowChat_1.gameManager.events.addEventListener("gce_game_chat",gameEventHandler);
         }
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromChatEventHandler_HabboFreeFlowChat_1)
            {
               UnknownVarFromChatEventHandler_HabboFreeFlowChat_1.roomSessionManager.events.removeEventListener("RSCE_CHAT_EVENT",onRoomChat);
               UnknownVarFromChatEventHandler_HabboFreeFlowChat_1.gameManager.events.removeEventListener("gce_game_chat",gameEventHandler);
               UnknownVarFromChatEventHandler_HabboFreeFlowChat_1 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromChatEventHandler_HabboFreeFlowChat_1 == null;
      }
      
      private function onRoomChat(param1:RoomSessionChatEvent) : void
      {
         param1 = UnknownVarFromChatEventHandler_HabboFreeFlowChat_1.windowManager.LilithCustomsInstance.OnRoomChat(param1);
         if(param1.session == null)
         {
            return;
         }
         var _loc3_:IUserData = UnknownVarFromChatEventHandler_HabboFreeFlowChat_1.roomSessionManager.getSession(param1.session.roomId).userDataManager.getUserDataByIndex(param1.userId);
         if(_loc3_ != null && UnknownVarFromChatEventHandler_HabboFreeFlowChat_1.sessionDataManager.isBlocked(_loc3_.webID))
         {
            return;
         }
         var _loc4_:IRoomObject = UnknownVarFromChatEventHandler_HabboFreeFlowChat_1.roomEngine.getRoomObject(param1.session.roomId,param1.userId,100);
         var _loc5_:IVector3d = null;
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.getLocation();
         }
         var _loc2_:uint = uint(getTimer());
         if(_loc2_ == UnknownVarFromChatEventHandler_Uint_1)
         {
            UnknownVarFromChatEventHandler_Uint_2++;
         }
         else
         {
            UnknownVarFromChatEventHandler_Uint_2 = 0;
         }
         UnknownVarFromChatEventHandler_HabboFreeFlowChat_1.insertChat(new ChatItem(param1,_loc2_ + UnknownVarFromChatEventHandler_Uint_2,_loc5_,param1.extraParam));
         UnknownVarFromChatEventHandler_Uint_1 = _loc2_;
      }
      
      private function gameEventHandler(param1:GameChatEvent) : void
      {
         var _loc3_:int = param1.teamId == 1 ? 121 : 120;
         var _loc2_:RoomSessionChatEvent = new RoomSessionChatEvent("RSCE_CHAT_EVENT",null,param1.userId,param1.message,0,_loc3_);
         UnknownVarFromChatEventHandler_HabboFreeFlowChat_1.insertChat(new ChatItem(_loc2_,getTimer(),null,0,param1.locX,param1.color,param1.figure,param1.name));
      }
   }
}


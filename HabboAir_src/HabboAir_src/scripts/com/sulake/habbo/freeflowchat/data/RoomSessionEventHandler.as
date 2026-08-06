package com.sulake.habbo.freeflowchat.data
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   
   public class RoomSessionEventHandler implements IComponentInterfaceQueue
   {
      private var UnknownVarFromRoomSessionEventHandler_HabboFreeFlowChat_1:HabboFreeFlowChat;
      
      public function RoomSessionEventHandler(param1:HabboFreeFlowChat)
      {
         super();
         UnknownVarFromRoomSessionEventHandler_HabboFreeFlowChat_1 = param1;
         UnknownVarFromRoomSessionEventHandler_HabboFreeFlowChat_1.roomSessionManager.events.addEventListener("RSE_CREATED",onRoomSessionCreated);
         UnknownVarFromRoomSessionEventHandler_HabboFreeFlowChat_1.roomSessionManager.events.addEventListener("RSE_ENDED",onRoomSessionEnded);
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromRoomSessionEventHandler_HabboFreeFlowChat_1)
            {
               UnknownVarFromRoomSessionEventHandler_HabboFreeFlowChat_1.roomSessionManager.events.removeEventListener("RSE_CREATED",onRoomSessionCreated);
               UnknownVarFromRoomSessionEventHandler_HabboFreeFlowChat_1.roomSessionManager.events.removeEventListener("RSE_ENDED",onRoomSessionEnded);
               UnknownVarFromRoomSessionEventHandler_HabboFreeFlowChat_1 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromRoomSessionEventHandler_HabboFreeFlowChat_1 == null;
      }
      
      private function onRoomSessionCreated(param1:RoomSessionEvent) : void
      {
         UnknownVarFromRoomSessionEventHandler_HabboFreeFlowChat_1.roomEntered();
      }
      
      private function onRoomSessionEnded(param1:RoomSessionEvent) : void
      {
         UnknownVarFromRoomSessionEventHandler_HabboFreeFlowChat_1.roomLeft();
      }
   }
}


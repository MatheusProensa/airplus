package com.sulake.habbo.help.cfh.registry.instantmessage
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;
   import com.sulake.habbo.help.HabboHelp;
   
   public class InstantMessageEventHandler implements IComponentInterfaceQueue
   {
      private var UnknownVarFromInstantMessageEventHandler_HabboHelp_1:HabboHelp;
      
      public function InstantMessageEventHandler(param1:HabboHelp)
      {
         super();
         UnknownVarFromInstantMessageEventHandler_HabboHelp_1 = param1;
         UnknownVarFromInstantMessageEventHandler_HabboHelp_1.addMessageEvent(new NewConsoleMessageEvent(onInstantMessage));
         UnknownVarFromInstantMessageEventHandler_HabboHelp_1.addMessageEvent(new RoomInviteEvent(onRoomInvite));
      }
      
      public function onInstantMessage(param1:NewConsoleMessageEvent) : void
      {
         var _loc2_:NewConsoleMessageMessageParser = param1.getParser();
         if(_loc2_.chatId < 0)
         {
            UnknownVarFromInstantMessageEventHandler_HabboHelp_1.instantMessageRegistry.addItem(_loc2_.chatId,_loc2_.senderName,_loc2_.messageText);
         }
         else
         {
            UnknownVarFromInstantMessageEventHandler_HabboHelp_1.instantMessageRegistry.addItem(_loc2_.chatId,_loc2_.senderName,_loc2_.messageText);
         }
      }
      
      public function onRoomInvite(param1:RoomInviteEvent) : void
      {
         var _loc2_:RoomInviteMessageParser = param1.getParser();
         UnknownVarFromInstantMessageEventHandler_HabboHelp_1.instantMessageRegistry.addItem(_loc2_.senderId,"",_loc2_.messageText);
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromInstantMessageEventHandler_HabboHelp_1)
            {
               UnknownVarFromInstantMessageEventHandler_HabboHelp_1 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromInstantMessageEventHandler_HabboHelp_1 == null;
      }
   }
}


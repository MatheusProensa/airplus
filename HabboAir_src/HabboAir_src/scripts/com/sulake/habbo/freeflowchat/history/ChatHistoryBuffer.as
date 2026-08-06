package com.sulake.habbo.freeflowchat.history
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.IChatHistoryEntryBitmapBubble;
   
   public class ChatHistoryBuffer implements IComponentInterfaceQueue
   {
      private const MAX_CHAT_ITEMS:int = 1000;
      
      private var UnknownVarFromChatHistoryBuffer_HabboFreeFlowChat_1:HabboFreeFlowChat;
      
      private var _entries:Vector.<IChatHistoryEntryBitmapBubble> = new Vector.<IChatHistoryEntryBitmapBubble>(0);
      
      public function ChatHistoryBuffer(param1:HabboFreeFlowChat)
      {
         super();
         UnknownVarFromChatHistoryBuffer_HabboFreeFlowChat_1 = param1;
      }
      
      public function dispose() : void
      {
         _entries = null;
         UnknownVarFromChatHistoryBuffer_HabboFreeFlowChat_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromChatHistoryBuffer_HabboFreeFlowChat_1 == null;
      }
      
      public function insertChat(param1:ChatItem) : void
      {
         var _loc2_:IChatHistoryEntryBitmapBubble = null;
         try
         {
            _loc2_ = UnknownVarFromChatHistoryBuffer_HabboFreeFlowChat_1.chatBubbleFactory.getHistoryLineEntry(param1);
         }
         catch(e:Error)
         {
            if(e.errorID == 2015)
            {
               return;
            }
            throw e;
         }
         _entries.push(_loc2_);
         checkBufferOverflowAndSpliceTop(_loc2_);
         if(UnknownVarFromChatHistoryBuffer_HabboFreeFlowChat_1.chatHistoryScrollView.isActive)
         {
            UnknownVarFromChatHistoryBuffer_HabboFreeFlowChat_1.chatHistoryScrollView.addHistoryEntry(_entries[_entries.length - 1]);
         }
      }
      
      public function insertRoomChange(param1:GuestRoomData) : void
      {
         var _loc2_:IChatHistoryEntryBitmapBubble = UnknownVarFromChatHistoryBuffer_HabboFreeFlowChat_1.chatBubbleFactory.getHistoryRoomChangeEntry(param1);
         _entries.push(_loc2_);
         checkBufferOverflowAndSpliceTop(_loc2_);
      }
      
      private function checkBufferOverflowAndSpliceTop(param1:IChatHistoryEntryBitmapBubble) : void
      {
         if(_entries.length > 1000)
         {
            UnknownVarFromChatHistoryBuffer_HabboFreeFlowChat_1.chatHistoryScrollView.scrollUpAndSpliceTopItem(param1.bitmap.height - param1.overlap.y - 8);
            _entries.splice(0,1);
         }
      }
      
      public function get entries() : Vector.<IChatHistoryEntryBitmapBubble>
      {
         return _entries;
      }
      
      public function get totalHeight() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in _entries)
         {
            _loc2_ += _loc1_.bitmap.height - _loc1_.overlap.y - 8;
         }
         return _loc2_;
      }
   }
}


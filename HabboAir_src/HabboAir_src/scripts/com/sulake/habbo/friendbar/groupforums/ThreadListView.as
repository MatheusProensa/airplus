package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.habbo.communication.messages.parser.groupforums.ExtendedForumData;
   import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
   
   public class ThreadListView implements IComponentInterfaceQueue
   {
      private static const ITEM_POOL_MAX_SIZE:int = 20;
      
      private static var ITEM_POOL:Vector.<ThreadListItemView> = new Vector.<ThreadListItemView>();
      
      private var UnknownVarFromThreadListView_GroupForumController_1:GroupForumController;
      
      private var UnknownVarFromThreadListView_GroupForumView_1:GroupForumView;
      
      private var UnknownVarFromThreadListView_IScrollableListWindow_1:IScrollableListWindow;
      
      private var UnknownVarFromThreadListView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromThreadListView_Vector_1:Vector.<ThreadListItemView>;
      
      private var UnknownVarFromThreadListView_ExtendedForumData_1:ExtendedForumData;
      
      private var UnknownVarFromThreadListView_ThreadsListData_1:ThreadsListData;
      
      private var _disposed:Boolean;
      
      public function ThreadListView(param1:GroupForumView, param2:IScrollableListWindow, param3:ExtendedForumData, param4:ThreadsListData)
      {
         super();
         UnknownVarFromThreadListView_GroupForumView_1 = param1;
         UnknownVarFromThreadListView_GroupForumController_1 = UnknownVarFromThreadListView_GroupForumView_1.controller;
         UnknownVarFromThreadListView_IScrollableListWindow_1 = param2;
         UnknownVarFromThreadListView_IWindowController_1_1 = UnknownVarFromThreadListView_GroupForumController_1.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_thread_list_item_xml())) as IWindowController_1;
         UnknownVarFromThreadListView_Vector_1 = new Vector.<ThreadListItemView>();
         UnknownVarFromThreadListView_ExtendedForumData_1 = param3;
         UnknownVarFromThreadListView_ThreadsListData_1 = param4;
      }
      
      public function update() : void
      {
         var _loc2_:int = 0;
         var _loc3_:ThreadData = null;
         var _loc1_:ThreadListItemView = null;
         clear();
         UnknownVarFromThreadListView_IScrollableListWindow_1.invalidate();
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromThreadListView_ThreadsListData_1.size)
         {
            _loc3_ = UnknownVarFromThreadListView_ThreadsListData_1.threads[_loc2_];
            _loc1_ = claimView();
            _loc1_.initialize(UnknownVarFromThreadListView_ExtendedForumData_1,UnknownVarFromThreadListView_ThreadsListData_1,_loc3_,_loc2_);
            UnknownVarFromThreadListView_Vector_1.push(_loc1_);
            UnknownVarFromThreadListView_IScrollableListWindow_1.addListItem(_loc1_.window);
            _loc2_++;
         }
         updateItemWidths();
      }
      
      public function updateItemWidths() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromThreadListView_IScrollableListWindow_1.numListItems)
         {
            UnknownVarFromThreadListView_IScrollableListWindow_1.getListItemAt(_loc1_).width = UnknownVarFromThreadListView_IScrollableListWindow_1.scrollableWindow.width - 2;
            _loc1_++;
         }
      }
      
      private function clear() : void
      {
         if(UnknownVarFromThreadListView_IScrollableListWindow_1 != null && UnknownVarFromThreadListView_IScrollableListWindow_1.numListItems > 0)
         {
            UnknownVarFromThreadListView_IScrollableListWindow_1.removeListItems();
         }
         for each(var _loc1_ in UnknownVarFromThreadListView_Vector_1)
         {
            recycleView(_loc1_);
         }
         UnknownVarFromThreadListView_Vector_1.length = 0;
      }
      
      public function updateElement(param1:ThreadData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ThreadListItemView = null;
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromThreadListView_Vector_1.length)
         {
            _loc2_ = UnknownVarFromThreadListView_Vector_1[_loc3_];
            if(_loc2_.threadId == param1.threadId)
            {
               _loc2_.initialize(UnknownVarFromThreadListView_ExtendedForumData_1,UnknownVarFromThreadListView_ThreadsListData_1,param1,_loc3_);
               return;
            }
            _loc3_++;
         }
      }
      
      private function claimView() : ThreadListItemView
      {
         var _loc1_:ThreadListItemView = null;
         if(ITEM_POOL.length > 0)
         {
            _loc1_ = ITEM_POOL.pop();
         }
         else
         {
            _loc1_ = new ThreadListItemView(UnknownVarFromThreadListView_IWindowController_1_1,UnknownVarFromThreadListView_GroupForumView_1);
         }
         _loc1_.bind(UnknownVarFromThreadListView_GroupForumView_1);
         return _loc1_;
      }
      
      private function recycleView(param1:ThreadListItemView) : void
      {
         if(ITEM_POOL.length < 20)
         {
            param1.recycle();
            ITEM_POOL.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         clear();
         if(UnknownVarFromThreadListView_IWindowController_1_1 != null)
         {
            UnknownVarFromThreadListView_IWindowController_1_1.dispose();
            UnknownVarFromThreadListView_IWindowController_1_1 = null;
         }
         UnknownVarFromThreadListView_Vector_1 = null;
         UnknownVarFromThreadListView_ThreadsListData_1 = null;
         UnknownVarFromThreadListView_ExtendedForumData_1 = null;
         UnknownVarFromThreadListView_IScrollableListWindow_1 = null;
         UnknownVarFromThreadListView_GroupForumController_1 = null;
         UnknownVarFromThreadListView_GroupForumView_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}


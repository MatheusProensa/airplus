package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.habbo.communication.messages.parser.groupforums.ForumData;
   
   public class ForumsListView implements IComponentInterfaceQueue
   {
      private static const ITEM_POOL_MAX_SIZE:int = 20;
      
      private static var ITEM_POOL:Vector.<ForumListItemView> = new Vector.<ForumListItemView>();
      
      private var UnknownVarFromForumsListView_GroupForumController_1:GroupForumController;
      
      private var UnknownVarFromForumsListView_GroupForumView_1:GroupForumView;
      
      private var UnknownVarFromForumsListView_IScrollableListWindow_1:IScrollableListWindow;
      
      private var UnknownVarFromForumsListView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromForumsListView_Vector_1:Vector.<ForumListItemView>;
      
      private var _forums:Array;
      
      private var _disposed:Boolean;
      
      public function ForumsListView(param1:GroupForumView, param2:IScrollableListWindow, param3:Array)
      {
         super();
         UnknownVarFromForumsListView_GroupForumView_1 = param1;
         UnknownVarFromForumsListView_GroupForumController_1 = UnknownVarFromForumsListView_GroupForumView_1.controller;
         UnknownVarFromForumsListView_IScrollableListWindow_1 = param2;
         UnknownVarFromForumsListView_IWindowController_1_1 = UnknownVarFromForumsListView_GroupForumController_1.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_forum_list_item_xml())) as IWindowController_1;
         UnknownVarFromForumsListView_Vector_1 = new Vector.<ForumListItemView>();
         _forums = param3;
      }
      
      public function update() : void
      {
         var _loc3_:int = 0;
         var _loc1_:ForumData = null;
         var _loc2_:ForumListItemView = null;
         clear();
         UnknownVarFromForumsListView_IScrollableListWindow_1.invalidate();
         _loc3_ = 0;
         while(_loc3_ < _forums.length)
         {
            _loc1_ = _forums[_loc3_];
            _loc2_ = claimView();
            _loc2_.initialize(_loc1_,_loc3_);
            UnknownVarFromForumsListView_Vector_1.push(_loc2_);
            UnknownVarFromForumsListView_IScrollableListWindow_1.addListItem(_loc2_.window);
            _loc3_++;
         }
         updateItemWidths();
      }
      
      private function clear() : void
      {
         if(UnknownVarFromForumsListView_IScrollableListWindow_1 != null && UnknownVarFromForumsListView_IScrollableListWindow_1.numListItems > 0)
         {
            UnknownVarFromForumsListView_IScrollableListWindow_1.removeListItems();
         }
         for each(var _loc1_ in UnknownVarFromForumsListView_Vector_1)
         {
            recycleView(_loc1_);
         }
         UnknownVarFromForumsListView_Vector_1.length = 0;
      }
      
      public function updateItemWidths() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromForumsListView_IScrollableListWindow_1.numListItems)
         {
            UnknownVarFromForumsListView_IScrollableListWindow_1.getListItemAt(_loc1_).width = UnknownVarFromForumsListView_IScrollableListWindow_1.scrollableWindow.width - 2;
            _loc1_++;
         }
      }
      
      private function claimView() : ForumListItemView
      {
         var _loc1_:ForumListItemView = null;
         if(ITEM_POOL.length > 0)
         {
            _loc1_ = ITEM_POOL.pop();
         }
         else
         {
            _loc1_ = new ForumListItemView(UnknownVarFromForumsListView_IWindowController_1_1,UnknownVarFromForumsListView_GroupForumView_1);
         }
         _loc1_.bind(UnknownVarFromForumsListView_GroupForumView_1);
         return _loc1_;
      }
      
      private function recycleView(param1:ForumListItemView) : void
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
         if(UnknownVarFromForumsListView_IWindowController_1_1 != null)
         {
            UnknownVarFromForumsListView_IWindowController_1_1.dispose();
            UnknownVarFromForumsListView_IWindowController_1_1 = null;
         }
         _forums = null;
         UnknownVarFromForumsListView_Vector_1 = null;
         UnknownVarFromForumsListView_IScrollableListWindow_1 = null;
         UnknownVarFromForumsListView_GroupForumController_1 = null;
         UnknownVarFromForumsListView_GroupForumView_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}


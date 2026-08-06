package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ExtendedForumData;
   import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
   
   public class ThreadListItemView implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean;
      
      private var UnknownVarFromThreadListItemView_GroupForumView_1:GroupForumView;
      
      private var UnknownVarFromThreadListItemView_GroupForumController_1:GroupForumController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromThreadListItemView_IWindowModel_1:IWindowModel;
      
      private var _header:ITextWindow;
      
      private var _headerRegion:IWindowModel;
      
      private var _details:IWindowModel;
      
      private var UnknownVarFromThreadListItemView_IWindowModel_2:IWindowModel;
      
      private var UnknownVarFromThreadListItemView_IWindowModel_3:IWindowModel;
      
      private var _messages1:ITextWindow;
      
      private var _messages2:ITextWindow;
      
      private var _buttonContainer:IWindowController_1;
      
      private var UnknownVarFromThreadListItemView_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromThreadListItemView_IRegionWindow_2:IRegionWindow;
      
      private var UnknownVarFromThreadListItemView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromThreadListItemView_IRegionWindow_3:IRegionWindow;
      
      private var UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_2:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromThreadListItemView_IRegionWindow_4:IRegionWindow;
      
      private var UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_3:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromThreadListItemView_ExtendedForumData_1:ExtendedForumData;
      
      private var UnknownVarFromThreadListItemView_ThreadsListData_1:ThreadsListData;
      
      private var _threadId:int;
      
      public function ThreadListItemView(param1:IWindowController_1, param2:GroupForumView)
      {
         super();
         bind(param2);
         _window = param1.clone() as IWindowController_1;
         UnknownVarFromThreadListItemView_IWindowModel_1 = _window.findChildByName("texts_container");
         _header = _window.findChildByName("header") as ITextWindow;
         _headerRegion = _window.findChildByName("header_region");
         _details = _window.findChildByName("details");
         UnknownVarFromThreadListItemView_IWindowModel_2 = _window.findChildByName("unread_texts_container");
         UnknownVarFromThreadListItemView_IWindowModel_3 = _window.findChildByName("unread_region");
         _messages1 = _window.findChildByName("messages1") as ITextWindow;
         _messages2 = _window.findChildByName("messages2") as ITextWindow;
         _buttonContainer = _window.findChildByName("button_container") as IWindowController_1;
         var _loc3_:IItemListWindow = _buttonContainer.findChildByName("mod_buttons") as IItemListWindow;
         UnknownVarFromThreadListItemView_IRegionWindow_1 = _loc3_.getListItemAt(0) as IRegionWindow;
         UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_1 = UnknownVarFromThreadListItemView_IRegionWindow_1.getChildByName("icon") as IStaticBitmapWrapperWindow;
         UnknownVarFromThreadListItemView_IRegionWindow_2 = _loc3_.getListItemAt(1) as IRegionWindow;
         UnknownVarFromThreadListItemView_IWindowController_1_1 = _window.findChildByName("left_button_container") as IWindowController_1;
         var _loc4_:IItemListWindow = UnknownVarFromThreadListItemView_IWindowController_1_1.findChildByName("info_buttons") as IItemListWindow;
         UnknownVarFromThreadListItemView_IRegionWindow_3 = _loc4_.getListItemByName("thread_lock") as IRegionWindow;
         UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_2 = UnknownVarFromThreadListItemView_IRegionWindow_3.getChildByName("icon") as IStaticBitmapWrapperWindow;
         UnknownVarFromThreadListItemView_IRegionWindow_4 = _loc4_.getListItemByName("thread_pin") as IRegionWindow;
         UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_3 = UnknownVarFromThreadListItemView_IRegionWindow_4.getChildByName("icon") as IStaticBitmapWrapperWindow;
         _headerRegion.addEventListener("WME_CLICK",onGoToFirstUnread);
         UnknownVarFromThreadListItemView_IWindowModel_3.addEventListener("WME_CLICK",onGoToFirstUnread);
         UnknownVarFromThreadListItemView_IRegionWindow_1.addEventListener("WME_CLICK",onDeleteOrUndelete);
         UnknownVarFromThreadListItemView_IRegionWindow_2.addEventListener("WME_CLICK",onReport);
         UnknownVarFromThreadListItemView_IRegionWindow_3.addEventListener("WME_CLICK",onToggleLock);
         UnknownVarFromThreadListItemView_IRegionWindow_4.addEventListener("WME_CLICK",onToggleSticky);
      }
      
      private static function getThreadColor(param1:int, param2:int) : uint
      {
         switch(param1)
         {
            case 10:
               return 4289374890;
            case 20:
               return 4294946981;
            case 0:
            case 1:
         }
         return !!((param2 + 1) % 2) ? 4293852927 : 4289914618;
      }
      
      public function bind(param1:GroupForumView) : void
      {
         UnknownVarFromThreadListItemView_GroupForumView_1 = param1;
         UnknownVarFromThreadListItemView_GroupForumController_1 = UnknownVarFromThreadListItemView_GroupForumView_1.controller;
      }
      
      public function initialize(param1:ExtendedForumData, param2:ThreadsListData, param3:ThreadData, param4:int) : void
      {
         UnknownVarFromThreadListItemView_ExtendedForumData_1 = param1;
         UnknownVarFromThreadListItemView_ThreadsListData_1 = param2;
         _threadId = param3.threadId;
         _window.name = "thread_" + param3.threadId;
         var _loc10_:int = param3.state;
         var _loc8_:Boolean = UnknownVarFromThreadListItemView_ExtendedForumData_1.canModerate;
         var _loc6_:Boolean = UnknownVarFromThreadListItemView_ExtendedForumData_1.isStaff;
         var _loc7_:int = param3.nMessages - UnknownVarFromThreadListItemView_GroupForumController_1.getThreadLastReadMessageIndex(param3.threadId) - 1;
         var _loc5_:uint = getThreadColor(_loc10_,param4);
         UnknownVarFromThreadListItemView_IWindowModel_1.id = param3.threadId;
         UnknownVarFromThreadListItemView_IWindowModel_1.color = _loc5_;
         var _loc9_:String = param3.header;
         if(_loc9_ == "")
         {
            _loc9_ = "(No Subject)";
         }
         if(_loc10_ > 1 && !_loc8_ && !_loc6_)
         {
            _loc9_ = getModerationMessage(param3);
         }
         _header.bold = _loc7_ > 0;
         _header.text = _loc9_;
         _headerRegion.id = param3.threadId;
         _details.caption = UnknownVarFromThreadListItemView_GroupForumController_1.localizationManager.getLocalizationWithParams("groupforum.view.thread_details","","thread_author_id",param3.threadAuthorId,"thread_author_name",param3.threadAuthorName,"last_author_id",param3.lastMessageAuthorId,"last_author_name",param3.lastMessageAuthorName,"creation_time",UnknownVarFromThreadListItemView_GroupForumView_1.getAsDaysHoursMinutes(param3.creationTimeAsSecondsAgo),"update_time",UnknownVarFromThreadListItemView_GroupForumView_1.getAsDaysHoursMinutes(param3.lastMessageTimeAsSecondsAgo));
         UnknownVarFromThreadListItemView_IWindowModel_2.id = param3.threadId;
         UnknownVarFromThreadListItemView_IWindowModel_2.color = _loc5_;
         UnknownVarFromThreadListItemView_IWindowModel_3.id = param3.threadId;
         _messages1.bold = _loc7_ > 0;
         _messages1.text = UnknownVarFromThreadListItemView_GroupForumController_1.localizationManager.getLocalizationWithParams("groupforum.view.thread_details1","","total_messages",param3.nMessages,"new_messages",_loc7_);
         _messages2.bold = _loc7_ > 0;
         _messages2.text = UnknownVarFromThreadListItemView_GroupForumController_1.localizationManager.getLocalizationWithParams("groupforum.view.thread_details2","","total_messages",param3.nMessages,"new_messages",_loc7_);
         _buttonContainer.id = param3.threadId;
         _buttonContainer.color = _loc5_;
         handleButtonVisibility(param3,_loc10_);
         _buttonContainer.color = _loc5_;
         UnknownVarFromThreadListItemView_IWindowController_1_1.id = param3.threadId;
         UnknownVarFromThreadListItemView_IWindowController_1_1.color = _loc5_;
         handleLeftButtonsVisibility(param3);
         UnknownVarFromThreadListItemView_IWindowController_1_1.color = _loc5_;
      }
      
      private function handleButtonVisibility(param1:ThreadData, param2:int) : void
      {
         var _loc5_:Boolean = UnknownVarFromThreadListItemView_ExtendedForumData_1.canModerate;
         var _loc4_:Boolean = UnknownVarFromThreadListItemView_ExtendedForumData_1.isStaff;
         var _loc3_:Boolean = UnknownVarFromThreadListItemView_ExtendedForumData_1.canReport;
         UnknownVarFromThreadListItemView_IRegionWindow_1.visible = true;
         UnknownVarFromThreadListItemView_IRegionWindow_1.enable();
         UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_1.assetUri = "forum_forum_hide";
         if(_loc5_ || _loc4_)
         {
            switch(param2 - 10)
            {
               case 0:
                  UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_1.assetUri = "forum_forum_unhide";
                  break;
               case 10:
                  if(_loc4_)
                  {
                     UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_1.assetUri = "forum_forum_unhide";
                     break;
                  }
                  UnknownVarFromThreadListItemView_IRegionWindow_1.visible = false;
                  UnknownVarFromThreadListItemView_IRegionWindow_1.disable();
                  break;
            }
         }
         else
         {
            UnknownVarFromThreadListItemView_IRegionWindow_1.visible = false;
            UnknownVarFromThreadListItemView_IRegionWindow_1.disable();
         }
         UnknownVarFromThreadListItemView_IRegionWindow_2.visible = _loc5_ || _loc4_ || _loc3_;
         if(UnknownVarFromThreadListItemView_IRegionWindow_2.visible)
         {
            UnknownVarFromThreadListItemView_IRegionWindow_2.enable();
         }
         else
         {
            UnknownVarFromThreadListItemView_IRegionWindow_2.disable();
         }
      }
      
      private function handleLeftButtonsVisibility(param1:ThreadData) : void
      {
         var _loc3_:Boolean = UnknownVarFromThreadListItemView_ExtendedForumData_1.canModerate;
         var _loc2_:Boolean = UnknownVarFromThreadListItemView_ExtendedForumData_1.isStaff;
         UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_2.assetUri = param1.isLocked ? "forum_forum_locked" : "forum_forum_unlocked";
         if(_loc3_ || _loc2_)
         {
            UnknownVarFromThreadListItemView_IRegionWindow_3.visible = true;
            UnknownVarFromThreadListItemView_IRegionWindow_3.enable();
         }
         else
         {
            UnknownVarFromThreadListItemView_IRegionWindow_3.visible = param1.isLocked;
            UnknownVarFromThreadListItemView_IRegionWindow_3.disable();
         }
         UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_3.assetUri = param1.isSticky ? "forum_forum_pinned" : "forum_forum_unpinned";
         if(_loc3_ || _loc2_)
         {
            UnknownVarFromThreadListItemView_IRegionWindow_4.visible = true;
            UnknownVarFromThreadListItemView_IRegionWindow_4.enable();
         }
         else
         {
            UnknownVarFromThreadListItemView_IRegionWindow_4.visible = param1.isSticky;
            UnknownVarFromThreadListItemView_IRegionWindow_4.disable();
         }
      }
      
      private function getModerationMessage(param1:ThreadData) : String
      {
         switch(param1.state - 10)
         {
            case 0:
               return UnknownVarFromThreadListItemView_GroupForumController_1.localizationManager.getLocalizationWithParams("groupforum.view.thread_hidden_by_admin","","admin_name",param1.adminName);
            case 10:
               return UnknownVarFromThreadListItemView_GroupForumController_1.localizationManager.getLocalizationWithParams("groupforum.view.thread_hidden_by_staff","","admin_name",param1.adminName);
            default:
               return null;
         }
      }
      
      private function onToggleLock(param1:WindowMouseEvent) : void
      {
         var _loc2_:ThreadData = UnknownVarFromThreadListItemView_ThreadsListData_1 == null ? null : UnknownVarFromThreadListItemView_ThreadsListData_1.threadsById[_threadId];
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromThreadListItemView_GroupForumController_1.lockThread(UnknownVarFromThreadListItemView_ExtendedForumData_1,_threadId,!_loc2_.isLocked,_loc2_.isSticky);
      }
      
      private function onToggleSticky(param1:WindowMouseEvent) : void
      {
         var _loc2_:ThreadData = UnknownVarFromThreadListItemView_ThreadsListData_1 == null ? null : UnknownVarFromThreadListItemView_ThreadsListData_1.threadsById[_threadId];
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromThreadListItemView_GroupForumController_1.stickThread(UnknownVarFromThreadListItemView_ExtendedForumData_1,_threadId,_loc2_.isLocked,!_loc2_.isSticky);
      }
      
      private function onReport(param1:WindowMouseEvent) : void
      {
         if(_threadId > 0)
         {
            UnknownVarFromThreadListItemView_GroupForumController_1.reportThread(UnknownVarFromThreadListItemView_ExtendedForumData_1,_threadId);
         }
      }
      
      private function onDeleteOrUndelete(param1:WindowMouseEvent) : void
      {
         var _loc2_:ThreadData = UnknownVarFromThreadListItemView_ThreadsListData_1 == null ? null : UnknownVarFromThreadListItemView_ThreadsListData_1.threadsById[_threadId];
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.state == 10 || _loc2_.state == 20 && UnknownVarFromThreadListItemView_ExtendedForumData_1.isStaff)
         {
            UnknownVarFromThreadListItemView_GroupForumController_1.unDeleteThread(UnknownVarFromThreadListItemView_ExtendedForumData_1,_threadId);
         }
         else
         {
            UnknownVarFromThreadListItemView_GroupForumController_1.deleteThread(UnknownVarFromThreadListItemView_ExtendedForumData_1,_threadId);
         }
      }
      
      private function onGoToFirstUnread(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ThreadData = UnknownVarFromThreadListItemView_ThreadsListData_1 == null ? null : UnknownVarFromThreadListItemView_ThreadsListData_1.threadsById[_threadId];
         if(_loc3_ != null)
         {
            _loc2_ = Math.min(UnknownVarFromThreadListItemView_GroupForumController_1.getThreadLastReadMessageIndex(_threadId) + 1,_loc3_.nMessages - 1);
            UnknownVarFromThreadListItemView_GroupForumController_1.goToMessageIndex(UnknownVarFromThreadListItemView_ExtendedForumData_1.groupId,_threadId,_loc2_);
         }
      }
      
      public function recycle() : void
      {
         UnknownVarFromThreadListItemView_ExtendedForumData_1 = null;
         UnknownVarFromThreadListItemView_ThreadsListData_1 = null;
         _threadId = 0;
         _window.name = "";
         UnknownVarFromThreadListItemView_IWindowModel_1.id = 0;
         _headerRegion.id = 0;
         UnknownVarFromThreadListItemView_IWindowModel_2.id = 0;
         UnknownVarFromThreadListItemView_IWindowModel_3.id = 0;
         _buttonContainer.id = 0;
         UnknownVarFromThreadListItemView_IWindowController_1_1.id = 0;
         _header.bold = false;
         _header.text = "";
         _details.caption = "";
         _messages1.bold = false;
         _messages1.text = "";
         _messages2.bold = false;
         _messages2.text = "";
         UnknownVarFromThreadListItemView_IRegionWindow_1.visible = true;
         UnknownVarFromThreadListItemView_IRegionWindow_1.enable();
         UnknownVarFromThreadListItemView_IRegionWindow_2.visible = true;
         UnknownVarFromThreadListItemView_IRegionWindow_2.enable();
         UnknownVarFromThreadListItemView_IRegionWindow_3.visible = true;
         UnknownVarFromThreadListItemView_IRegionWindow_3.enable();
         UnknownVarFromThreadListItemView_IRegionWindow_4.visible = true;
         UnknownVarFromThreadListItemView_IRegionWindow_4.enable();
      }
      
      public function get threadId() : int
      {
         return _threadId;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _headerRegion.removeEventListener("WME_CLICK",onGoToFirstUnread);
         UnknownVarFromThreadListItemView_IWindowModel_3.removeEventListener("WME_CLICK",onGoToFirstUnread);
         UnknownVarFromThreadListItemView_IRegionWindow_1.removeEventListener("WME_CLICK",onDeleteOrUndelete);
         UnknownVarFromThreadListItemView_IRegionWindow_2.removeEventListener("WME_CLICK",onReport);
         UnknownVarFromThreadListItemView_IRegionWindow_3.removeEventListener("WME_CLICK",onToggleLock);
         UnknownVarFromThreadListItemView_IRegionWindow_4.removeEventListener("WME_CLICK",onToggleSticky);
         _window.dispose();
         _window = null;
         UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_3 = null;
         UnknownVarFromThreadListItemView_IRegionWindow_4 = null;
         UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_2 = null;
         UnknownVarFromThreadListItemView_IRegionWindow_3 = null;
         UnknownVarFromThreadListItemView_IWindowController_1_1 = null;
         UnknownVarFromThreadListItemView_IRegionWindow_2 = null;
         UnknownVarFromThreadListItemView_IStaticBitmapWrapperWindow_1 = null;
         UnknownVarFromThreadListItemView_IRegionWindow_1 = null;
         _buttonContainer = null;
         _messages2 = null;
         _messages1 = null;
         UnknownVarFromThreadListItemView_IWindowModel_3 = null;
         UnknownVarFromThreadListItemView_IWindowModel_2 = null;
         _details = null;
         _headerRegion = null;
         _header = null;
         UnknownVarFromThreadListItemView_IWindowModel_1 = null;
         UnknownVarFromThreadListItemView_ThreadsListData_1 = null;
         UnknownVarFromThreadListItemView_ExtendedForumData_1 = null;
         UnknownVarFromThreadListItemView_GroupForumController_1 = null;
         UnknownVarFromThreadListItemView_GroupForumView_1 = null;
         _threadId = 0;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}


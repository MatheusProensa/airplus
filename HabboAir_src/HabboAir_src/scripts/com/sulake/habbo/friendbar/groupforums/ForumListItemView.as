package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ForumData;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class ForumListItemView implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean;
      
      private var UnknownVarFromForumListItemView_GroupForumView_1:GroupForumView;
      
      private var UnknownVarFromForumListItemView_GroupForumController_1:GroupForumController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromForumListItemView_IWindowModel_1:IWindowModel;
      
      private var _header:ITextWindow;
      
      private var _headerRegion:IWindowModel;
      
      private var _details:IWindowModel;
      
      private var UnknownVarFromForumListItemView_IWindowModel_2:IWindowModel;
      
      private var UnknownVarFromForumListItemView_IWindowModel_3:IWindowModel;
      
      private var _messages1:ITextWindow;
      
      private var _messages2:ITextWindow;
      
      private var _badgeWidget:IBadgeImageWidget;
      
      private var _groupId:int;
      
      public function ForumListItemView(param1:IWindowController_1, param2:GroupForumView)
      {
         super();
         bind(param2);
         _window = param1.clone() as IWindowController_1;
         UnknownVarFromForumListItemView_IWindowModel_1 = _window.findChildByName("texts_container");
         _header = _window.findChildByName("header") as ITextWindow;
         _headerRegion = _window.findChildByName("header_region");
         _details = _window.findChildByName("details");
         UnknownVarFromForumListItemView_IWindowModel_2 = _window.findChildByName("unread_texts_container");
         UnknownVarFromForumListItemView_IWindowModel_3 = _window.findChildByName("unread_region");
         _messages1 = _window.findChildByName("messages1") as ITextWindow;
         _messages2 = _window.findChildByName("messages2") as ITextWindow;
         _badgeWidget = IWidgetWindowController(_window.findChildByName("group_icon")).widget as IBadgeImageWidget;
         _headerRegion.addEventListener("WME_CLICK",onOpenForum);
         UnknownVarFromForumListItemView_IWindowModel_3.addEventListener("WME_CLICK",onOpenForum);
      }
      
      public function bind(param1:GroupForumView) : void
      {
         UnknownVarFromForumListItemView_GroupForumView_1 = param1;
         UnknownVarFromForumListItemView_GroupForumController_1 = UnknownVarFromForumListItemView_GroupForumView_1.controller;
      }
      
      public function initialize(param1:ForumData, param2:int) : void
      {
         var _loc3_:int = param1.unreadMessages;
         _groupId = param1.groupId;
         _window.name = "forum_" + param1.groupId;
         _window.color = !!((param2 + 1) % 2) ? 4293852927 : 4289914618;
         UnknownVarFromForumListItemView_IWindowModel_1.id = param1.groupId;
         _headerRegion.id = param1.groupId;
         _header.bold = _loc3_ > 0;
         _header.text = param1.name;
         _details.caption = UnknownVarFromForumListItemView_GroupForumController_1.localizationManager.getLocalizationWithParams("groupforum.view.forum_details","","rating",param1.leaderboardScore,"last_author_id",param1.lastMessageAuthorId,"last_author_name",param1.lastMessageAuthorName,"update_time",UnknownVarFromForumListItemView_GroupForumView_1.getAsDaysHoursMinutes(param1.lastMessageTimeAsSecondsAgo));
         UnknownVarFromForumListItemView_IWindowModel_2.id = param1.groupId;
         UnknownVarFromForumListItemView_IWindowModel_3.id = param1.groupId;
         _messages1.bold = _loc3_ > 0;
         _messages1.text = UnknownVarFromForumListItemView_GroupForumController_1.localizationManager.getLocalizationWithParams("groupforum.view.thread_details1","","total_messages",param1.totalMessages,"new_messages",_loc3_);
         _messages2.bold = _loc3_ > 0;
         _messages2.text = UnknownVarFromForumListItemView_GroupForumController_1.localizationManager.getLocalizationWithParams("groupforum.view.thread_details2","","total_messages",param1.totalMessages,"new_messages",_loc3_);
         _badgeWidget.badgeId = param1.icon;
         _badgeWidget.groupId = param1.groupId;
         _badgeWidget.type = "group";
      }
      
      public function recycle() : void
      {
         _groupId = 0;
         _window.name = "";
         UnknownVarFromForumListItemView_IWindowModel_1.id = 0;
         _headerRegion.id = 0;
         UnknownVarFromForumListItemView_IWindowModel_2.id = 0;
         UnknownVarFromForumListItemView_IWindowModel_3.id = 0;
         _header.bold = false;
         _header.text = "";
         _details.caption = "";
         _messages1.bold = false;
         _messages1.text = "";
         _messages2.bold = false;
         _messages2.text = "";
      }
      
      private function onOpenForum(param1:WindowMouseEvent) : void
      {
         if(_groupId > 0)
         {
            UnknownVarFromForumListItemView_GroupForumController_1.openGroupForum(_groupId);
         }
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
         _headerRegion.removeEventListener("WME_CLICK",onOpenForum);
         UnknownVarFromForumListItemView_IWindowModel_3.removeEventListener("WME_CLICK",onOpenForum);
         _window.dispose();
         _window = null;
         _badgeWidget = null;
         _messages2 = null;
         _messages1 = null;
         UnknownVarFromForumListItemView_IWindowModel_3 = null;
         UnknownVarFromForumListItemView_IWindowModel_2 = null;
         _details = null;
         _headerRegion = null;
         _header = null;
         UnknownVarFromForumListItemView_IWindowModel_1 = null;
         UnknownVarFromForumListItemView_GroupForumController_1 = null;
         UnknownVarFromForumListItemView_GroupForumView_1 = null;
         _groupId = 0;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}


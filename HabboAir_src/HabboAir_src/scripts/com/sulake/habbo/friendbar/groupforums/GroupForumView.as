package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ExtendedForumData;
   import com.sulake.habbo.communication.messages.parser.groupforums.ForumData;
   import com.sulake.habbo.communication.messages.parser.groupforums.MessageData;
   import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class GroupForumView
   {
      private static const UnknownConstFromGroupForumView_Int_1:int = 100;
      
      private var _controller:GroupForumController;
      
      private var UnknownVarFromGroupForumView_ForumsListView_1:ForumsListView;
      
      private var UnknownVarFromGroupForumView_ThreadListView_1:ThreadListView;
      
      private var UnknownVarFromGroupForumView_MessageListView_1:MessageListView;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromGroupForumView_IScrollableListWindow_1:IScrollableListWindow;
      
      private var UnknownVarFromGroupForumView_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromGroupForumView_IWindowModel_2:IWindowModel;
      
      private var UnknownVarFromGroupForumView_IWindowModel_3:IWindowModel;
      
      private var UnknownVarFromGroupForumView_IWindowModel_4:IWindowModel;
      
      private var _txtElement:IWindowModel;
      
      private var UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_1:UnknownICoreWindowComponents5;
      
      private var UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2:UnknownICoreWindowComponents5;
      
      private var UnknownVarFromGroupForumView_IWindowModel_5:IWindowModel;
      
      private var UnknownVarFromGroupForumView_IWindowModel_6:IWindowModel;
      
      private var UnknownVarFromGroupForumView_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromGroupForumView_ForumsListData_1:ForumsListData;
      
      private var UnknownVarFromGroupForumView_ExtendedForumData_1:ExtendedForumData;
      
      private var UnknownVarFromGroupForumView_ThreadsListData_1:ThreadsListData;
      
      private var UnknownVarFromGroupForumView_MessagesListData_1:MessagesListData;
      
      private var UnknownVarFromGroupForumView_Int_1:int = 1;
      
      private var _numOfPages:int = 1;
      
      private var UnknownVarFromGroupForumView_Int_2:int;
      
      public function GroupForumView(param1:GroupForumController)
      {
         super();
         _controller = param1;
         UnknownVarFromGroupForumView_Int_2 = 20;
      }
      
      private static function enable(param1:IWindowModel, param2:Boolean) : void
      {
         if(param2)
         {
            param1.enable();
         }
         else
         {
            param1.disable();
         }
      }
      
      internal static function initTopAreaForForum(param1:IFrameController, param2:ForumData) : IRegionWindow
      {
         var _loc4_:IWindowController_1 = param1.findChildByName("top_part") as IWindowController_1;
         var _loc6_:IWidgetWindowController = IWidgetWindowController(_loc4_.findChildByName("group_icon"));
         _loc6_.visible = true;
         var _loc3_:IBadgeImageWidget = _loc6_.widget as IBadgeImageWidget;
         _loc3_.badgeId = param2.icon;
         _loc3_.groupId = param2.groupId;
         _loc3_.type = "group";
         var _loc8_:IStaticBitmapWrapperWindow = _loc4_.findChildByName("header_icon") as IStaticBitmapWrapperWindow;
         if(_loc8_ != null)
         {
            _loc8_.visible = false;
         }
         var _loc7_:ITextWindow = _loc4_.findChildByName("top_header_text") as ITextWindow;
         _loc7_.text = param2.name;
         var _loc5_:ITextWindow = _loc4_.findChildByName("top_text") as ITextWindow;
         _loc5_.text = param2.description;
         return _loc4_.findChildByName("top_click_area") as IRegionWindow;
      }
      
      public function dispose() : void
      {
         if(_controller)
         {
            _controller.closeMainView();
         }
         if(_window != null)
         {
            disposeListViews();
            _window.removeEventListener("click",onClickButton);
            _window.dispose();
            _window = null;
            UnknownVarFromGroupForumView_IScrollableListWindow_1 = null;
            _controller = null;
         }
      }
      
      private function initCommonControls() : void
      {
         var _loc2_:IWindowModel = _window.findChildByName("settings_button");
         if(UnknownVarFromGroupForumView_ExtendedForumData_1 != null && UnknownVarFromGroupForumView_ExtendedForumData_1.canChangeSettings)
         {
            _loc2_.removeEventListener("WME_CLICK",onSettingsButtonClick);
            _loc2_.addEventListener("WME_CLICK",onSettingsButtonClick);
            _loc2_.visible = true;
         }
         else
         {
            _loc2_.visible = false;
         }
         var _loc1_:ILabelWindow = UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_1.findChildByName("back_button_label") as ILabelWindow;
         if(UnknownVarFromGroupForumView_ThreadListView_1 != null)
         {
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_1.visible = true;
            _loc1_.text = _controller.localizationManager.getLocalization("groupforum.view.mark_read");
         }
         else if(UnknownVarFromGroupForumView_MessageListView_1 != null)
         {
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_1.visible = true;
            _loc1_.text = _controller.localizationManager.getLocalization("groupforum.view.back");
         }
         else if(UnknownVarFromGroupForumView_ForumsListView_1 != null)
         {
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_1.visible = true;
            _loc1_.text = _controller.localizationManager.getLocalization("groupforum.view.mark_read");
         }
         else
         {
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_1.visible = false;
         }
         var _loc3_:ILabelWindow = UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2.findChildByName("post_button_label") as ILabelWindow;
         if(UnknownVarFromGroupForumView_ThreadListView_1 != null)
         {
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2.visible = true;
            _loc3_.text = _controller.localizationManager.getLocalization("groupforum.view.start_thread");
         }
         else if(UnknownVarFromGroupForumView_MessageListView_1 != null)
         {
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2.visible = true;
            _loc3_.text = _controller.localizationManager.getLocalization("groupforum.view.reply");
         }
         else
         {
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2.visible = false;
         }
         var _loc4_:int = UnknownVarFromGroupForumView_Int_1 + 1;
         _txtElement.caption = _loc4_ + " / " + _numOfPages;
         _window.scaler.enable();
         _window.scaler.visible = true;
         enable(UnknownVarFromGroupForumView_IWindowModel_3,UnknownVarFromGroupForumView_Int_1 > 0);
         enable(UnknownVarFromGroupForumView_IWindowModel_1,UnknownVarFromGroupForumView_Int_1 > 0);
         enable(UnknownVarFromGroupForumView_IWindowModel_2,UnknownVarFromGroupForumView_Int_1 < _numOfPages - 1);
         enable(UnknownVarFromGroupForumView_IWindowModel_4,UnknownVarFromGroupForumView_Int_1 < _numOfPages - 1);
         updateUnreadForumsCount(_controller.unreadForumsCount);
      }
      
      private function resetWindow() : void
      {
         if(_window != null)
         {
            disposeListViews();
            UnknownVarFromGroupForumView_IScrollableListWindow_1.scrollV = 0;
         }
         else
         {
            _window = _controller.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_main_view_xml())) as IFrameController;
            UnknownVarFromGroupForumView_IScrollableListWindow_1 = _window.findChildByName("scrollable_message_list") as IScrollableListWindow;
            UnknownVarFromGroupForumView_IScrollableListWindow_1.scrollableWindow.addEventListener("WE_RESIZED",onResized,100);
            _window.center();
            _window.y = 100;
            _txtElement = _window.findChildByName("page_info");
            UnknownVarFromGroupForumView_IWindowModel_1 = _window.findChildByName("show_previous");
            UnknownVarFromGroupForumView_IWindowModel_1.addEventListener("WME_CLICK",onClickButton);
            UnknownVarFromGroupForumView_IWindowModel_2 = _window.findChildByName("show_next");
            UnknownVarFromGroupForumView_IWindowModel_2.addEventListener("WME_CLICK",onClickButton);
            UnknownVarFromGroupForumView_IWindowModel_4 = _window.findChildByName("show_last");
            UnknownVarFromGroupForumView_IWindowModel_4.addEventListener("WME_CLICK",onClickButton);
            UnknownVarFromGroupForumView_IWindowModel_3 = _window.findChildByName("show_first");
            UnknownVarFromGroupForumView_IWindowModel_3.addEventListener("WME_CLICK",onClickButton);
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_1 = UnknownICoreWindowComponents5(_window.findChildByName("back_button"));
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_1.addEventListener("WME_CLICK",onClickButton);
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2 = UnknownICoreWindowComponents5(_window.findChildByName("post_button"));
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2.addEventListener("WME_CLICK",onClickButton);
            UnknownVarFromGroupForumView_IWindowModel_5 = _window.findChildByTag("close");
            UnknownVarFromGroupForumView_IWindowModel_5.addEventListener("WME_CLICK",onClickButton);
            UnknownVarFromGroupForumView_IWindowModel_6 = _window.findChildByName("list_header");
            UnknownVarFromGroupForumView_ITextWindow_1 = ITextWindow(IItemListWindow(_window.findChildByName("shortcuts")).getListItemByName("my"));
         }
      }
      
      private function disposeListViews() : void
      {
         if(UnknownVarFromGroupForumView_ForumsListView_1 != null)
         {
            UnknownVarFromGroupForumView_ForumsListView_1.dispose();
            UnknownVarFromGroupForumView_ForumsListView_1 = null;
         }
         if(UnknownVarFromGroupForumView_ThreadListView_1 != null)
         {
            UnknownVarFromGroupForumView_ThreadListView_1.dispose();
            UnknownVarFromGroupForumView_ThreadListView_1 = null;
         }
         if(UnknownVarFromGroupForumView_MessageListView_1 != null)
         {
            UnknownVarFromGroupForumView_MessageListView_1.dispose();
            UnknownVarFromGroupForumView_MessageListView_1 = null;
         }
      }
      
      private function setStatusTextError(param1:String, param2:String) : void
      {
         var _loc3_:ITextWindow = ITextWindow(_window.findChildByName("status"));
         if(param2 == null || param2.length == 0)
         {
            _loc3_.caption = "";
         }
         else
         {
            param1 = _controller.localizationManager.getLocalization("groupforum.view.error.operation_" + param1);
            _loc3_.text = _controller.localizationManager.getLocalizationWithParams("groupforum.view.error." + param2,"","operation",param1);
         }
      }
      
      private function onSettingsButtonClick(param1:WindowMouseEvent) : void
      {
         openForumSettingsView();
      }
      
      private function onTopAreaClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromGroupForumView_ExtendedForumData_1 != null)
         {
            _controller.context.createLinkEvent("group/" + UnknownVarFromGroupForumView_ExtendedForumData_1.groupId);
         }
      }
      
      public function openForumsList(param1:ForumsListData) : void
      {
         resetWindow();
         UnknownVarFromGroupForumView_ForumsListData_1 = param1;
         UnknownVarFromGroupForumView_ExtendedForumData_1 = null;
         UnknownVarFromGroupForumView_ThreadsListData_1 = null;
         UnknownVarFromGroupForumView_MessagesListData_1 = null;
         _numOfPages = calculateNumOfPagesAvailable(UnknownVarFromGroupForumView_ForumsListData_1.totalAmount);
         UnknownVarFromGroupForumView_Int_1 = Math.ceil(UnknownVarFromGroupForumView_ForumsListData_1.startIndex / 20);
         UnknownVarFromGroupForumView_ForumsListView_1 = new ForumsListView(this,UnknownVarFromGroupForumView_IScrollableListWindow_1,UnknownVarFromGroupForumView_ForumsListData_1.forums);
         UnknownVarFromGroupForumView_ForumsListView_1.update();
         UnknownVarFromGroupForumView_IWindowModel_6.caption = _controller.localizationManager.getLocalization("groupforum.view.forums_list." + UnknownVarFromGroupForumView_ForumsListData_1.listCode);
         var _loc3_:IWindowController_1 = _window.findChildByName("top_part") as IWindowController_1;
         var _loc6_:IWidgetWindowController = IWidgetWindowController(_loc3_.findChildByName("group_icon"));
         _loc6_.visible = false;
         var _loc8_:IStaticBitmapWrapperWindow = _loc3_.findChildByName("header_icon") as IStaticBitmapWrapperWindow;
         _loc8_.visible = true;
         _loc8_.assetUri = "forum_forum_list" + UnknownVarFromGroupForumView_ForumsListData_1.listCode;
         var _loc7_:ITextWindow = _loc3_.findChildByName("top_header_text") as ITextWindow;
         _loc7_.text = _controller.localizationManager.getLocalization("groupforum.view.forums_header." + UnknownVarFromGroupForumView_ForumsListData_1.listCode);
         var _loc4_:ITextWindow = _loc3_.findChildByName("top_text") as ITextWindow;
         _loc4_.text = _controller.localizationManager.getLocalization("groupforum.view.forums_description." + UnknownVarFromGroupForumView_ForumsListData_1.listCode);
         var _loc2_:IRegionWindow = _loc3_.findChildByName("top_click_area") as IRegionWindow;
         _loc2_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc2_.disable();
         initCommonControls();
         var _loc5_:ITextWindow = ITextWindow(_window.findChildByName("status"));
         _loc5_.text = _controller.localizationManager.getLocalization("groupforum.view.forums_list.status");
      }
      
      public function get isForumsListOpened() : Boolean
      {
         return UnknownVarFromGroupForumView_ForumsListView_1 != null;
      }
      
      public function openThreadList(param1:ForumsListData, param2:ExtendedForumData, param3:ThreadsListData) : void
      {
         resetWindow();
         UnknownVarFromGroupForumView_ForumsListData_1 = param1;
         UnknownVarFromGroupForumView_ExtendedForumData_1 = param2;
         UnknownVarFromGroupForumView_ThreadsListData_1 = param3;
         UnknownVarFromGroupForumView_MessagesListData_1 = null;
         _numOfPages = calculateNumOfPagesAvailable(UnknownVarFromGroupForumView_ThreadsListData_1.totalThreads);
         UnknownVarFromGroupForumView_Int_1 = Math.ceil(UnknownVarFromGroupForumView_ThreadsListData_1.startIndex / 20);
         UnknownVarFromGroupForumView_ThreadListView_1 = new ThreadListView(this,UnknownVarFromGroupForumView_IScrollableListWindow_1,UnknownVarFromGroupForumView_ExtendedForumData_1,UnknownVarFromGroupForumView_ThreadsListData_1);
         UnknownVarFromGroupForumView_ThreadListView_1.update();
         UnknownVarFromGroupForumView_IWindowModel_6.caption = _controller.localizationManager.getLocalization("groupforum.view.all_threads");
         if(UnknownVarFromGroupForumView_ExtendedForumData_1.canPostThread)
         {
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2.enable();
            setStatusTextError("post_thread",null);
         }
         else
         {
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2.disable();
            setStatusTextError("post_thread",UnknownVarFromGroupForumView_ExtendedForumData_1.postThreadPermissionError);
         }
         var _loc4_:IRegionWindow = GroupForumView.initTopAreaForForum(_window,UnknownVarFromGroupForumView_ExtendedForumData_1);
         _loc4_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc4_.addEventListener("WME_CLICK",onTopAreaClick);
         _loc4_.enable();
         initCommonControls();
      }
      
      public function updateThread(param1:ThreadData) : void
      {
         if(UnknownVarFromGroupForumView_ThreadListView_1 != null)
         {
            UnknownVarFromGroupForumView_ThreadListView_1.updateElement(param1);
         }
      }
      
      public function updateMessage(param1:MessageData) : void
      {
         if(UnknownVarFromGroupForumView_MessageListView_1 != null)
         {
            UnknownVarFromGroupForumView_MessageListView_1.updateElement(param1);
         }
      }
      
      public function openMessagesList(param1:ForumsListData, param2:ExtendedForumData, param3:ThreadsListData, param4:MessagesListData) : void
      {
         resetWindow();
         UnknownVarFromGroupForumView_ForumsListData_1 = param1;
         UnknownVarFromGroupForumView_ExtendedForumData_1 = param2;
         UnknownVarFromGroupForumView_ThreadsListData_1 = param3;
         UnknownVarFromGroupForumView_MessagesListData_1 = param4;
         var _loc7_:int = param4.threadId;
         var _loc5_:ThreadData = UnknownVarFromGroupForumView_ThreadsListData_1.threadsById[_loc7_];
         _numOfPages = calculateNumOfPagesAvailable(param4.totalMessages);
         var _loc8_:int = param4.startIndex;
         UnknownVarFromGroupForumView_Int_1 = Math.ceil(_loc8_ / 20);
         UnknownVarFromGroupForumView_IWindowModel_6.caption = _loc5_.header;
         UnknownVarFromGroupForumView_MessageListView_1 = new MessageListView(this,UnknownVarFromGroupForumView_IScrollableListWindow_1,UnknownVarFromGroupForumView_ExtendedForumData_1,_loc5_,param4);
         UnknownVarFromGroupForumView_MessageListView_1.update();
         if(_controller.getGoToMessageIndex() > 0 && _controller.getGoToThreadId() == _loc7_)
         {
            UnknownVarFromGroupForumView_MessageListView_1.scrollToSpecificElement(_controller.getGoToMessageIndex(),true);
            _controller.resetGoTo();
         }
         if(UnknownVarFromGroupForumView_ExtendedForumData_1.canPostMessage)
         {
            if(UnknownVarFromGroupForumView_ExtendedForumData_1.canModerate || !_loc5_.isLocked)
            {
               UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2.enable();
               setStatusTextError("post_message",null);
            }
            else
            {
               UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2.disable();
               setStatusTextError("post_in_locked",UnknownVarFromGroupForumView_ExtendedForumData_1.moderatePermissionError);
            }
         }
         else
         {
            UnknownVarFromGroupForumView_UnknownICoreWindowComponents5_2.disable();
            setStatusTextError("post_message",UnknownVarFromGroupForumView_ExtendedForumData_1.postMessagePermissionError);
         }
         var _loc6_:IRegionWindow = GroupForumView.initTopAreaForForum(_window,UnknownVarFromGroupForumView_ExtendedForumData_1);
         _loc6_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc6_.addEventListener("WME_CLICK",onTopAreaClick);
         _loc6_.enable();
         initCommonControls();
      }
      
      public function get controller() : GroupForumController
      {
         return _controller;
      }
      
      private function calculateNumOfPagesAvailable(param1:int) : int
      {
         return Math.ceil(param1 / UnknownVarFromGroupForumView_Int_2);
      }
      
      private function getPreviousPageData() : void
      {
         var _loc1_:int = UnknownVarFromGroupForumView_Int_1 - 1;
         if(_loc1_ >= 0)
         {
            requestNewPageData(_loc1_);
         }
      }
      
      private function getNextPageData() : void
      {
         var _loc1_:int = UnknownVarFromGroupForumView_Int_1 + 1;
         if(_loc1_ <= _numOfPages)
         {
            requestNewPageData(_loc1_);
         }
      }
      
      private function getFirstPageData() : void
      {
         if(UnknownVarFromGroupForumView_Int_1 == 0)
         {
            return;
         }
         requestNewPageData(0);
      }
      
      private function getLastPageData() : void
      {
         if(UnknownVarFromGroupForumView_Int_1 >= _numOfPages)
         {
            return;
         }
         requestNewPageData(_numOfPages - 1);
      }
      
      private function requestNewPageData(param1:int) : void
      {
         var _loc2_:int = param1 * UnknownVarFromGroupForumView_Int_2;
         if(UnknownVarFromGroupForumView_ForumsListView_1 != null)
         {
            _controller.openForumsList(UnknownVarFromGroupForumView_ForumsListData_1.listCode,_loc2_);
         }
         else if(UnknownVarFromGroupForumView_ThreadListView_1 != null)
         {
            _controller.requestThreadList(UnknownVarFromGroupForumView_ExtendedForumData_1.groupId,_loc2_);
         }
         else if(UnknownVarFromGroupForumView_MessageListView_1 != null)
         {
            _controller.requestThreadMessageList(UnknownVarFromGroupForumView_ExtendedForumData_1.groupId,UnknownVarFromGroupForumView_MessagesListData_1.threadId,_loc2_);
         }
         UnknownVarFromGroupForumView_Int_1 = param1;
      }
      
      public function getAsDaysHoursMinutes(param1:int) : String
      {
         return FriendlyTime.getFriendlyTime(_controller.localizationManager,param1,".ago",1);
      }
      
      private function onResized(param1:WindowEvent = null) : void
      {
         if(UnknownVarFromGroupForumView_ForumsListView_1 != null)
         {
            UnknownVarFromGroupForumView_ForumsListView_1.updateItemWidths();
         }
         if(UnknownVarFromGroupForumView_ThreadListView_1 != null)
         {
            UnknownVarFromGroupForumView_ThreadListView_1.updateItemWidths();
         }
         if(UnknownVarFromGroupForumView_MessageListView_1 != null)
         {
            UnknownVarFromGroupForumView_MessageListView_1.updateItemSizes();
         }
      }
      
      private function onClickButton(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "back_button":
               if(UnknownVarFromGroupForumView_MessageListView_1 != null)
               {
                  _controller.requestThreadList(UnknownVarFromGroupForumView_ExtendedForumData_1.groupId,UnknownVarFromGroupForumView_ThreadsListData_1.startIndex);
               }
               else if(UnknownVarFromGroupForumView_ThreadListView_1 != null)
               {
                  _controller.markForumAsRead(true);
                  if(UnknownVarFromGroupForumView_ForumsListData_1 != null)
                  {
                     _controller.openForumsList(UnknownVarFromGroupForumView_ForumsListData_1.listCode,UnknownVarFromGroupForumView_ForumsListData_1.startIndex);
                  }
                  else
                  {
                     dispose();
                  }
               }
               else if(UnknownVarFromGroupForumView_ForumsListView_1 != null)
               {
                  _controller.markForumsAsRead();
                  dispose();
               }
               break;
            case "show_previous":
               getPreviousPageData();
               break;
            case "show_next":
               getNextPageData();
               break;
            case "show_last":
               getLastPageData();
               break;
            case "show_first":
               getFirstPageData();
               break;
            case "header_button_close":
               _window.visible = false;
               dispose();
               break;
            case "post_button":
               openComposeMessageView(UnknownVarFromGroupForumView_MessagesListData_1 != null ? UnknownVarFromGroupForumView_ThreadsListData_1.threadsById[UnknownVarFromGroupForumView_MessagesListData_1.threadId] : null);
         }
      }
      
      public function openComposeMessageView(param1:ThreadData, param2:MessageData = null) : void
      {
         if(_controller.composeMessageView != null)
         {
            _controller.composeMessageView.focus(UnknownVarFromGroupForumView_ExtendedForumData_1,param1,param2);
         }
         else
         {
            _controller.composeMessageView = new ComposeMessageView(this,_window.x + _window.width,_window.y,UnknownVarFromGroupForumView_ExtendedForumData_1,param1,param2);
         }
      }
      
      public function openForumSettingsView() : void
      {
         if(_controller.forumSettingsView != null)
         {
            _controller.forumSettingsView.focus(UnknownVarFromGroupForumView_ExtendedForumData_1);
         }
         else
         {
            _controller.forumSettingsView = new ForumSettingsView(this,_window.x + _window.width,_window.y,UnknownVarFromGroupForumView_ExtendedForumData_1);
         }
      }
      
      public function updateUnreadForumsCount(param1:int) : void
      {
         if(param1 > 0)
         {
            UnknownVarFromGroupForumView_ITextWindow_1.htmlText = _controller.localizationManager.getLocalizationWithParams("groupforum.view.shortcuts.my.unread","","unread_count",param1);
         }
         else
         {
            UnknownVarFromGroupForumView_ITextWindow_1.htmlText = _controller.localizationManager.getLocalization("groupforum.view.shortcuts.my","");
         }
      }
   }
}


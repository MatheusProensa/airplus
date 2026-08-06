package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.communication.messages.parser.groupforums.ExtendedForumData;
   import com.sulake.habbo.communication.messages.parser.groupforums.MessageData;
   import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
   
   public class MessageListView implements IComponentInterfaceQueue
   {
      private static const ITEM_POOL_MAX_SIZE:int = 20;
      
      private static const AVATAR_LOAD_INTERVAL_MS:int = 100;
      
      private static const UnknownConstFromMessageListView_Int_1:int = 2;
      
      public static const UNREAD_MESSAGE_STATUS:int = -1;
      
      public static const UnknownConstFromMessageListView_Int_2:int = 20;
      
      public static const QUOTE_BG_COLOR:uint = 4291611852;
      
      private static var ITEM_POOL:Vector.<MessageListItemView> = new Vector.<MessageListItemView>();
      
      public static const LINE_PATTERN:RegExp = /\\?(?:(?:\*([^*]+)\*)|(?:_([^_]+)_)|(?:@\S+))/;
      
      public static const UnknownConstFromMessageListView_RegExp_1:RegExp = /^>(?: ?|$)/;
      
      private var UnknownVarFromMessageListView_GroupForumController_1:GroupForumController;
      
      private var UnknownVarFromMessageListView_GroupForumView_1:GroupForumView;
      
      private var UnknownVarFromMessageListView_IScrollableListWindow_1:IScrollableListWindow;
      
      private var UnknownVarFromMessageListView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromMessageListView_Vector_1:Vector.<MessageListItemView>;
      
      private var UnknownVarFromMessageListView_ExtendedForumData_1:ExtendedForumData;
      
      private var UnknownVarFromMessageListView_ThreadData_1:ThreadData;
      
      private var UnknownVarFromMessageListView_MessagesListData_1:MessagesListData;
      
      private var UnknownVarFromMessageListView_Boolean_1:Boolean = true;
      
      private var _disposed:Boolean;
      
      public function MessageListView(param1:GroupForumView, param2:IScrollableListWindow, param3:ExtendedForumData, param4:ThreadData, param5:MessagesListData)
      {
         super();
         UnknownVarFromMessageListView_GroupForumView_1 = param1;
         UnknownVarFromMessageListView_GroupForumController_1 = UnknownVarFromMessageListView_GroupForumView_1.controller;
         UnknownVarFromMessageListView_IScrollableListWindow_1 = param2;
         UnknownVarFromMessageListView_IWindowController_1_1 = UnknownVarFromMessageListView_GroupForumController_1.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_message_list_item_xml())) as IWindowController_1;
         UnknownVarFromMessageListView_Vector_1 = new Vector.<MessageListItemView>();
         UnknownVarFromMessageListView_ExtendedForumData_1 = param3;
         UnknownVarFromMessageListView_ThreadData_1 = param4;
         UnknownVarFromMessageListView_MessagesListData_1 = param5;
      }
      
      private static function getMessageColor(param1:int) : Array
      {
         switch(param1)
         {
            case 10:
               return [4293519840,4292335567];
            case 20:
               return [4294952634,4294959058];
            case -1:
               return [4294964441,4291227641];
            case 0:
            case 1:
         }
         return [4294967295,4291227641];
      }
      
      internal static function getModerationMessage(param1:GroupForumController, param2:MessageData) : String
      {
         switch(param2.state - 10)
         {
            case 0:
               return param1.localizationManager.getLocalizationWithParams("groupforum.view.message_hidden_by_admin","","admin_name",param2.adminName);
            case 10:
               return param1.localizationManager.getLocalizationWithParams("groupforum.view.message_hidden_by_staff","","admin_name",param2.adminName);
            default:
               return null;
         }
      }
      
      internal static function getMessageColorForState(param1:int) : Array
      {
         return getMessageColor(param1);
      }
      
      public function update() : void
      {
         var _loc4_:* = false;
         var _loc1_:MessageListItemView = null;
         clear();
         UnknownVarFromMessageListView_IScrollableListWindow_1.invalidate();
         var _loc3_:int = UnknownVarFromMessageListView_GroupForumController_1.getThreadLastReadMessageIndex(UnknownVarFromMessageListView_MessagesListData_1.threadId);
         UnknownVarFromMessageListView_Boolean_1 = true;
         UnknownVarFromMessageListView_IScrollableListWindow_1.autoArrangeItems = false;
         for each(var _loc2_ in UnknownVarFromMessageListView_MessagesListData_1.messages)
         {
            _loc4_ = _loc2_.messageIndex > _loc3_;
            _loc1_ = claimView();
            _loc1_.initialize(UnknownVarFromMessageListView_ExtendedForumData_1,UnknownVarFromMessageListView_ThreadData_1,_loc2_,_loc4_);
            UnknownVarFromMessageListView_Vector_1.push(_loc1_);
            UnknownVarFromMessageListView_IScrollableListWindow_1.addListItem(_loc1_.window);
         }
         UnknownVarFromMessageListView_Boolean_1 = false;
         updateItemSizes();
      }
      
      public function updateItemSizes() : void
      {
         if(UnknownVarFromMessageListView_Boolean_1)
         {
            return;
         }
         var _loc1_:Number = Number(UnknownVarFromMessageListView_IScrollableListWindow_1.scrollableWindow.width);
         updateItemSizesInternal();
         if(UnknownVarFromMessageListView_IScrollableListWindow_1.scrollableWindow.width != _loc1_)
         {
            updateItemSizesInternal();
         }
      }
      
      private function updateItemSizesInternal() : void
      {
         var _loc5_:int = 0;
         var _loc1_:IWindowController_1 = null;
         var _loc3_:IWindowController_1 = null;
         var _loc4_:IWindowController_1 = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:ITextWindow = null;
         UnknownVarFromMessageListView_IScrollableListWindow_1.autoArrangeItems = false;
         _loc5_ = 0;
         while(_loc5_ < UnknownVarFromMessageListView_IScrollableListWindow_1.numListItems)
         {
            _loc1_ = UnknownVarFromMessageListView_Vector_1[_loc5_].window;
            _loc3_ = _loc1_.findChildByName("texts_container") as IWindowController_1;
            _loc4_ = IWindowController_1(_loc1_.findChildByName("message_text_container"));
            _loc1_.width = UnknownVarFromMessageListView_IScrollableListWindow_1.scrollableWindow.width - 2;
            _loc7_ = 2;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.numChildren)
            {
               _loc2_ = ITextWindow(_loc4_.getChildAt(_loc6_));
               _loc2_.y = _loc7_;
               _loc7_ = int(_loc2_.bottom);
               _loc6_++;
            }
            _loc4_.height = _loc7_;
            _loc1_.height = _loc3_.height + _loc4_.bottom;
            _loc5_++;
         }
         UnknownVarFromMessageListView_IScrollableListWindow_1.autoArrangeItems = true;
      }
      
      private function clear() : void
      {
         if(UnknownVarFromMessageListView_IScrollableListWindow_1 != null && UnknownVarFromMessageListView_IScrollableListWindow_1.numListItems > 0)
         {
            UnknownVarFromMessageListView_IScrollableListWindow_1.removeListItems();
         }
         for each(var _loc1_ in UnknownVarFromMessageListView_Vector_1)
         {
            recycleView(_loc1_);
         }
         UnknownVarFromMessageListView_Vector_1.length = 0;
      }
      
      public function updateElement(param1:MessageData) : void
      {
         for each(var _loc2_ in UnknownVarFromMessageListView_Vector_1)
         {
            if(_loc2_.messageId == param1.messageId)
            {
               _loc2_.initialize(UnknownVarFromMessageListView_ExtendedForumData_1,UnknownVarFromMessageListView_ThreadData_1,param1);
               updateItemSizes();
               return;
            }
         }
      }
      
      public function scrollToSpecificElement(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:IWindowController_1 = null;
         if(!param2)
         {
            for each(var _loc4_ in UnknownVarFromMessageListView_Vector_1)
            {
               if(_loc4_.messageId == param1)
               {
                  _loc3_ = _loc4_.window;
                  break;
               }
            }
         }
         else if(param1 > 0 && param1 <= UnknownVarFromMessageListView_Vector_1.length)
         {
            _loc3_ = UnknownVarFromMessageListView_Vector_1[param1 - 1].window;
         }
         if(_loc3_ != null)
         {
            UnknownVarFromMessageListView_IScrollableListWindow_1.scrollV = _loc3_.bottom / UnknownVarFromMessageListView_IScrollableListWindow_1.maxScrollV;
         }
      }
      
      private function claimView() : MessageListItemView
      {
         var _loc1_:MessageListItemView = null;
         if(ITEM_POOL.length > 0)
         {
            _loc1_ = ITEM_POOL.pop();
         }
         else
         {
            _loc1_ = new MessageListItemView(UnknownVarFromMessageListView_IWindowController_1_1,UnknownVarFromMessageListView_GroupForumView_1);
         }
         _loc1_.bind(UnknownVarFromMessageListView_GroupForumView_1);
         return _loc1_;
      }
      
      private function recycleView(param1:MessageListItemView) : void
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
         if(UnknownVarFromMessageListView_IWindowController_1_1 != null)
         {
            UnknownVarFromMessageListView_IWindowController_1_1.dispose();
            UnknownVarFromMessageListView_IWindowController_1_1 = null;
         }
         UnknownVarFromMessageListView_Vector_1 = null;
         UnknownVarFromMessageListView_MessagesListData_1 = null;
         UnknownVarFromMessageListView_ThreadData_1 = null;
         UnknownVarFromMessageListView_ExtendedForumData_1 = null;
         UnknownVarFromMessageListView_IScrollableListWindow_1 = null;
         UnknownVarFromMessageListView_GroupForumController_1 = null;
         UnknownVarFromMessageListView_GroupForumView_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}


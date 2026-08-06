package com.sulake.habbo.moderation
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.ChatRecordData;
   import com.sulake.habbo.communication.messages.incoming.moderation.ChatlineData;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
   import com.sulake.habbo.utils.StringUtil;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class ChatlogCtrl implements IComponentInterfaceQueue, ITrackedWindow, IChatlogCtrl
   {
      private static var CHAT_LINE_POOL_MAX_SIZE:int = 1000;
      
      private static const CHAT_REPORTED_USER_COLOUR:uint = 4293973667;
      
      private static const CHAT_REPORTEE_COLOUR:uint = 4288921072;
      
      private static var CHAT_LINE_POOL:Array = [];
      
      private var _type:int;
      
      private var UnknownVarFromChatlogCtrl_Int_1:int;
      
      private var _msg:IMessageComposer;
      
      private var _main:ModerationManager;
      
      private var _frame:IWindowController_1;
      
      private var UnknownVarFromChatlogCtrl_IItemListWindow_1:IItemListWindow;
      
      private var _rooms:Array;
      
      private var _embedded:Boolean;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromChatlogCtrl_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromChatlogCtrl_IWindowController_1_2:IWindowController_1;
      
      private var _hilitedUserIds:Dictionary;
      
      private var UnknownVarFromChatlogCtrl_Timer_1:Timer;
      
      private var UnknownVarFromChatlogCtrl_Map_1:Map;
      
      private var UnknownVarFromChatlogCtrl_IssueMessageData_1:IssueMessageData;
      
      private var _contentLines:Array = [];
      
      private var _headers:Array = [];
      
      public function ChatlogCtrl(param1:IMessageComposer, param2:ModerationManager, param3:int, param4:int, param5:IssueMessageData = null, param6:IWindowController_1 = null, param7:IItemListWindow = null, param8:Boolean = false)
      {
         super();
         _main = param2;
         _type = param3;
         UnknownVarFromChatlogCtrl_Int_1 = param4;
         _msg = param1;
         UnknownVarFromChatlogCtrl_Map_1 = new Map();
         UnknownVarFromChatlogCtrl_IssueMessageData_1 = param5;
         _frame = param6;
         UnknownVarFromChatlogCtrl_IItemListWindow_1 = param7;
         _embedded = param8;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         var _loc2_:IWindowModel = null;
         var _loc1_:IFrameController = IFrameController(_main.getXmlWindow("evidence_frame"));
         _loc1_.visible = false;
         var _loc3_:IItemListWindow = IItemListWindow(_loc1_.findChildByName("evidence_list"));
         UnknownVarFromChatlogCtrl_IWindowController_1_2 = _loc3_.getListItemAt(0) as IWindowController_1;
         UnknownVarFromChatlogCtrl_IWindowController_1_1 = _loc3_.getListItemAt(1) as IWindowController_1;
         _loc3_.removeListItems();
         UnknownVarFromChatlogCtrl_Timer_1 = new Timer(1000,1);
         UnknownVarFromChatlogCtrl_Timer_1.addEventListener("timer",onResizeTimer);
         if(!_embedded)
         {
            _frame = _loc1_;
            _frame.procedure = onWindow;
            _frame.visible = true;
            _loc2_ = _frame.findChildByTag("close");
            _loc2_.procedure = onClose;
            UnknownVarFromChatlogCtrl_IItemListWindow_1 = _loc3_;
         }
         else
         {
            _loc1_.dispose();
         }
         _main.connection.send(_msg);
         _main.messageHandler.addChatlogListener(this);
      }
      
      public function hide() : void
      {
         dispose();
      }
      
      public function onChatlog(param1:String, param2:int, param3:int, param4:Array, param5:Dictionary) : void
      {
         var _loc6_:* = null;
         if(param2 != _type || param3 != UnknownVarFromChatlogCtrl_Int_1 || _disposed)
         {
            return;
         }
         for each(_loc6_ in _contentLines)
         {
            recycleContentLine(_loc6_);
         }
         for each(_loc6_ in _headers)
         {
            _loc6_.dispose();
         }
         _contentLines = [];
         _headers = [];
         _main.messageHandler.removeChatlogListener(this);
         _rooms = param4;
         _hilitedUserIds = param5;
         populate();
         onResizeTimer(null);
         if(!_embedded)
         {
            _frame.caption = param1;
            _frame.visible = true;
         }
      }
      
      public function getType() : int
      {
         return _type;
      }
      
      public function getId() : String
      {
         return "" + UnknownVarFromChatlogCtrl_Int_1;
      }
      
      public function setId(param1:int) : void
      {
         UnknownVarFromChatlogCtrl_Int_1 = param1;
      }
      
      public function getFrame() : IFrameController
      {
         return _frame as IFrameController;
      }
      
      private function populate() : void
      {
         var _loc1_:* = null;
         UnknownVarFromChatlogCtrl_IItemListWindow_1.autoArrangeItems = false;
         UnknownVarFromChatlogCtrl_IItemListWindow_1.removeListItems();
         for each(_loc1_ in _rooms)
         {
            populateEvidence(_loc1_);
         }
         UnknownVarFromChatlogCtrl_IItemListWindow_1.autoArrangeItems = true;
      }
      
      private function populateEvidence(param1:ChatRecordData) : void
      {
         var _loc10_:String = null;
         var _loc7_:int = 0;
         var _loc8_:ChatlineData = null;
         var _loc6_:IWindowController_1 = createHeaderLine();
         var _loc9_:IWindowModel = _loc6_.findChildByName("text");
         var _loc2_:UnknownICoreWindowComponents4 = UnknownICoreWindowComponents4(_loc6_.findChildByName("btnHeaderAction"));
         var _loc3_:UnknownICoreWindowComponents4 = UnknownICoreWindowComponents4(_loc6_.findChildByName("btnHeaderAction2"));
         if(_loc3_)
         {
            _loc3_.visible = false;
         }
         switch(param1.recordType - 1)
         {
            case 0:
               if(param1.roomId > 0)
               {
                  _loc2_.caption = "Room tool";
                  if(param1.roomName == null)
                  {
                     _loc9_.caption = "Room #" + param1.roomId;
                  }
                  else
                  {
                     _loc9_.caption = "Room: " + param1.roomName;
                  }
                  _loc3_.visible = true;
                  _loc3_.caption = "View room";
                  new OpenRoomInSpectatorMode(_main,_loc3_,param1.roomId);
                  if(_embedded)
                  {
                     new OpenRoomTool(null,_main,_loc2_,param1.roomId);
                  }
                  else
                  {
                     new OpenRoomTool(_frame as IFrameController,_main,_loc2_,param1.roomId);
                  }
               }
               break;
            case 1:
               _loc9_.caption = "IM session";
               break;
            case 2:
               _loc9_.caption = "Forum thread";
               _loc3_.visible = true;
               _loc3_.caption = "Open thread";
               new OpenDiscussionThread(_main,_loc3_,param1.groupId,param1.threadId);
               _loc2_.caption = "Delete";
               new HideDiscussionThread(_main,this,_loc2_,param1.groupId,param1.threadId);
               break;
            case 3:
               _loc9_.caption = "Forum message";
               _loc3_.visible = true;
               _loc3_.caption = "Open Message";
               new OpenDiscussionMessage(_main,_loc3_,param1.groupId,param1.threadId,param1.context.messageIndex);
               _loc2_.caption = "Delete";
               new HideDiscussionMessage(_main,this,_loc2_,param1.groupId,param1.threadId,param1.messageId);
               break;
            case 4:
               _loc9_.caption = "Selfie report";
               _loc3_.visible = true;
               _loc3_.caption = "View selfie";
               new OpenExternalLink(_main,_loc3_,param1.context.url);
               _loc2_.visible = true;
               _loc2_.caption = "Room tool";
               if(_embedded)
               {
                  new OpenRoomTool(null,_main,_loc2_,param1.roomId);
               }
               else
               {
                  new OpenRoomTool(_frame as IFrameController,_main,_loc2_,param1.roomId);
               }
               break;
            case 5:
               _loc9_.caption = "Photo report";
               _loc3_.visible = true;
               _loc3_.caption = "Moderate photo";
               _loc10_ = _main.getProperty("stories.admin.tool.base.url");
               if(StringUtil.isEmpty(_loc10_))
               {
                  _loc10_ = "https://theallseeingeye.sulake.com/habbo-stories-admin/#/photos/";
               }
               _loc10_ += param1.context.extraDataId;
               new OpenExternalLink(_main,_loc3_,_loc10_);
               _loc2_.visible = true;
               _loc2_.caption = "Room tool";
               if(_embedded)
               {
                  new OpenRoomTool(null,_main,_loc2_,param1.roomId);
               }
               else
               {
                  new OpenRoomTool(_frame as IFrameController,_main,_loc2_,param1.roomId);
               }
         }
         addHeaderLineToList(_loc6_);
         var _loc4_:* = true;
         var _loc5_:* = -1;
         _loc7_ = 0;
         while(_loc7_ < param1.chatlog.length)
         {
            _loc8_ = param1.chatlog[_loc7_];
            populateContentLine(_loc8_,_loc4_);
            _loc4_ = !_loc4_;
            if(_loc8_.hasHighlighting && _loc5_ == -1)
            {
               _loc5_ = _loc7_;
            }
            _loc7_++;
         }
         if(_loc5_ > -1)
         {
            UnknownVarFromChatlogCtrl_IItemListWindow_1.autoArrangeItems = true;
            if(UnknownVarFromChatlogCtrl_IItemListWindow_1.maxScrollV > 0)
            {
               UnknownVarFromChatlogCtrl_IItemListWindow_1.scrollV = UnknownVarFromChatlogCtrl_IItemListWindow_1.getListItemAt(_loc5_).y / UnknownVarFromChatlogCtrl_IItemListWindow_1.maxScrollV;
            }
         }
      }
      
      private function addContentLineToList(param1:IWindowController_1) : void
      {
         UnknownVarFromChatlogCtrl_IItemListWindow_1.addListItem(param1);
         _contentLines.push(param1);
      }
      
      private function addHeaderLineToList(param1:IWindowController_1) : void
      {
         UnknownVarFromChatlogCtrl_IItemListWindow_1.addListItem(param1);
         _headers.push(param1);
      }
      
      private function createContentLine() : IWindowController_1
      {
         if(CHAT_LINE_POOL.length > 0)
         {
            return CHAT_LINE_POOL.pop() as IWindowController_1;
         }
         return IWindowController_1(UnknownVarFromChatlogCtrl_IWindowController_1_1.clone());
      }
      
      private function recycleContentLine(param1:IWindowController_1) : void
      {
         var _loc2_:ITextWindow = null;
         if(CHAT_LINE_POOL.length < CHAT_LINE_POOL_MAX_SIZE)
         {
            _loc2_ = ITextWindow(param1.findChildByName("chatter_txt"));
            _loc2_.removeEventListener("WME_CLICK",onUserClick);
            param1.width = UnknownVarFromChatlogCtrl_IWindowController_1_1.width;
            param1.height = UnknownVarFromChatlogCtrl_IWindowController_1_1.height - 10;
            CHAT_LINE_POOL.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      private function createHeaderLine() : IWindowController_1
      {
         return UnknownVarFromChatlogCtrl_IWindowController_1_2.clone() as IWindowController_1;
      }
      
      private function populateContentLine(param1:ChatlineData, param2:Boolean) : void
      {
         var _loc5_:TextFormat = null;
         var _loc7_:IWindowController_1 = createContentLine();
         var _loc8_:IWindowModel = _loc7_.findChildByName("time_txt");
         var _loc4_:ITextWindow = ITextWindow(_loc7_.findChildByName("chatter_txt"));
         var _loc6_:ITextWindow = _loc7_.findChildByName("msg_txt") as ITextWindow;
         _loc8_.caption = param1.timeStamp;
         var _loc9_:* = _hilitedUserIds[param1.chatterId];
         if(_loc9_ != null)
         {
            _loc7_.color = _loc9_ as int == 0 ? 4293973667 : 4288921072;
         }
         else
         {
            _loc7_.color = param2 ? 4291030266 : 4294967295;
         }
         if(param1.hasHighlighting)
         {
            _loc5_ = _loc6_.getTextFormat();
            _loc5_.bold = true;
            _loc6_.setTextFormat(_loc5_);
            _loc6_.bold = true;
         }
         if(param1.chatterId > 0)
         {
            _loc4_.text = param1.chatterName;
            _loc4_.underline = true;
            _loc4_.addEventListener("WME_CLICK",onUserClick);
            if(!UnknownVarFromChatlogCtrl_Map_1.getValue(param1.chatterName))
            {
               UnknownVarFromChatlogCtrl_Map_1.add(param1.chatterName,param1.chatterId);
            }
         }
         else if(param1.chatterId == 0)
         {
            _loc4_.text = "Bot / pet";
            _loc4_.underline = false;
         }
         else
         {
            _loc4_.text = "-";
            _loc4_.underline = false;
         }
         _loc4_.color = _loc7_.color;
         _loc8_.color = _loc7_.color;
         _loc6_.color = _loc7_.color;
         _loc6_.text = param1.msg;
         var _loc3_:int = Math.max(_loc8_.height,_loc6_.textHeight + 5);
         _loc6_.height = _loc3_;
         if(_loc6_.getTextFormat())
         {
            _loc6_.getTextFormat().align = "left";
            _loc6_.getTextFormat().rightMargin = _loc6_.getTextFormat().rightMargin + 10;
         }
         _loc4_.height = _loc3_;
         _loc8_.height = _loc3_;
         _loc7_.height = _loc3_;
         addContentLineToList(_loc7_);
      }
      
      private function onUserClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = param1.target.caption;
         var _loc3_:int = UnknownVarFromChatlogCtrl_Map_1.getValue(_loc2_);
         _main.windowTracker.show(new UserInfoFrameCtrl(_main,_loc3_,UnknownVarFromChatlogCtrl_IssueMessageData_1),_frame as IFrameController,false,false,true);
      }
      
      private function onClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WE_RESIZED" || param2 != _frame)
         {
            return;
         }
         UnknownVarFromChatlogCtrl_Timer_1.reset();
         UnknownVarFromChatlogCtrl_Timer_1.start();
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         refreshListDims();
         var _loc2_:Boolean = refreshScrollBarVisibility();
      }
      
      private function refreshListDims() : void
      {
         var _loc4_:IWindowController_1 = null;
         var _loc2_:ITextWindow = null;
         var _loc3_:int = 0;
         UnknownVarFromChatlogCtrl_IItemListWindow_1.autoArrangeItems = false;
         var _loc1_:int = UnknownVarFromChatlogCtrl_IItemListWindow_1.numListItems;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = IWindowController_1(UnknownVarFromChatlogCtrl_IItemListWindow_1.getListItemAt(_loc3_));
            if(_loc4_.name == "chatline")
            {
               _loc2_ = ITextWindow(_loc4_.findChildByName("msg_txt"));
               _loc2_.width = _loc4_.width - _loc2_.x;
               _loc2_.height = _loc2_.textHeight + 5;
               _loc4_.height = _loc2_.height;
            }
            _loc3_++;
         }
         UnknownVarFromChatlogCtrl_IItemListWindow_1.autoArrangeItems = true;
      }
      
      private function refreshScrollBarVisibility() : Boolean
      {
         var _loc2_:IWindowController_1 = IWindowController_1(UnknownVarFromChatlogCtrl_IItemListWindow_1.parent);
         var _loc4_:IWindowModel = _loc2_.getChildByName("scroller") as IWindowModel;
         var _loc3_:* = UnknownVarFromChatlogCtrl_IItemListWindow_1.scrollableRegion.height > UnknownVarFromChatlogCtrl_IItemListWindow_1.height;
         var _loc1_:int = 22;
         if(_loc4_.visible)
         {
            if(_loc3_)
            {
               return false;
            }
            _loc4_.visible = false;
            UnknownVarFromChatlogCtrl_IItemListWindow_1.width += _loc1_;
            return true;
         }
         if(_loc3_)
         {
            _loc4_.visible = true;
            UnknownVarFromChatlogCtrl_IItemListWindow_1.width -= _loc1_;
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _main = null;
         _msg = null;
         UnknownVarFromChatlogCtrl_IssueMessageData_1 = null;
         if(UnknownVarFromChatlogCtrl_IItemListWindow_1 != null)
         {
            UnknownVarFromChatlogCtrl_IItemListWindow_1.removeListItems();
            UnknownVarFromChatlogCtrl_IItemListWindow_1.dispose();
            UnknownVarFromChatlogCtrl_IItemListWindow_1 = null;
         }
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _rooms = null;
         _hilitedUserIds = null;
         if(UnknownVarFromChatlogCtrl_Timer_1 != null)
         {
            UnknownVarFromChatlogCtrl_Timer_1.stop();
            UnknownVarFromChatlogCtrl_Timer_1.removeEventListener("timer",onResizeTimer);
            UnknownVarFromChatlogCtrl_Timer_1 = null;
         }
         if(!_embedded)
         {
            for each(_loc1_ in _contentLines)
            {
               recycleContentLine(_loc1_);
            }
            for each(_loc1_ in _headers)
            {
               _loc1_.dispose();
            }
         }
         _contentLines = [];
         _headers = [];
         if(UnknownVarFromChatlogCtrl_IWindowController_1_1 != null)
         {
            UnknownVarFromChatlogCtrl_IWindowController_1_1.dispose();
            UnknownVarFromChatlogCtrl_IWindowController_1_1 = null;
         }
         if(UnknownVarFromChatlogCtrl_IWindowController_1_2 != null)
         {
            UnknownVarFromChatlogCtrl_IWindowController_1_2.dispose();
            UnknownVarFromChatlogCtrl_IWindowController_1_2 = null;
         }
      }
   }
}


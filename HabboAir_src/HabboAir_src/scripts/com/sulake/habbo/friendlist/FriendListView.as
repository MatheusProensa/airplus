package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class FriendListView
   {
      private static const MIN_LEFT_MARGIN:int = 110;
      
      private static const UnknownConstFromFriendListView_Int_1:int = 1;
      
      private static const DEFAULT_LOCATION:Point = new Point(110,50);
      
      private var _friendList:HabboFriendList;
      
      private var UnknownVarFromFriendListView_FriendListTabsView_1:FriendListTabsView;
      
      private var _mainWindow:IFrameController;
      
      private var UnknownVarFromFriendListView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromFriendListView_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromFriendListView_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromFriendListView_Int_1:int = -1;
      
      private var _lastWindowWidth:int = -1;
      
      private var _ignoreResizeEvents:Boolean;
      
      public function FriendListView(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
         UnknownVarFromFriendListView_FriendListTabsView_1 = new FriendListTabsView(_friendList);
      }
      
      public function openFriendList() : void
      {
         if(_mainWindow == null)
         {
            prepare();
            _mainWindow.position = DEFAULT_LOCATION;
         }
         else
         {
            _mainWindow.visible = true;
            _mainWindow.activate();
         }
      }
      
      public function showInfo(param1:WindowEvent, param2:String) : void
      {
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.type == "WME_OUT")
         {
            UnknownVarFromFriendListView_ITextWindow_1.text = "";
         }
         else if(_loc3_.type == "WME_OVER")
         {
            UnknownVarFromFriendListView_ITextWindow_1.text = param2;
         }
      }
      
      public function refresh(param1:String) : void
      {
         if(this._mainWindow == null)
         {
            return;
         }
         UnknownVarFromFriendListView_FriendListTabsView_1.refresh(param1);
         refreshWindowSize();
      }
      
      public function close() : void
      {
         if(this._mainWindow != null)
         {
            this._mainWindow.visible = false;
         }
      }
      
      public function isOpen() : Boolean
      {
         return _mainWindow && _mainWindow.visible;
      }
      
      private function prepare() : void
      {
         _mainWindow = IFrameController(_friendList.getXmlWindow("main_window"));
         _mainWindow.findChildByTag("close").procedure = onWindowClose;
         UnknownVarFromFriendListView_IWindowController_1_1 = IWindowController_1(_mainWindow.content.findChildByName("main_content"));
         UnknownVarFromFriendListView_IWindowController_1_2 = IWindowController_1(_mainWindow.content.findChildByName("footer"));
         UnknownVarFromFriendListView_FriendListTabsView_1.prepare(UnknownVarFromFriendListView_IWindowController_1_1);
         _mainWindow.procedure = onWindow;
         _mainWindow.content.setParamFlag(3072,false);
         _mainWindow.content.setParamFlag(0,true);
         _mainWindow.header.setParamFlag(192,false);
         _mainWindow.header.setParamFlag(0,true);
         _mainWindow.content.setParamFlag(192,false);
         _mainWindow.content.setParamFlag(0,true);
         var _loc1_:Boolean = _friendList.getBoolean("friendship.category.management.enabled");
         if(_loc1_ && _friendList.getInteger("spaweb",0) != 1)
         {
            _mainWindow.findChildByName("open_edit_ctgs_but").procedure = onEditCategoriesButtonClick;
         }
         else
         {
            _mainWindow.findChildByName("open_edit_ctgs_but").visible = false;
         }
         UnknownVarFromFriendListView_ITextWindow_1 = ITextWindow(_mainWindow.findChildByName("info_text"));
         UnknownVarFromFriendListView_ITextWindow_1.text = "";
         _friendList.refreshButton(_mainWindow,"open_edit_ctgs",true,null,0);
         refresh("prepare");
         _mainWindow.height = 350;
         _mainWindow.width = 230;
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         Logger.log("Close window");
         _mainWindow.visible = false;
         _friendList.trackFriendListEvent("HABBO_FRIENDLIST_TRACKING_EVENT_CLOSED");
         _friendList.categories.view.refreshed();
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WE_RELOCATE" || param1.type == "WE_RESIZED")
         {
            _friendList.categories.view.refreshed();
         }
         if(param1.type != "WE_RESIZED" || param2 != _mainWindow)
         {
            return;
         }
         if(this._ignoreResizeEvents)
         {
            return;
         }
         var _loc3_:int = UnknownVarFromFriendListView_Int_1 == -1 ? 0 : _mainWindow.height - UnknownVarFromFriendListView_Int_1;
         var _loc4_:int = _lastWindowWidth == -1 ? 0 : _mainWindow.width - _lastWindowWidth;
         _friendList.tabs.tabContentHeight = Math.max(100,_friendList.tabs.tabContentHeight + _loc3_);
         _friendList.tabs.windowWidth = Math.max(147,_friendList.tabs.windowWidth + _loc4_);
         refresh("resize: " + _loc3_);
      }
      
      private function refreshWindowSize() : void
      {
         this._ignoreResizeEvents = true;
         UnknownVarFromFriendListView_IWindowController_1_2.visible = false;
         UnknownVarFromFriendListView_IWindowController_1_2.y = Util.getLowestPoint(_mainWindow.content);
         UnknownVarFromFriendListView_IWindowController_1_2.width = _friendList.tabs.windowWidth;
         UnknownVarFromFriendListView_IWindowController_1_2.visible = true;
         _mainWindow.content.height = Util.getLowestPoint(_mainWindow.content);
         _mainWindow.content.width = _friendList.tabs.windowWidth - 10;
         _mainWindow.header.width = _friendList.tabs.windowWidth - 10;
         _mainWindow.height = _mainWindow.content.height + 30;
         _mainWindow.width = _friendList.tabs.windowWidth;
         this._ignoreResizeEvents = false;
         _mainWindow.scaler.setParamFlag(12288,false);
         _mainWindow.scaler.setParamFlag(12288,this._friendList.tabs.findSelectedTab() != null);
         _mainWindow.scaler.setParamFlag(192,false);
         _mainWindow.scaler.setParamFlag(3072,false);
         _mainWindow.scaler.x = _mainWindow.width - _mainWindow.scaler.width;
         _mainWindow.scaler.y = _mainWindow.height - _mainWindow.scaler.height;
         UnknownVarFromFriendListView_Int_1 = _mainWindow.height;
         _lastWindowWidth = _mainWindow.width;
         Logger.log("RESIZED: " + _friendList.tabs.windowWidth);
      }
      
      private function onEditCategoriesButtonClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.preferences}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         Logger.log("Edit categories clicked");
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         _friendList.openHabboWebPage("link.format.friendlist.pref",new Dictionary(),_loc3_.stageX,_loc3_.stageY);
      }
      
      public function get mainWindow() : IWindowController_1
      {
         return _mainWindow;
      }
      
      public function alignBottomLeftTo(param1:Point) : void
      {
         var _loc2_:Point = param1.clone();
         _loc2_.y -= _mainWindow.height;
         var _loc3_:int = int(_friendList.windowManager.getWindowContext(1).getDesktopWindow().width);
         _loc2_.x = Math.min(_loc3_ - _mainWindow.width,_loc2_.x);
         _loc2_.x = Math.max(110,_loc2_.x);
         _mainWindow.position = _loc2_;
      }
   }
}


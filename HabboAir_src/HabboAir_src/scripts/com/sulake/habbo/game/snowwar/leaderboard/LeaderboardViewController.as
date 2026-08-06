package com.sulake.habbo.game.snowwar.leaderboard
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.communication.messages.parser.game.score.LeaderboardEntry;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class LeaderboardViewController implements IComponentInterfaceQueue, UnknownIHabboAvatar1
   {
      private static const STATE_FRIENDS_ALLTIME:int = 0;
      
      private static const STATE_ALLTIME:int = 1;
      
      private static const STATE_WEEKLY:int = 2;
      
      private static const STATE_FRIENDS_WEEKLY:int = 3;
      
      private static const STATE_GROUP_WEEKLY:int = 4;
      
      private static const STATE_GROUP_ALLTIME:int = 5;
      
      private var UnknownVarFromLeaderboardViewController_SnowWarEngine_1:SnowWarEngine;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _window:IWindowController_1;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromLeaderboardViewController_Int_1:int;
      
      private var UnknownVarFromLeaderboardViewController_IItemListWindow_1:IItemListWindow;
      
      private var _listBorder:IWindowModel;
      
      private var UnknownVarFromLeaderboardViewController_ITextLinkWindow_1:ITextLinkWindow;
      
      private var UnknownVarFromLeaderboardViewController_ITextLinkWindow_2:ITextLinkWindow;
      
      private var UnknownVarFromLeaderboardViewController_ITextLinkWindow_3:ITextLinkWindow;
      
      private var UnknownVarFromLeaderboardViewController_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromLeaderboardViewController_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromLeaderboardViewController_IBitmapWrapperController_2:IBitmapWrapperController;
      
      private var UnknownVarFromLeaderboardViewController_ITextWindow_2:ITextWindow;
      
      private var UnknownVarFromLeaderboardViewController_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromLeaderboardViewController_IRegionWindow_2:IRegionWindow;
      
      private var _nextWeek:IRegionWindow;
      
      private var _previousWeek:IRegionWindow;
      
      private var UnknownVarFromLeaderboardViewController_String_1:String;
      
      private var UnknownVarFromLeaderboardViewController_Int_2:int;
      
      private var UnknownVarFromLeaderboardViewController_Timer_1:Timer;
      
      private var _avatarPlaceholders:Map;
      
      private var UnknownVarFromLeaderboardViewController_LeaderboardTable_1:LeaderboardTable;
      
      private var UnknownVarFromLeaderboardViewController_TotalLeaderboardTable_1:TotalLeaderboardTable;
      
      private var UnknownVarFromLeaderboardViewController_TotalGroupLeaderboardTable_1:TotalGroupLeaderboardTable;
      
      private var UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1:WeeklyTotalLeaderboardTable;
      
      private var UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1:WeeklyGroupLeaderboardTable;
      
      private var UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1:WeeklyFriendLeaderboardTable;
      
      private var UnknownVarFromLeaderboardViewController_Boolean_1:Boolean;
      
      private var _selectedGame:int = 0;
      
      public function LeaderboardViewController(param1:SnowWarEngine)
      {
         super();
         UnknownVarFromLeaderboardViewController_SnowWarEngine_1 = param1;
         _localization = param1.localization;
         _avatarPlaceholders = new Map();
         UnknownVarFromLeaderboardViewController_Boolean_1 = UnknownVarFromLeaderboardViewController_SnowWarEngine_1.config.getBoolean("games.highscores.scrolling.enabled");
         UnknownVarFromLeaderboardViewController_LeaderboardTable_1 = new LeaderboardTable(UnknownVarFromLeaderboardViewController_SnowWarEngine_1);
         UnknownVarFromLeaderboardViewController_TotalLeaderboardTable_1 = new TotalLeaderboardTable(UnknownVarFromLeaderboardViewController_SnowWarEngine_1);
         UnknownVarFromLeaderboardViewController_TotalGroupLeaderboardTable_1 = new TotalGroupLeaderboardTable(UnknownVarFromLeaderboardViewController_SnowWarEngine_1);
         UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1 = new WeeklyTotalLeaderboardTable(UnknownVarFromLeaderboardViewController_SnowWarEngine_1);
         UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1 = new WeeklyGroupLeaderboardTable(UnknownVarFromLeaderboardViewController_SnowWarEngine_1);
         UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1 = new WeeklyFriendLeaderboardTable(UnknownVarFromLeaderboardViewController_SnowWarEngine_1);
         sendGetFriendsAllTimeData();
      }
      
      public function set selectedGame(param1:int) : void
      {
         _selectedGame = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromLeaderboardViewController_SnowWarEngine_1 = null;
         UnknownVarFromLeaderboardViewController_IItemListWindow_1 = null;
         _listBorder = null;
         UnknownVarFromLeaderboardViewController_ITextLinkWindow_1 = null;
         UnknownVarFromLeaderboardViewController_ITextLinkWindow_2 = null;
         UnknownVarFromLeaderboardViewController_ITextLinkWindow_3 = null;
         UnknownVarFromLeaderboardViewController_IBitmapWrapperController_1 = null;
         UnknownVarFromLeaderboardViewController_ITextWindow_1 = null;
         UnknownVarFromLeaderboardViewController_IBitmapWrapperController_2 = null;
         UnknownVarFromLeaderboardViewController_ITextWindow_2 = null;
         UnknownVarFromLeaderboardViewController_IRegionWindow_1 = null;
         UnknownVarFromLeaderboardViewController_IRegionWindow_2 = null;
         _nextWeek = null;
         _previousWeek = null;
         UnknownVarFromLeaderboardViewController_String_1 = null;
         _avatarPlaceholders.dispose();
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromLeaderboardViewController_LeaderboardTable_1)
         {
            UnknownVarFromLeaderboardViewController_LeaderboardTable_1.dispose();
            UnknownVarFromLeaderboardViewController_LeaderboardTable_1 = null;
         }
         if(UnknownVarFromLeaderboardViewController_TotalLeaderboardTable_1)
         {
            UnknownVarFromLeaderboardViewController_TotalLeaderboardTable_1.dispose();
            UnknownVarFromLeaderboardViewController_TotalLeaderboardTable_1 = null;
         }
         if(UnknownVarFromLeaderboardViewController_TotalGroupLeaderboardTable_1)
         {
            UnknownVarFromLeaderboardViewController_TotalGroupLeaderboardTable_1.dispose();
            UnknownVarFromLeaderboardViewController_TotalGroupLeaderboardTable_1 = null;
         }
         if(UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1)
         {
            UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.dispose();
            UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1 = null;
         }
         if(UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1)
         {
            UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.dispose();
            UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1 = null;
         }
         if(UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1)
         {
            UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.dispose();
            UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1 = null;
         }
         disposeWeeklyResetTimer();
         _disposed = true;
      }
      
      private function disposeWeeklyResetTimer() : void
      {
         if(UnknownVarFromLeaderboardViewController_Timer_1 != null)
         {
            UnknownVarFromLeaderboardViewController_Timer_1.removeEventListener("timer",onTick);
            UnknownVarFromLeaderboardViewController_Timer_1.stop();
            UnknownVarFromLeaderboardViewController_Timer_1 = null;
         }
      }
      
      private function startWeeklyResetTimer(param1:int) : void
      {
         UnknownVarFromLeaderboardViewController_Timer_1 = new Timer(60000,param1);
         UnknownVarFromLeaderboardViewController_Timer_1.addEventListener("timer",onTick);
         UnknownVarFromLeaderboardViewController_Timer_1.start();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function enableAllTimeButton() : void
      {
         UnknownVarFromLeaderboardViewController_ITextWindow_1.textColor = 0;
         UnknownVarFromLeaderboardViewController_ITextWindow_2.textColor = 16777215;
         WindowUtils.setElementImage(UnknownVarFromLeaderboardViewController_IBitmapWrapperController_1,getBitmap("left_blue"));
         WindowUtils.setElementImage(UnknownVarFromLeaderboardViewController_IBitmapWrapperController_2,getBitmap("right_black"));
      }
      
      private function enableThisWeekButton() : void
      {
         UnknownVarFromLeaderboardViewController_ITextWindow_1.textColor = 16777215;
         UnknownVarFromLeaderboardViewController_ITextWindow_2.textColor = 0;
         WindowUtils.setElementImage(UnknownVarFromLeaderboardViewController_IBitmapWrapperController_1,getBitmap("left_black"));
         WindowUtils.setElementImage(UnknownVarFromLeaderboardViewController_IBitmapWrapperController_2,getBitmap("right_blue"));
      }
      
      public function showFriendsAllTime() : void
      {
         UnknownVarFromLeaderboardViewController_Int_1 = 0;
         sendGetFriendsAllTimeData();
         visible = true;
         _window.caption = "${snowwar.leaderboard.friends}";
         enableAllTimeButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showAllTime() : void
      {
         UnknownVarFromLeaderboardViewController_Int_1 = 1;
         sendGetAllTimeData();
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableAllTimeButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showGroupAllTime() : void
      {
         UnknownVarFromLeaderboardViewController_Int_1 = 5;
         sendGetAllTimeGroupData();
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableAllTimeButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showWeekly() : void
      {
         UnknownVarFromLeaderboardViewController_Int_1 = 2;
         UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.offset = 0;
         sendGetWeeklyData(0);
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableThisWeekButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showGroupWeekly() : void
      {
         UnknownVarFromLeaderboardViewController_Int_1 = 4;
         UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.offset = 0;
         sendGetGroupWeeklyData(0);
         visible = true;
         _window.caption = "${snowwar.leaderboard.all}";
         enableThisWeekButton();
         updateWeekSelection();
         populateList();
      }
      
      public function showFriendsWeekly() : void
      {
         UnknownVarFromLeaderboardViewController_Int_1 = 3;
         UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.offset = 0;
         sendGetFriendsWeeklyData(0);
         visible = true;
         _window.caption = "${snowwar.leaderboard.friends}";
         enableThisWeekButton();
         updateWeekSelection();
         populateList();
      }
      
      public function addAllTimeData(param1:Array, param2:int) : void
      {
         UnknownVarFromLeaderboardViewController_TotalLeaderboardTable_1.addEntries(param1,param2);
         if(UnknownVarFromLeaderboardViewController_Int_1 == 1 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addAllTimeGroupData(param1:Array, param2:int, param3:int) : void
      {
         UnknownVarFromLeaderboardViewController_TotalGroupLeaderboardTable_1.addGroupEntries(param1,param2,param3);
         if(UnknownVarFromLeaderboardViewController_Int_1 == 5 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addWeeklyData(param1:int, param2:int, param3:Array, param4:int, param5:int, param6:int) : void
      {
         disposeWeeklyResetTimer();
         UnknownVarFromLeaderboardViewController_Int_2 = param6;
         UnknownVarFromLeaderboardViewController_String_1 = param1 + "/" + param2;
         UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.maxOffset = param5;
         UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.addEntries(param3,param4);
         if(UnknownVarFromLeaderboardViewController_Int_1 == 2 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addWeeklyGroupData(param1:int, param2:int, param3:Array, param4:int, param5:int, param6:int, param7:int) : void
      {
         disposeWeeklyResetTimer();
         UnknownVarFromLeaderboardViewController_Int_2 = param6;
         UnknownVarFromLeaderboardViewController_String_1 = param1 + "/" + param2;
         UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.maxOffset = param5;
         UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.addGroupEntries(param3,param4,param7);
         if(UnknownVarFromLeaderboardViewController_Int_1 == 4 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addFriendAllTimeData(param1:Array, param2:int) : void
      {
         UnknownVarFromLeaderboardViewController_LeaderboardTable_1.addEntries(param1,param2);
         if(UnknownVarFromLeaderboardViewController_Int_1 == 0 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function addFriendWeeklyData(param1:int, param2:int, param3:Array, param4:int, param5:int, param6:int) : void
      {
         disposeWeeklyResetTimer();
         UnknownVarFromLeaderboardViewController_Int_2 = param6;
         UnknownVarFromLeaderboardViewController_String_1 = param1 + "/" + param2;
         UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.maxOffset = param5;
         UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.addEntries(param3,param4);
         if(UnknownVarFromLeaderboardViewController_Int_1 == 3 && visible)
         {
            populateList();
         }
         updateWeekSelection();
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc2_:IBitmapWrapperController = _avatarPlaceholders.remove(param1);
         if(_loc2_ && !_loc2_.disposed)
         {
            setAvatarImage(_loc2_,param1);
         }
      }
      
      private function sendGetFriendsAllTimeData() : void
      {
         UnknownVarFromLeaderboardViewController_LeaderboardTable_1.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetAllTimeData() : void
      {
         UnknownVarFromLeaderboardViewController_TotalLeaderboardTable_1.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetAllTimeGroupData() : void
      {
         UnknownVarFromLeaderboardViewController_TotalGroupLeaderboardTable_1.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetWeeklyData(param1:int) : void
      {
         UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.offset = param1;
         UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetGroupWeeklyData(param1:int) : void
      {
         UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.offset = param1;
         UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.revertToDefaultView(_selectedGame);
      }
      
      private function sendGetFriendsWeeklyData(param1:int) : void
      {
         UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.offset = param1;
         UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.revertToDefaultView(_selectedGame);
      }
      
      private function get visible() : Boolean
      {
         return _window && _window.visible;
      }
      
      private function set visible(param1:Boolean) : void
      {
         if(param1 && !_window)
         {
            createMainWindow();
         }
         if(param1)
         {
            _window.visible = true;
            _window.activate();
         }
         else if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function createMainWindow() : void
      {
         var _loc2_:IWindowModel = null;
         var _loc1_:IWindowModel = null;
         if(!_window)
         {
            _window = WindowUtils.createWindow("snowwar_leaderboard",1) as IWindowController_1;
            _window.center();
            _window.findChildByTag("close").addEventListener("WME_CLICK",onClose);
            UnknownVarFromLeaderboardViewController_IItemListWindow_1 = _window.findChildByName("list") as IItemListWindow;
            _listBorder = _window.findChildByName("listBorder");
            UnknownVarFromLeaderboardViewController_ITextLinkWindow_1 = _window.findChildByName("changeView") as ITextLinkWindow;
            UnknownVarFromLeaderboardViewController_ITextLinkWindow_1.addEventListener("WME_CLICK",onChangeView);
            UnknownVarFromLeaderboardViewController_ITextLinkWindow_2 = _window.findChildByName("changeGroupView") as ITextLinkWindow;
            UnknownVarFromLeaderboardViewController_ITextLinkWindow_2.addEventListener("WME_CLICK",onChangeGroupView);
            UnknownVarFromLeaderboardViewController_ITextLinkWindow_3 = _window.findChildByName("changeFriendsView") as ITextLinkWindow;
            UnknownVarFromLeaderboardViewController_ITextLinkWindow_3.addEventListener("WME_CLICK",onChangeFriendsView);
            _loc2_ = _window.findChildByName("all_time_region");
            _loc2_.addEventListener("WME_DOWN",onAllTimeButtonDown);
            _loc1_ = _window.findChildByName("this_week_region");
            _loc1_.addEventListener("WME_DOWN",onThisWeekButtonDown);
            UnknownVarFromLeaderboardViewController_IBitmapWrapperController_2 = _window.findChildByName("all_time_image") as IBitmapWrapperController;
            UnknownVarFromLeaderboardViewController_IBitmapWrapperController_1 = _window.findChildByName("this_week_image") as IBitmapWrapperController;
            UnknownVarFromLeaderboardViewController_ITextWindow_2 = _window.findChildByName("all_time_text") as ITextWindow;
            UnknownVarFromLeaderboardViewController_ITextWindow_1 = _window.findChildByName("this_week_text") as ITextWindow;
            UnknownVarFromLeaderboardViewController_IRegionWindow_1 = _window.findChildByName("scrollUp") as IRegionWindow;
            addScrollButtonEventListeners(UnknownVarFromLeaderboardViewController_IRegionWindow_1);
            WindowUtils.setElementImage(UnknownVarFromLeaderboardViewController_IRegionWindow_1.getChildAt(0),getBitmap("scroll_up_normal"));
            UnknownVarFromLeaderboardViewController_IRegionWindow_2 = _window.findChildByName("scrollDown") as IRegionWindow;
            addScrollButtonEventListeners(UnknownVarFromLeaderboardViewController_IRegionWindow_2);
            WindowUtils.setElementImage(UnknownVarFromLeaderboardViewController_IRegionWindow_2.getChildAt(0),getBitmap("scroll_down_normal"));
            _nextWeek = _window.findChildByName("nextWeek") as IRegionWindow;
            _nextWeek.addEventListener("WME_CLICK",onNextWeekButton);
            _nextWeek.visible = false;
            _previousWeek = _window.findChildByName("previousWeek") as IRegionWindow;
            _previousWeek.addEventListener("WME_CLICK",onPreviousWeekButton);
            _previousWeek.visible = false;
            updateScrollButtons();
            updateWeekSelection();
         }
      }
      
      private function addScrollButtonEventListeners(param1:IWindowModel) : void
      {
         param1.addEventListener("WME_CLICK",onScrollButton);
         param1.addEventListener("WME_OVER",onScrollButton);
         param1.addEventListener("WME_OUT",onScrollButton);
         param1.addEventListener("WME_DOWN",onScrollButton);
         param1.addEventListener("WME_UP",onScrollButton);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      private function onChangeView(param1:WindowMouseEvent) : void
      {
         switch(UnknownVarFromLeaderboardViewController_Int_1 - 1)
         {
            case 0:
               showAllTime();
               break;
            case 1:
               showWeekly();
               break;
            default:
               UnknownVarFromLeaderboardViewController_Int_1 = 2;
               showWeekly();
         }
      }
      
      private function onChangeFriendsView(param1:WindowMouseEvent) : void
      {
         switch(UnknownVarFromLeaderboardViewController_Int_1)
         {
            case 0:
               showFriendsAllTime();
               break;
            case 3:
               showFriendsWeekly();
               break;
            default:
               UnknownVarFromLeaderboardViewController_Int_1 = 3;
               showFriendsWeekly();
         }
      }
      
      private function onChangeGroupView(param1:WindowMouseEvent) : void
      {
         switch(UnknownVarFromLeaderboardViewController_Int_1 - 4)
         {
            case 0:
               showGroupWeekly();
               break;
            case 1:
               showGroupAllTime();
               break;
            default:
               UnknownVarFromLeaderboardViewController_Int_1 = 4;
               showGroupWeekly();
         }
      }
      
      private function onAllTimeButtonDown(param1:WindowMouseEvent) : void
      {
         switch(UnknownVarFromLeaderboardViewController_Int_1 - 2)
         {
            case 0:
               showAllTime();
               break;
            case 1:
               showFriendsAllTime();
               break;
            case 2:
               showGroupAllTime();
         }
      }
      
      private function onThisWeekButtonDown(param1:WindowMouseEvent) : void
      {
         switch(UnknownVarFromLeaderboardViewController_Int_1)
         {
            case 0:
               showFriendsWeekly();
               break;
            case 1:
               showWeekly();
               break;
            case 5:
               showGroupWeekly();
         }
      }
      
      private function getCurrentLeaderboard() : LeaderboardTable
      {
         var _loc1_:LeaderboardTable = null;
         switch(UnknownVarFromLeaderboardViewController_Int_1)
         {
            case 0:
               _loc1_ = UnknownVarFromLeaderboardViewController_LeaderboardTable_1;
               break;
            case 1:
               _loc1_ = UnknownVarFromLeaderboardViewController_TotalLeaderboardTable_1;
               break;
            case 2:
               _loc1_ = UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1;
               break;
            case 3:
               _loc1_ = UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1;
               break;
            case 4:
               _loc1_ = UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1;
               break;
            case 5:
               _loc1_ = UnknownVarFromLeaderboardViewController_TotalGroupLeaderboardTable_1;
               break;
            default:
               HabboGamesCom.log("Invalid state " + UnknownVarFromLeaderboardViewController_Int_1);
         }
         return _loc1_;
      }
      
      private function onScrollUp() : void
      {
         var _loc1_:LeaderboardTable = getCurrentLeaderboard();
         if(_loc1_ && _loc1_.scrollUp())
         {
            populateList();
         }
      }
      
      private function onScrollDown() : void
      {
         var _loc1_:LeaderboardTable = getCurrentLeaderboard();
         if(_loc1_ && _loc1_.scrollDown())
         {
            populateList();
         }
      }
      
      private function onScrollButton(param1:WindowMouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = param1.window == UnknownVarFromLeaderboardViewController_IRegionWindow_1 ? "up" : "down";
         switch(param1.type)
         {
            case "WME_CLICK":
               param1.window == UnknownVarFromLeaderboardViewController_IRegionWindow_1 ? onScrollUp() : onScrollDown();
               return;
            case "WME_OUT":
               _loc4_ = "normal";
               break;
            case "WME_OVER":
               _loc4_ = "hilite";
               break;
            case "WME_DOWN":
               _loc4_ = "click";
               break;
            case "WME_UP":
               _loc4_ = "normal";
         }
         var _loc3_:String = "scroll_" + _loc5_ + "_" + _loc4_;
         var _loc2_:IWindowController_1 = param1.window as IWindowController_1;
         WindowUtils.setElementImage(_loc2_.getChildAt(0),getBitmap(_loc3_));
      }
      
      private function onNextWeekButton(param1:WindowMouseEvent) : void
      {
         if(_nextWeek.visible)
         {
            switch(UnknownVarFromLeaderboardViewController_Int_1 - 2)
            {
               case 0:
                  sendGetWeeklyData(UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.offset - 1);
                  break;
               case 1:
                  sendGetFriendsWeeklyData(UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.offset - 1);
                  break;
               case 2:
                  sendGetGroupWeeklyData(UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.offset - 1);
            }
         }
      }
      
      private function onPreviousWeekButton(param1:WindowMouseEvent) : void
      {
         if(_previousWeek.visible)
         {
            switch(UnknownVarFromLeaderboardViewController_Int_1 - 2)
            {
               case 0:
                  sendGetWeeklyData(UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.offset + 1);
                  break;
               case 1:
                  sendGetFriendsWeeklyData(UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.offset + 1);
                  break;
               case 2:
                  sendGetGroupWeeklyData(UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1 + 1);
            }
         }
      }
      
      private function updateWeekSelection() : void
      {
         var _loc1_:* = null;
         switch(UnknownVarFromLeaderboardViewController_Int_1 - 2)
         {
            case 0:
               _nextWeek.visible = UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.offset > 0;
               _previousWeek.visible = UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.offset < UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.maxOffset;
               break;
            case 1:
               _nextWeek.visible = UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.offset > 0;
               _previousWeek.visible = UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.offset < UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.maxOffset;
               break;
            case 2:
               _nextWeek.visible = UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.offset > 0;
               _previousWeek.visible = UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.offset < UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.maxOffset;
               break;
            default:
               _nextWeek.visible = false;
               _previousWeek.visible = false;
         }
         if(_nextWeek.visible)
         {
            UnknownVarFromLeaderboardViewController_ITextWindow_1.caption = UnknownVarFromLeaderboardViewController_String_1;
         }
         else
         {
            UnknownVarFromLeaderboardViewController_ITextWindow_1.caption = "${snowwar.leaderboard.this_week}";
         }
         switch(UnknownVarFromLeaderboardViewController_Int_1 - 2)
         {
            case 0:
            case 1:
            case 2:
               if(!_nextWeek.visible)
               {
                  showTimeUntilWeeklyReset();
                  if(UnknownVarFromLeaderboardViewController_Timer_1 == null)
                  {
                     startWeeklyResetTimer(UnknownVarFromLeaderboardViewController_Int_2);
                  }
                  break;
               }
            default:
               WindowUtils.hideElement(_window,"reset_text");
               disposeWeeklyResetTimer();
         }
      }
      
      private function showTimeUntilWeeklyReset() : void
      {
         WindowUtils.showElement(_window,"reset_text");
         var _loc4_:String = "snowwar.leaderboard.weekly_reset";
         var _loc3_:int = convertToDays(UnknownVarFromLeaderboardViewController_Int_2);
         var _loc1_:int = convertToHours(UnknownVarFromLeaderboardViewController_Int_2);
         var _loc2_:int = convertToMinutes(UnknownVarFromLeaderboardViewController_Int_2);
         _localization.registerParameter(_loc4_,"days","" + convertToDays(UnknownVarFromLeaderboardViewController_Int_2));
         _localization.registerParameter(_loc4_,"hours","" + convertToHours(UnknownVarFromLeaderboardViewController_Int_2));
         _localization.registerParameter(_loc4_,"minutes","" + convertToMinutes(UnknownVarFromLeaderboardViewController_Int_2));
         WindowUtils.setCaption(_window.findChildByName("reset_text"),"${" + _loc4_ + "}");
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(!_nextWeek.visible && (UnknownVarFromLeaderboardViewController_Int_1 == 2 || UnknownVarFromLeaderboardViewController_Int_1 == 3))
         {
            if(UnknownVarFromLeaderboardViewController_Int_2 > 0)
            {
               UnknownVarFromLeaderboardViewController_Int_2--;
            }
            showTimeUntilWeeklyReset();
         }
      }
      
      private function convertToDays(param1:int) : int
      {
         return Math.floor(param1 / 60 / 24);
      }
      
      private function convertToHours(param1:int) : int
      {
         var _loc2_:int = convertToDays(param1);
         return Math.floor((param1 - _loc2_ * 24 * 60) / 60);
      }
      
      private function convertToMinutes(param1:int) : int
      {
         var _loc3_:int = convertToDays(param1);
         var _loc2_:int = convertToHours(param1);
         return param1 - _loc3_ * 24 * 60 - _loc2_ * 60;
      }
      
      private function getData() : Array
      {
         switch(UnknownVarFromLeaderboardViewController_Int_1)
         {
            case 0:
               return UnknownVarFromLeaderboardViewController_LeaderboardTable_1.getVisibleEntries();
            case 1:
               return UnknownVarFromLeaderboardViewController_TotalLeaderboardTable_1.getVisibleEntries();
            case 2:
               return UnknownVarFromLeaderboardViewController_WeeklyTotalLeaderboardTable_1.getVisibleEntries();
            case 3:
               return UnknownVarFromLeaderboardViewController_WeeklyFriendLeaderboardTable_1.getVisibleEntries();
            case 4:
               return UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.getVisibleEntries();
            case 5:
               return UnknownVarFromLeaderboardViewController_TotalGroupLeaderboardTable_1.getVisibleEntries();
            default:
               return null;
         }
      }
      
      private function getFavouriteGroupId() : int
      {
         switch(UnknownVarFromLeaderboardViewController_Int_1 - 4)
         {
            case 0:
               return UnknownVarFromLeaderboardViewController_WeeklyGroupLeaderboardTable_1.favouriteGroupId;
            case 1:
               return UnknownVarFromLeaderboardViewController_TotalGroupLeaderboardTable_1.favouriteGroupId;
            default:
               return -1;
         }
      }
      
      private function populateList() : void
      {
         var _loc8_:LeaderboardEntry = null;
         var _loc15_:IWindowController_1 = null;
         var _loc11_:* = false;
         var _loc13_:Boolean = false;
         var _loc1_:Boolean = false;
         var _loc2_:IWindowController_1 = null;
         var _loc6_:IWindowModel = null;
         var _loc7_:int = 0;
         var _loc14_:IWindowController_1 = null;
         var _loc3_:IWindowController_1 = null;
         var _loc4_:Array = getData();
         var _loc10_:int = getFavouriteGroupId();
         var _loc9_:int = UnknownVarFromLeaderboardViewController_SnowWarEngine_1.sessionDataManager.userId;
         if(!_loc4_ || _loc4_.length == 0)
         {
            UnknownVarFromLeaderboardViewController_IItemListWindow_1.visible = false;
            _listBorder.visible = false;
            return;
         }
         var _loc5_:int = 0;
         UnknownVarFromLeaderboardViewController_IItemListWindow_1.destroyListItems();
         var _loc12_:IWindowController_1 = WindowUtils.createWindow("snowwar_leaderboard_entry") as IWindowController_1;
         while(_loc5_ < _loc4_.length)
         {
            _loc8_ = _loc4_[_loc5_];
            if(_loc8_)
            {
               _loc15_ = _loc12_.clone() as IWindowController_1;
               _loc15_.findChildByName("rank").caption = _loc8_.rank.toString();
               _loc15_.findChildByName("score").caption = _loc8_.score.toString();
               _loc15_.findChildByName("name").caption = _loc8_.name;
               _loc11_ = _loc8_.gender == "g";
               if(_loc11_)
               {
                  setGroupBadgeImage(_loc15_.findChildByName("avatarImage") as IBitmapWrapperController,_loc8_.figure);
               }
               else
               {
                  setAvatarImage(_loc15_.findChildByName("avatarImage") as IBitmapWrapperController,_loc8_.figure,_loc8_.gender);
               }
               _loc13_ = UnknownVarFromLeaderboardViewController_Int_1 == 1 || UnknownVarFromLeaderboardViewController_Int_1 == 5;
               _loc1_ = _loc13_ && (_loc8_.userId == _loc9_ || _loc11_ && _loc8_.userId == _loc10_);
               if(!_loc11_ && _loc8_.userId != UnknownVarFromLeaderboardViewController_SnowWarEngine_1.sessionDataManager.userId || _loc11_ && _loc8_.userId != _loc10_ || _loc1_ && _loc5_ < _loc4_.length - 1)
               {
                  _loc15_.findChildByName("highlight").visible = false;
                  _loc15_.findChildByName("divider").visible = false;
                  _loc2_ = UnknownVarFromLeaderboardViewController_IItemListWindow_1.getListItemAt(UnknownVarFromLeaderboardViewController_IItemListWindow_1.numListItems - 1) as IWindowController_1;
                  if(_loc2_)
                  {
                     _loc2_.findChildByName("divider").visible = false;
                  }
               }
               _loc15_.findChildByName("imageRegion").id = _loc8_.userId;
               if(_loc8_.gender == "g")
               {
                  _loc15_.findChildByName("imageRegion").addEventListener("WME_CLICK",onGroupImageRegion);
               }
               else
               {
                  _loc15_.findChildByName("imageRegion").addEventListener("WME_CLICK",onImageRegion);
               }
               UnknownVarFromLeaderboardViewController_IItemListWindow_1.addListItem(_loc15_);
            }
            _loc5_++;
         }
         if(UnknownVarFromLeaderboardViewController_Int_1 == 1 || UnknownVarFromLeaderboardViewController_Int_1 == 5 || UnknownVarFromLeaderboardViewController_Int_1 == 2 || UnknownVarFromLeaderboardViewController_Int_1 == 4)
         {
            if(_loc5_ % UnknownVarFromLeaderboardViewController_LeaderboardTable_1.viewSize != 0)
            {
               _loc6_ = UnknownVarFromLeaderboardViewController_IItemListWindow_1.getListItemAt(UnknownVarFromLeaderboardViewController_IItemListWindow_1.numListItems - 1);
               _loc7_ = 0;
               while(_loc7_ < _loc5_ % UnknownVarFromLeaderboardViewController_LeaderboardTable_1.viewSize - 1)
               {
                  _loc14_ = _loc12_.clone() as IWindowController_1;
                  _loc14_.findChildByName("rank").caption = "";
                  _loc14_.findChildByName("score").caption = "";
                  _loc14_.findChildByName("name").caption = "";
                  _loc14_.findChildByName("highlight").visible = false;
                  _loc14_.findChildByName("divider").visible = false;
                  _loc3_ = UnknownVarFromLeaderboardViewController_IItemListWindow_1.getListItemAt(UnknownVarFromLeaderboardViewController_IItemListWindow_1.numListItems - 1) as IWindowController_1;
                  if(_loc3_)
                  {
                     _loc3_.findChildByName("divider").visible = false;
                  }
                  _loc14_.removeChild(_loc14_.findChildByName("imageRegion"));
                  UnknownVarFromLeaderboardViewController_IItemListWindow_1.addListItem(_loc14_);
                  _loc7_++;
               }
               UnknownVarFromLeaderboardViewController_IItemListWindow_1.addListItem(_loc6_);
            }
         }
         _loc12_.dispose();
         _loc12_ = UnknownVarFromLeaderboardViewController_IItemListWindow_1.getListItemAt(UnknownVarFromLeaderboardViewController_IItemListWindow_1.numListItems - 1) as IWindowController_1;
         if(_loc12_)
         {
            _loc12_.findChildByName("divider").visible = false;
         }
         UnknownVarFromLeaderboardViewController_IItemListWindow_1.visible = true;
         _listBorder.visible = true;
         updateScrollButtons();
         _window.invalidate();
      }
      
      private function setGroupBadgeImage(param1:IBitmapWrapperController, param2:String) : *
      {
         var _loc3_:BitmapData = UnknownVarFromLeaderboardViewController_SnowWarEngine_1.sessionDataManager.getGroupBadgeImage(param2);
         if(_loc3_)
         {
            _avatarPlaceholders.remove(param2);
            _avatarPlaceholders.add(param2,param1);
            WindowUtils.setElementImage(param1,_loc3_);
            _loc3_.dispose();
         }
      }
      
      private function setAvatarImage(param1:IBitmapWrapperController, param2:String, param3:String = null) : void
      {
         var _loc4_:BitmapData = null;
         var _loc5_:IAvatarImage_2 = UnknownVarFromLeaderboardViewController_SnowWarEngine_1.avatarManager.createAvatarImage(param2,"h",param3,this);
         if(_loc5_)
         {
            _loc5_.setDirection("full",2);
            _loc4_ = _loc5_.getCroppedImage("head");
            if(_loc5_.isPlaceholder())
            {
               _avatarPlaceholders.remove(param2);
               _avatarPlaceholders.add(param2,param1);
            }
            _loc5_.dispose();
         }
         WindowUtils.setElementImage(param1,_loc4_);
         _loc4_.dispose();
      }
      
      private function onImageRegion(param1:WindowMouseEvent) : void
      {
         UnknownVarFromLeaderboardViewController_SnowWarEngine_1.groupsManager.showExtendedProfile(param1.window.id);
      }
      
      private function onGroupImageRegion(param1:WindowMouseEvent) : void
      {
         UnknownVarFromLeaderboardViewController_SnowWarEngine_1.groupsManager.showGroupBadgeInfo(false,param1.window.id);
      }
      
      private function updateScrollButtons() : void
      {
         var _loc1_:LeaderboardTable = getCurrentLeaderboard();
         if(_loc1_ && UnknownVarFromLeaderboardViewController_Boolean_1)
         {
            UnknownVarFromLeaderboardViewController_IRegionWindow_1.visible = _loc1_.canScrollUp();
            UnknownVarFromLeaderboardViewController_IRegionWindow_2.visible = _loc1_.canScrollDown();
         }
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         var _loc2_:ISoundAsset = UnknownVarFromLeaderboardViewController_SnowWarEngine_1.assets.getAssetByName(param1);
         if(_loc2_)
         {
            return _loc2_.content as BitmapData;
         }
         return null;
      }
   }
}


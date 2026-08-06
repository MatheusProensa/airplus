package com.sulake.habbo.friendbar.view
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.friendbar.data.FriendRequest;
   import com.sulake.habbo.friendbar.data.IFriendEntity;
   import com.sulake.habbo.friendbar.data.IFriendRequest;
   import com.sulake.habbo.friendbar.data.IHabboFriendBarData;
   import com.sulake.habbo.friendbar.events.ActiveConversationsCountEvent;
   import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
   import com.sulake.habbo.friendbar.events.FriendBarResizeEvent;
   import com.sulake.habbo.friendbar.events.FriendRequestUpdateEvent;
   import com.sulake.habbo.friendbar.events.NewMessageEvent;
   import com.sulake.habbo.friendbar.events.NotificationEvent;
   import com.sulake.habbo.friendbar.view.tabs.AddFriendsTab;
   import com.sulake.habbo.friendbar.view.tabs.FriendEntityTab;
   import com.sulake.habbo.friendbar.view.tabs.FriendRequestTab;
   import com.sulake.habbo.friendbar.view.tabs.FriendRequestsTab;
   import com.sulake.habbo.friendbar.view.tabs.ITab;
   import com.sulake.habbo.friendbar.view.tabs.NewFriendEntityTab;
   import com.sulake.habbo.friendbar.view.tabs.NewFriendRequestTab;
   import com.sulake.habbo.friendbar.view.tabs.NewOpenMessengerTab;
   import com.sulake.habbo.friendbar.view.tabs.Tab;
   import com.sulake.habbo.friendbar.view.tabs.tokens.Token;
   import com.sulake.habbo.friendbar.view.utils.FriendListIcon;
   import com.sulake.habbo.friendbar.view.utils.MessengerIcon;
   import com.sulake.habbo.friendbar.view.utils.TextCropper;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.game.IHabboGameManager;
   import com.sulake.habbo.session.events.SessionDataPreferencesEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.utils.HabboFaceFocuser;
   import com.sulake.iid.IIDHabboFriendBarData;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboGameManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class HabboFriendBarView extends AbstractView implements IHabboFriendBarView, UnknownIHabboAvatar1, ILinkEventTracker
   {
      private static const TAB_WIDTH:int = 127;
      
      private static const UnknownConstFromHabboFriendBarView_Int_1:int = 1;
      
      private static const USE_TOGGLE_WINDOW:Boolean = false;
      
      private static const UnknownConstFromHabboFriendBarView_Int_2:int = 3;
      
      private static const MAIN_WINDOW_RESOURCE:String = "new_bar_xml";
      
      private static const TOGGLE_WINDOW_RESOURCE:String = "toggle_xml";
      
      private static const BORDER:String = "border";
      
      private static const LIST:String = "list";
      
      private static const HEADER:String = "header";
      
      private static const CANVAS:String = "canvas";
      
      private static const PIECES:String = "pieces";
      
      private static const TOOLS:String = "friendtools";
      
      private static const UnknownConstFromHabboFriendBarView_String_1:String = "collapse_left";
      
      private static const BUTTON_COLLAPSE_RIGHT:String = "collapse_right";
      
      private static const UnknownConstFromHabboFriendBarView_String_2:String = "button_left";
      
      private static const UnknownConstFromHabboFriendBarView_String_3:String = "button_right";
      
      private static const BUTTON_LEFT_PAGE:String = "button_left_page";
      
      private static const BUTTON_RIGHT_PAGE:String = "button_right_page";
      
      private static const UnknownConstFromHabboFriendBarView_String_4:String = "button_left_end";
      
      private static const UnknownConstFromHabboFriendBarView_String_5:String = "button_right_end";
      
      private static const UnknownConstFromHabboFriendBarView_String_6:String = "button_close";
      
      private static const UnknownConstFromHabboFriendBarView_String_7:String = "button_open";
      
      private static const LINK_FRIEND_LIST:String = "link_friendlist";
      
      private static const ICON_FIND_FRIENDS:String = "icon_find_friends";
      
      private static const ICON_ALL_FRIENDS:String = "icon_all_friends";
      
      private static const COLLAPSED_MARGIN:int = 150;
      
      private static const NEW_BAR_BOTTOM_OFFSET:int = 1;
      
      private static const NEW_BAR_RIGHT_MARGIN:int = 16;
      
      private static const COLLAPSE_ANIMATION_DURATION_MS:int = 140;
      
      private static const COLLAPSE_ANIMATION_FPS:int = 60;
      
      private var _friendBarData:IHabboFriendBarData;
      
      private var _gameManager:IHabboGameManager;
      
      private var _friendList:IHabboFriendList;
      
      private var _toolbar:IHabboToolbar;
      
      private var UnknownVarFromHabboFriendBarView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromHabboFriendBarView_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromHabboFriendBarView_IWindowController_1_3:IWindowController_1;
      
      private var UnknownVarFromHabboFriendBarView_Vector_1:Vector.<ITab>;
      
      private var UnknownVarFromHabboFriendBarView_ITab_1:ITab;
      
      private var UnknownVarFromHabboFriendBarView_Int_1:int = -1;
      
      private var UnknownVarFromHabboFriendBarView_Int_2:int = 0;
      
      private var UnknownVarFromHabboFriendBarView_TextCropper_1:TextCropper;
      
      private var UnknownVarFromHabboFriendBarView_FriendListIcon_1:FriendListIcon;
      
      private var UnknownVarFromHabboFriendBarView_MessengerIcon_1:MessengerIcon;
      
      private var UnknownVarFromHabboFriendBarView_IWindowController_1_4:IWindowController_1;
      
      private var UnknownVarFromHabboFriendBarView_NewOpenMessengerTab_1:NewOpenMessengerTab;
      
      private var UnknownVarFromHabboFriendBarView_Boolean_1:Boolean = true;
      
      private var UnknownVarFromHabboFriendBarView_Timer_1:Timer;
      
      private var UnknownVarFromHabboFriendBarView_Boolean_2:Boolean = false;
      
      private var UnknownVarFromHabboFriendBarView_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromHabboFriendBarView_IRegionWindow_2:IRegionWindow;
      
      private var _startingInit:Boolean = false;
      
      private var UnknownVarFromHabboFriendBarView_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromHabboFriendBarView_Timer_2:Timer;
      
      private var UnknownVarFromHabboFriendBarView_Timer_3:Timer;
      
      private var UnknownVarFromHabboFriendBarView_Int_3:int = 0;
      
      private var UnknownVarFromHabboFriendBarView_Number_1:Number = 0;
      
      private var UnknownVarFromHabboFriendBarView_Int_4:int = 0;
      
      private var _collapseAnimationStartWidth:Number = 0;
      
      private var _collapseAnimationTargetWidth:int = 0;
      
      private var _collapseAnimationStartReservedWidth:Number = 0;
      
      private var _collapseAnimationTargetReservedWidth:int = 0;
      
      private var _currentFriendBarWidth:int = 0;
      
      private var _notifyMessengerOnStartup:Boolean = false;
      
      public function HabboFriendBarView(param1:IComponent_2, param2:uint, param3:IAssetLibraryCollection)
      {
         super(param1,param2,param3);
         UnknownVarFromHabboFriendBarView_TextCropper_1 = new TextCropper();
         UnknownVarFromHabboFriendBarView_Vector_1 = new Vector.<ITab>();
         UnknownVarFromHabboFriendBarView_Vector_1 = new Vector.<ITab>();
      }
      
      public function setMessengerIconNotify(param1:Boolean) : void
      {
         if(UnknownVarFromHabboFriendBarView_MessengerIcon_1)
         {
            UnknownVarFromHabboFriendBarView_MessengerIcon_1.notify(param1);
         }
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_4)
         {
            notifyMessenger(param1);
         }
      }
      
      public function get friendBarWidth() : int
      {
         return UnknownVarFromHabboFriendBarView_IWindowController_1_1 == null ? 0 : _currentFriendBarWidth;
      }
      
      public function setFriendListIconNotify(param1:Boolean) : void
      {
         if(UnknownVarFromHabboFriendBarView_FriendListIcon_1)
         {
            UnknownVarFromHabboFriendBarView_FriendListIcon_1.notify(param1);
         }
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendList = param1;
         }),new ComponentDependency(new IIDHabboFriendBarData(),function(param1:IHabboFriendBarData):void
         {
            _friendBarData = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDHabboGameManager(),function(param1:IHabboGameManager):void
         {
            _gameManager = param1;
         })]);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromHabboFriendBarView_Timer_2 != null)
            {
               UnknownVarFromHabboFriendBarView_Timer_2.removeEventListener("timer",onTimerEvent);
               UnknownVarFromHabboFriendBarView_Timer_2.stop();
               UnknownVarFromHabboFriendBarView_Timer_2 = null;
            }
            if(UnknownVarFromHabboFriendBarView_Timer_3 != null)
            {
               UnknownVarFromHabboFriendBarView_Timer_3.removeEventListener("timer",onCollapseAnimationTimer);
               UnknownVarFromHabboFriendBarView_Timer_3.stop();
               UnknownVarFromHabboFriendBarView_Timer_3 = null;
            }
            if(UnknownVarFromHabboFriendBarView_Timer_1)
            {
               UnknownVarFromHabboFriendBarView_Timer_1.removeEventListener("timerComplete",onRemoveDimmer);
               UnknownVarFromHabboFriendBarView_Timer_1 = null;
            }
            if(UnknownVarFromHabboFriendBarView_MessengerIcon_1)
            {
               UnknownVarFromHabboFriendBarView_MessengerIcon_1.dispose();
               UnknownVarFromHabboFriendBarView_MessengerIcon_1 = null;
            }
            if(UnknownVarFromHabboFriendBarView_FriendListIcon_1)
            {
               UnknownVarFromHabboFriendBarView_FriendListIcon_1.dispose();
               UnknownVarFromHabboFriendBarView_FriendListIcon_1 = null;
            }
            if(UnknownVarFromHabboFriendBarView_IWindowController_1_3)
            {
               UnknownVarFromHabboFriendBarView_IWindowController_1_3.dispose();
               UnknownVarFromHabboFriendBarView_IWindowController_1_3 = null;
            }
            if(UnknownVarFromHabboFriendBarView_IWindowController_1_1)
            {
               UnknownVarFromHabboFriendBarView_IWindowController_1_1.dispose();
               UnknownVarFromHabboFriendBarView_IWindowController_1_1 = null;
            }
            if(UnknownVarFromHabboFriendBarView_IWindowController_1_2)
            {
               UnknownVarFromHabboFriendBarView_IWindowController_1_2.dispose();
               UnknownVarFromHabboFriendBarView_IWindowController_1_2 = null;
            }
            while(UnknownVarFromHabboFriendBarView_Vector_1.length > 0)
            {
               ITab(UnknownVarFromHabboFriendBarView_Vector_1.pop()).dispose();
            }
            while(UnknownVarFromHabboFriendBarView_Vector_1.length > 0)
            {
               ITab(UnknownVarFromHabboFriendBarView_Vector_1.pop()).dispose();
            }
            if(_friendBarData != null && !_friendBarData.disposed && _friendBarData.events != null)
            {
               _friendBarData.events.removeEventListener("FBE_UPDATED",onRefreshView);
               _friendBarData.events.removeEventListener("FIND_FRIENDS_RESULT",onFindFriendsNotification);
               _friendBarData.events.removeEventListener("FBE_REQUESTS",onFriendRequestUpdate);
               _friendBarData.events.removeEventListener("FBE_MESSAGE",onNewInstantMessage);
               _friendBarData.events.removeEventListener("FBE_NOTIFICATION_EVENT",onFriendNotification);
               _friendBarData.events.removeEventListener("AMC_EVENT",onRefreshMessengerConversations);
            }
            if(_sessionDataManager)
            {
               _sessionDataManager.events.removeEventListener("APUE_UPDATED",onSessionDataPreferences);
            }
            if(_windowManager != null && !_windowManager.disposed)
            {
               _windowManager.getWindowContext(1).getDesktopWindow().removeEventListener("WE_RESIZED",onDesktopResized);
            }
            UnknownVarFromHabboFriendBarView_TextCropper_1.dispose();
            UnknownVarFromHabboFriendBarView_TextCropper_1 = null;
            super.dispose();
         }
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
         _friendBarData.events.addEventListener("FBE_UPDATED",onRefreshView);
         _friendBarData.events.addEventListener("FIND_FRIENDS_RESULT",onFindFriendsNotification);
         _friendBarData.events.addEventListener("FBE_REQUESTS",onFriendRequestUpdate);
         _friendBarData.events.addEventListener("FBE_MESSAGE",onNewInstantMessage);
         _friendBarData.events.addEventListener("FBE_NOTIFICATION_EVENT",onFriendNotification);
         _friendBarData.events.addEventListener("AMC_EVENT",onRefreshMessengerConversations);
         _sessionDataManager.events.addEventListener("APUE_UPDATED",onSessionDataPreferences);
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_1)
         {
            UnknownVarFromHabboFriendBarView_IWindowController_1_1.visible = param1;
            UnknownVarFromHabboFriendBarView_IWindowController_1_1.activate();
         }
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_3)
         {
            UnknownVarFromHabboFriendBarView_IWindowController_1_3.visible = !param1;
            if(UnknownVarFromHabboFriendBarView_IWindowController_1_1)
            {
               UnknownVarFromHabboFriendBarView_IWindowController_1_3.x = UnknownVarFromHabboFriendBarView_IWindowController_1_1.x;
               UnknownVarFromHabboFriendBarView_IWindowController_1_3.y = UnknownVarFromHabboFriendBarView_IWindowController_1_1.y;
               UnknownVarFromHabboFriendBarView_IWindowController_1_3.activate();
            }
         }
      }
      
      private function addDimmerToFriendBar() : void
      {
         var _loc1_:IWindowModel = _windowManager.createWindow("bar_dimmer","",30,1,0x80 | 0x0800 | 1,new Rectangle(0,0,UnknownVarFromHabboFriendBarView_IWindowController_1_1.width,UnknownVarFromHabboFriendBarView_IWindowController_1_1.height),null,0);
         _loc1_.color = 0;
         _loc1_.blend = 0.3;
         UnknownVarFromHabboFriendBarView_IWindowController_1_1.addChild(_loc1_);
         UnknownVarFromHabboFriendBarView_IWindowController_1_1.invalidate();
         if(UnknownVarFromHabboFriendBarView_Timer_1 == null)
         {
            UnknownVarFromHabboFriendBarView_Timer_1 = new Timer(RoomEnterEffect.totalRunningTime,1);
            UnknownVarFromHabboFriendBarView_Timer_1.addEventListener("timerComplete",onRemoveDimmer);
            UnknownVarFromHabboFriendBarView_Timer_1.start();
         }
      }
      
      private function onRemoveDimmer(param1:TimerEvent) : void
      {
         UnknownVarFromHabboFriendBarView_Timer_1.removeEventListener("timerComplete",onRemoveDimmer);
         UnknownVarFromHabboFriendBarView_Timer_1 = null;
         var _loc2_:IWindowModel = UnknownVarFromHabboFriendBarView_IWindowController_1_1.findChildByName("bar_dimmer");
         if(_loc2_ != null)
         {
            UnknownVarFromHabboFriendBarView_IWindowController_1_1.removeChild(_loc2_);
            _windowManager.destroy(_loc2_);
         }
      }
      
      public function get visible() : Boolean
      {
         return UnknownVarFromHabboFriendBarView_IWindowController_1_1 && UnknownVarFromHabboFriendBarView_IWindowController_1_1.visible;
      }
      
      public function populate() : void
      {
         var _loc6_:* = 0;
         var _loc2_:IFriendRequest = null;
         var _loc15_:IFriendEntity = null;
         var _loc9_:Tab = null;
         var _loc7_:int = 0;
         var _loc11_:Tab = null;
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_1 == null)
         {
            return;
         }
         var _loc14_:int = UnknownVarFromHabboFriendBarView_Int_1;
         deSelect(false);
         var _loc10_:IItemListWindow = UnknownVarFromHabboFriendBarView_IWindowController_1_1.findChildByName("list") as IItemListWindow;
         if(_loc10_ == null)
         {
            return;
         }
         _loc10_.autoArrangeItems = false;
         var _loc4_:int;
         _loc6_ = _loc4_ = _loc10_.numListItems;
         while(_loc6_ > 0)
         {
            _loc10_.removeListItemAt(_loc6_ - 1);
            _loc6_--;
         }
         while(UnknownVarFromHabboFriendBarView_Vector_1.length > 0)
         {
            UnknownVarFromHabboFriendBarView_Vector_1.pop().recycle();
         }
         updateFriendRequestCounter(_friendBarData.numFriendRequests);
         var _loc3_:int = _friendBarData.numFriends;
         var _loc5_:int = 0;
         var _loc1_:int = maxNumOfTabsVisible;
         var _loc12_:int = _loc3_ + (UnknownVarFromHabboFriendBarView_Boolean_1 ? 1 : 0) + (_loc5_ > 0 ? 1 : 0);
         var _loc13_:int = Math.min(_loc1_,_loc12_);
         if(UnknownVarFromHabboFriendBarView_Int_2 + _loc13_ > _loc12_)
         {
            UnknownVarFromHabboFriendBarView_Int_2 = Math.max(0,UnknownVarFromHabboFriendBarView_Int_2 - (UnknownVarFromHabboFriendBarView_Int_2 + _loc13_ - _loc12_));
         }
         var _loc8_:int = UnknownVarFromHabboFriendBarView_Int_2;
         if(_loc5_ > 0)
         {
            if(UnknownVarFromHabboFriendBarView_Int_2 == 0)
            {
               if(UnknownVarFromHabboFriendBarView_Vector_1.length < _loc1_)
               {
                  if(_loc5_ == 1)
                  {
                     _loc2_ = _friendBarData.getFriendRequestAt(0);
                     _loc9_ = NewFriendRequestTab.allocate(_loc2_);
                     UnknownVarFromHabboFriendBarView_Vector_1.push(_loc9_);
                     _loc10_.addListItem(_loc9_.window);
                  }
                  else if(_loc5_ > 1)
                  {
                     _loc9_ = FriendRequestsTab.allocate(_friendBarData.getFriendRequestList());
                     UnknownVarFromHabboFriendBarView_Vector_1.push(_loc9_);
                     _loc10_.addListItem(_loc9_.window);
                  }
               }
            }
            else
            {
               _loc8_--;
            }
         }
         _loc6_ = _loc8_;
         while(_loc6_ < _loc3_ + _loc8_)
         {
            if(_loc6_ >= _loc3_)
            {
               break;
            }
            if(UnknownVarFromHabboFriendBarView_Vector_1.length >= _loc1_)
            {
               break;
            }
            _loc15_ = _friendBarData.getFriendAt(_loc6_);
            if(_loc15_.id > 0)
            {
               _loc9_ = NewFriendEntityTab.allocate(_loc15_);
               UnknownVarFromHabboFriendBarView_Vector_1.push(_loc9_);
               _loc10_.addListItem(_loc9_.window);
            }
            _loc6_++;
         }
         if(UnknownVarFromHabboFriendBarView_Boolean_1)
         {
            _loc7_ = getNumberOfFindFriendsTabs(_loc1_,_loc12_,_loc3_,_loc5_);
            _loc12_ = _loc3_ + _loc7_ + (_loc5_ > 0 ? 1 : 0);
            while(_loc7_-- > 0)
            {
               _loc11_ = AddFriendsTab.allocate();
               _loc10_.addListItem(_loc11_.window);
               UnknownVarFromHabboFriendBarView_Vector_1.push(_loc11_);
            }
         }
         _loc10_.autoArrangeItems = true;
         if(_loc14_ > -1)
         {
            selectFriendEntity(_loc14_);
         }
         setCollapseButtonVisibility();
         toggleArrowButtons(UnknownVarFromHabboFriendBarView_Vector_1.length < _loc12_ && _loc12_ > 0,UnknownVarFromHabboFriendBarView_Int_2 != 0,UnknownVarFromHabboFriendBarView_Int_2 + UnknownVarFromHabboFriendBarView_Vector_1.length < _loc12_);
         if(!_startingInit)
         {
            _startingInit = true;
            resizeAndPopulate(false);
            resizeAndPopulate(true);
         }
      }
      
      private function getNumberOfFindFriendsTabs(param1:int, param2:int, param3:int, param4:int) : int
      {
         if(UnknownVarFromHabboFriendBarView_Vector_1.length >= param1)
         {
            return 0;
         }
         if(UnknownVarFromHabboFriendBarView_Vector_1.length >= param1)
         {
            return 0;
         }
         var _loc5_:int = 1;
         if(UnknownVarFromHabboFriendBarView_Vector_1.length + _loc5_ < 3)
         {
            _loc5_ = Math.min(param1 - UnknownVarFromHabboFriendBarView_Vector_1.length,3 - UnknownVarFromHabboFriendBarView_Vector_1.length);
         }
         return _loc5_;
      }
      
      private function getFriendEntityTabByID(param1:int) : FriendEntityTab
      {
         var _loc2_:FriendEntityTab = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(UnknownVarFromHabboFriendBarView_Vector_1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = UnknownVarFromHabboFriendBarView_Vector_1[_loc4_] as FriendEntityTab;
            if(_loc2_)
            {
               if(_loc2_.friend.id == param1)
               {
                  return _loc2_;
               }
            }
            _loc4_++;
         }
         return null;
      }
      
      private function isUserInterfaceReady() : Boolean
      {
         return UnknownVarFromHabboFriendBarView_IWindowController_1_1 && !UnknownVarFromHabboFriendBarView_IWindowController_1_1.disposed;
      }
      
      private function buildUserInterface() : void
      {
         Tab.DATA = _friendBarData;
         Tab.GAMES = _gameManager;
         Tab.FRIENDS = _friendList;
         Tab.VIEW = this;
         Tab.ASSETS = assets;
         Tab.WINDOWING = _windowManager;
         Tab.UnknownVarFromTab_IHabboLocalizationManager_1 = _localizationManager;
         Tab.CROPPER = UnknownVarFromHabboFriendBarView_TextCropper_1;
         Tab.TRACKING = _tracking;
         Tab.AVATAR_RENDER_MANAGER = _avatarManager;
         Token.WINDOWING = _windowManager;
         Token.ASSETS = assets;
         Token.GAMES = _gameManager;
         var _loc4_:ISoundAsset = assets.getAssetByName("new_bar_xml");
         UnknownVarFromHabboFriendBarView_IWindowController_1_1 = _windowManager.buildFromXML(_loc4_.content as XML,1) as IWindowController_1;
         UnknownVarFromHabboFriendBarView_IWindowController_1_1.y = UnknownVarFromHabboFriendBarView_IWindowController_1_1.parent.height - (UnknownVarFromHabboFriendBarView_IWindowController_1_1.height + 1);
         UnknownVarFromHabboFriendBarView_IWindowController_1_1.setParamFlag(1024,true);
         UnknownVarFromHabboFriendBarView_IWindowController_1_1.procedure = barWindowEventProc;
         if(RoomEnterEffect.isRunning())
         {
            addDimmerToFriendBar();
         }
         var _loc2_:IWindowController_1 = UnknownVarFromHabboFriendBarView_IWindowController_1_1.findChildByName("friendtools") as IWindowController_1;
         UnknownVarFromHabboFriendBarView_IStaticBitmapWrapperWindow_1 = _loc2_.getChildByName("line") as IStaticBitmapWrapperWindow;
         UnknownVarFromHabboFriendBarView_IWindowController_1_4 = IWindowController_1(_loc2_.findChildByName("icon_messenger"));
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_4)
         {
            UnknownVarFromHabboFriendBarView_IWindowController_1_4.addEventListener("WME_CLICK",onOpenMessenger);
            UnknownVarFromHabboFriendBarView_IWindowController_1_4.visible = false;
         }
         var _loc3_:IWindowController_1 = IWindowController_1(_loc2_.findChildByName("icon_all_friends"));
         if(_loc3_)
         {
            _loc3_.addEventListener("WME_CLICK",onOpenFriendsList);
         }
         var _loc1_:IWindowController_1 = IWindowController_1(_loc2_.findChildByName("icon_find_friends"));
         if(_loc1_)
         {
            _loc1_.addEventListener("WME_CLICK",onOpenSearchFriends);
         }
         UnknownVarFromHabboFriendBarView_IRegionWindow_2 = UnknownVarFromHabboFriendBarView_IWindowController_1_1.findChildByName("collapse_left") as IRegionWindow;
         if(UnknownVarFromHabboFriendBarView_IRegionWindow_2)
         {
            UnknownVarFromHabboFriendBarView_IRegionWindow_2.addEventListener("WME_CLICK",onCollapseFriendList);
         }
         UnknownVarFromHabboFriendBarView_IRegionWindow_1 = UnknownVarFromHabboFriendBarView_IWindowController_1_1.findChildByName("collapse_right") as IRegionWindow;
         if(UnknownVarFromHabboFriendBarView_IRegionWindow_1)
         {
            UnknownVarFromHabboFriendBarView_IRegionWindow_1.addEventListener("WME_CLICK",onCollapseFriendList);
         }
         _windowManager.getWindowContext(1).getDesktopWindow().addEventListener("WE_RESIZED",onDesktopResized);
         populate();
         if(UnknownVarFromHabboFriendBarView_Timer_3 == null)
         {
            UnknownVarFromHabboFriendBarView_Timer_3 = new Timer(1000 / 60);
            UnknownVarFromHabboFriendBarView_Timer_3.addEventListener("timer",onCollapseAnimationTimer);
         }
         if(_notifyMessengerOnStartup)
         {
            notifyMessenger(true);
         }
      }
      
      public function getAvatarFaceBitmap(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc3_:IAvatarImage_2 = null;
         if(_avatarManager)
         {
            _loc3_ = _avatarManager.createAvatarImage(param1,"h",null,this);
            if(_loc3_)
            {
               _loc2_ = HabboFaceFocuser.focusUserFace(_loc3_,"head",2,1);
               _loc3_.dispose();
            }
         }
         return _loc2_;
      }
      
      public function getGroupIconBitmap(param1:String) : BitmapData
      {
         return _sessionDataManager.getGroupBadgeImage(param1);
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc11_:IFriendEntity = null;
         var _loc3_:int = 0;
         var _loc10_:BitmapData = null;
         var _loc13_:IWindowController_1 = null;
         var _loc6_:IItemListWindow = null;
         var _loc12_:IWindowController_1 = null;
         var _loc4_:IBitmapWrapperController = null;
         var _loc8_:IItemListWindow = UnknownVarFromHabboFriendBarView_IWindowController_1_1.findChildByName("list") as IItemListWindow;
         var _loc9_:int = _friendBarData.numFriends;
         _loc3_ = 0;
         while(_loc3_ < _loc9_)
         {
            _loc11_ = _friendBarData.getFriendAt(_loc3_);
            if(_loc11_.figure == param1)
            {
               _loc10_ = null;
               if(_loc11_.id > 0)
               {
                  _loc10_ = getAvatarFaceBitmap(_loc11_.figure);
               }
               else
               {
                  _loc10_ = getGroupIconBitmap(_loc11_.figure);
               }
               if(_loc10_)
               {
                  _loc13_ = _loc8_.getListItemByID(_loc11_.id) as IWindowController_1;
                  if(_loc13_)
                  {
                     _loc6_ = _loc13_.getChildByName("pieces") as IItemListWindow;
                     if(_loc6_)
                     {
                        _loc12_ = IWindowController_1(_loc6_.getListItemByName("header"));
                        if(_loc12_)
                        {
                           _loc4_ = _loc12_.findChildByName("canvas") as IBitmapWrapperController;
                           _loc4_.bitmap = _loc10_;
                           _loc4_.width = _loc10_.width;
                           _loc4_.height = _loc10_.height;
                        }
                     }
                  }
               }
               return;
            }
            _loc3_++;
         }
         var _loc5_:Array = _friendBarData.getFriendRequestList();
         for each(var _loc2_ in _loc5_)
         {
            if(_loc2_.figure == param1)
            {
               for each(var _loc7_ in UnknownVarFromHabboFriendBarView_Vector_1)
               {
                  if(_loc7_ is FriendRequestTab)
                  {
                     FriendRequestTab(_loc7_).avatarImageReady(_loc2_,getAvatarFaceBitmap(param1));
                     return;
                  }
                  if(_loc7_ is NewFriendRequestTab)
                  {
                     NewFriendRequestTab(_loc7_).avatarImageReady(_loc2_,getAvatarFaceBitmap(param1));
                     return;
                  }
                  if(_loc7_ is FriendRequestsTab)
                  {
                     FriendRequestsTab(_loc7_).avatarImageReady(_loc2_,getAvatarFaceBitmap(param1));
                     return;
                  }
               }
            }
         }
      }
      
      private function isFriendSelected(param1:IFriendEntity) : Boolean
      {
         return UnknownVarFromHabboFriendBarView_Int_1 == param1.id;
      }
      
      public function selectTab(param1:ITab, param2:Boolean) : void
      {
         if(!param1.selected)
         {
            if(UnknownVarFromHabboFriendBarView_ITab_1)
            {
               deSelect(true);
            }
            param1.select(param2);
            UnknownVarFromHabboFriendBarView_ITab_1 = param1;
            if(param1 is FriendEntityTab)
            {
               UnknownVarFromHabboFriendBarView_Int_1 = FriendEntityTab(param1).friend.id;
            }
            if(param1 is NewFriendEntityTab)
            {
               UnknownVarFromHabboFriendBarView_Int_1 = NewFriendEntityTab(param1).friend.id;
            }
         }
      }
      
      public function selectFriendEntity(param1:int) : void
      {
         if(UnknownVarFromHabboFriendBarView_Int_1 == param1)
         {
            return;
         }
         var _loc2_:FriendEntityTab = getFriendEntityTabByID(param1);
         if(_loc2_)
         {
            selectTab(_loc2_,false);
            UnknownVarFromHabboFriendBarView_Int_1 = param1;
         }
      }
      
      public function deSelect(param1:Boolean) : void
      {
         if(UnknownVarFromHabboFriendBarView_ITab_1)
         {
            UnknownVarFromHabboFriendBarView_ITab_1.deselect(param1);
            UnknownVarFromHabboFriendBarView_ITab_1 = null;
            UnknownVarFromHabboFriendBarView_Int_1 = -1;
         }
      }
      
      public function getIconLocation(param1:String) : IWindowController_1
      {
         var _loc2_:* = null;
         return IWindowController_1(UnknownVarFromHabboFriendBarView_IWindowController_1_1.findChildByName(param1));
      }
      
      private function onRefreshView(param1:Event) : void
      {
         if(!isUserInterfaceReady())
         {
            buildUserInterface();
         }
         else
         {
            resizeAndPopulate(true);
         }
      }
      
      private function onFindFriendsNotification(param1:FindFriendsNotificationEvent) : void
      {
         var event:FindFriendsNotificationEvent = param1;
         var title:String = event.success ? "${friendbar.find.success.title}" : "${friendbar.find.error.title}";
         var text:String = event.success ? "${friendbar.find.success.text}" : "${friendbar.find.error.text}";
         _windowManager.notify(title,text,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
         {
            param1.dispose();
         },16);
      }
      
      private function onFriendRequestUpdate(param1:FriendRequestUpdateEvent) : void
      {
         if(UnknownVarFromHabboFriendBarView_FriendListIcon_1)
         {
            UnknownVarFromHabboFriendBarView_FriendListIcon_1.notify(_friendBarData.numFriendRequests > 0);
         }
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_1)
         {
            updateFriendRequestCounter(_friendBarData.numFriendRequests);
            resizeAndPopulate(true);
         }
         else
         {
            buildUserInterface();
         }
      }
      
      protected function onTimerEvent(param1:TimerEvent) : void
      {
         UnknownVarFromHabboFriendBarView_IWindowController_1_4.visible = true;
         var _loc2_:IWindowModel = UnknownVarFromHabboFriendBarView_IWindowController_1_4.getChildByName("icon_1") as IWindowModel;
         var _loc3_:IWindowModel = UnknownVarFromHabboFriendBarView_IWindowController_1_4.getChildByName("icon_2") as IWindowModel;
         if(_loc2_ && _loc3_)
         {
            if(_loc2_.visible)
            {
               _loc2_.visible = false;
               _loc3_.visible = true;
            }
            else if(_loc3_.visible)
            {
               _loc3_.visible = false;
               _loc2_.visible = true;
            }
         }
      }
      
      private function notifyMessenger(param1:Boolean) : void
      {
         var _loc2_:IWindowModel = UnknownVarFromHabboFriendBarView_IWindowController_1_4.getChildByName("icon") as IWindowModel;
         var _loc3_:IWindowModel = UnknownVarFromHabboFriendBarView_IWindowController_1_4.getChildByName("icon_1") as IWindowModel;
         if(param1)
         {
            if(!UnknownVarFromHabboFriendBarView_Timer_2)
            {
               _loc2_.visible = false;
               _loc3_.visible = true;
               UnknownVarFromHabboFriendBarView_Timer_2 = new Timer(500,0);
               UnknownVarFromHabboFriendBarView_Timer_2.addEventListener("timer",onTimerEvent);
               UnknownVarFromHabboFriendBarView_Timer_2.start();
            }
         }
         else
         {
            if(UnknownVarFromHabboFriendBarView_Timer_2 != null)
            {
               UnknownVarFromHabboFriendBarView_Timer_2.removeEventListener("timer",onTimerEvent);
               UnknownVarFromHabboFriendBarView_Timer_2.stop();
               UnknownVarFromHabboFriendBarView_Timer_2 = null;
            }
            _loc2_.visible = true;
            _loc3_.visible = false;
            (UnknownVarFromHabboFriendBarView_IWindowController_1_4.getChildByName("icon_2") as IWindowModel).visible = false;
         }
      }
      
      private function onNewInstantMessage(param1:NewMessageEvent) : void
      {
         if(param1.notify)
         {
            _notifyMessengerOnStartup = true;
         }
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_4)
         {
            if(param1.notify)
            {
               notifyMessenger(true);
            }
            else
            {
               UnknownVarFromHabboFriendBarView_IWindowController_1_4.visible = true;
               notifyMessenger(false);
            }
         }
         if(UnknownVarFromHabboFriendBarView_NewOpenMessengerTab_1)
         {
            if(param1.notify)
            {
               UnknownVarFromHabboFriendBarView_NewOpenMessengerTab_1.window.visible = true;
            }
         }
      }
      
      private function onFriendNotification(param1:NotificationEvent) : void
      {
         var _loc2_:FriendEntityTab = getFriendEntityTabByID(param1.friendId);
         if(!_loc2_)
         {
            return;
         }
         _loc2_.addNotificationToken(param1.notification);
      }
      
      private function onRefreshMessengerConversations(param1:ActiveConversationsCountEvent) : void
      {
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_4 != null)
         {
            UnknownVarFromHabboFriendBarView_IWindowController_1_4.visible = param1.activeConversationsCount != 0;
            notifyMessenger(param1.hasUnread);
         }
      }
      
      private function onSessionDataPreferences(param1:SessionDataPreferencesEvent) : void
      {
         setCollapsedState(!(param1.uiFlags & 1),false,false);
      }
      
      private function barWindowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param1.type == "WME_DOWN")
         {
            _loc4_ = UnknownVarFromHabboFriendBarView_Int_2;
            _loc3_ = _friendBarData.numFriends + (UnknownVarFromHabboFriendBarView_Boolean_1 ? 1 : 0) + (_friendBarData.numFriendRequests > 0 ? 1 : 0);
            switch(param2.name)
            {
               case "button_left":
                  _loc4_ = Math.max(0,UnknownVarFromHabboFriendBarView_Int_2 - 1);
                  break;
               case "button_left_page":
                  _loc4_ = Math.max(0,UnknownVarFromHabboFriendBarView_Int_2 - maxNumOfTabsVisible);
                  break;
               case "button_left_end":
                  _loc4_ = 0;
                  break;
               case "button_right":
                  _loc4_ = Math.max(0,Math.min(_loc3_ - maxNumOfTabsVisible,UnknownVarFromHabboFriendBarView_Int_2 + 1));
                  break;
               case "button_right_page":
                  _loc4_ = Math.max(0,Math.min(_loc3_ - maxNumOfTabsVisible,UnknownVarFromHabboFriendBarView_Int_2 + maxNumOfTabsVisible));
                  break;
               case "button_right_end":
                  _loc4_ = Math.max(0,_loc3_ - maxNumOfTabsVisible);
                  break;
               case "button_close":
                  visible = false;
                  break;
               case "border":
                  deSelect(true);
                  break;
               case "link_friendlist":
                  _friendBarData.toggleFriendList();
            }
            if(_loc4_ != UnknownVarFromHabboFriendBarView_Int_2)
            {
               deSelect(true);
               UnknownVarFromHabboFriendBarView_Int_2 = _loc4_;
               resizeAndPopulate(true);
            }
         }
         if(param1.type == "WE_DEACTIVATED")
         {
            deSelect(true);
         }
      }
      
      private function setCollapseButtonVisibility() : void
      {
         if(UnknownVarFromHabboFriendBarView_IRegionWindow_2)
         {
            UnknownVarFromHabboFriendBarView_IRegionWindow_2.visible = UnknownVarFromHabboFriendBarView_Boolean_2;
         }
         if(UnknownVarFromHabboFriendBarView_IRegionWindow_1)
         {
            UnknownVarFromHabboFriendBarView_IRegionWindow_1.visible = !UnknownVarFromHabboFriendBarView_Boolean_2;
         }
      }
      
      private function getReservedFriendBarWidth() : int
      {
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_1 == null)
         {
            return 0;
         }
         return UnknownVarFromHabboFriendBarView_Boolean_2 ? 150 : int(UnknownVarFromHabboFriendBarView_IWindowController_1_1.width);
      }
      
      private function dispatchFriendBarResize() : void
      {
         var _loc1_:FriendBarResizeEvent = new FriendBarResizeEvent();
         events.dispatchEvent(_loc1_);
      }
      
      private function applyCollapseAnimationFrame(param1:int, param2:int, param3:int) : void
      {
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_1 == null)
         {
            return;
         }
         UnknownVarFromHabboFriendBarView_IWindowController_1_1.x = param1;
         UnknownVarFromHabboFriendBarView_IWindowController_1_1.width = param2;
         _currentFriendBarWidth = param3;
         UnknownVarFromHabboFriendBarView_IWindowController_1_1.invalidate();
         dispatchFriendBarResize();
      }
      
      private function startCollapseAnimation(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         if(UnknownVarFromHabboFriendBarView_Timer_3 == null)
         {
            applyCollapseAnimationFrame(param2,param4,param6);
            return;
         }
         UnknownVarFromHabboFriendBarView_Timer_3.reset();
         UnknownVarFromHabboFriendBarView_Int_3 = 0;
         UnknownVarFromHabboFriendBarView_Number_1 = param1;
         UnknownVarFromHabboFriendBarView_Int_4 = param2;
         _collapseAnimationStartWidth = param3;
         _collapseAnimationTargetWidth = param4;
         _collapseAnimationStartReservedWidth = param5;
         _collapseAnimationTargetReservedWidth = param6;
         applyCollapseAnimationFrame(param1,param3,param5);
         UnknownVarFromHabboFriendBarView_Timer_3.start();
      }
      
      private function onCollapseAnimationTimer(param1:TimerEvent) : void
      {
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_1 == null || UnknownVarFromHabboFriendBarView_Timer_3 == null)
         {
            return;
         }
         UnknownVarFromHabboFriendBarView_Int_3 += int(UnknownVarFromHabboFriendBarView_Timer_3.delay);
         var _loc3_:Number = Math.min(1,UnknownVarFromHabboFriendBarView_Int_3 / 140);
         var _loc2_:Number = 1 - Math.pow(1 - _loc3_,3);
         var _loc5_:int = Math.round(UnknownVarFromHabboFriendBarView_Number_1 + (UnknownVarFromHabboFriendBarView_Int_4 - UnknownVarFromHabboFriendBarView_Number_1) * _loc2_);
         var _loc4_:int = Math.round(_collapseAnimationStartWidth + (_collapseAnimationTargetWidth - _collapseAnimationStartWidth) * _loc2_);
         var _loc6_:int = Math.round(_collapseAnimationStartReservedWidth + (_collapseAnimationTargetReservedWidth - _collapseAnimationStartReservedWidth) * _loc2_);
         applyCollapseAnimationFrame(_loc5_,_loc4_,_loc6_);
         if(_loc3_ >= 1)
         {
            UnknownVarFromHabboFriendBarView_Timer_3.stop();
            applyCollapseAnimationFrame(UnknownVarFromHabboFriendBarView_Int_4,_collapseAnimationTargetWidth,_collapseAnimationTargetReservedWidth);
         }
      }
      
      private function onCollapseFriendList(param1:WindowMouseEvent) : void
      {
         toggleCollapsedState();
      }
      
      private function toggleCollapsedState() : void
      {
         setCollapsedState(!UnknownVarFromHabboFriendBarView_Boolean_2,true,true);
      }
      
      private function setCollapsedState(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         if(UnknownVarFromHabboFriendBarView_Boolean_2 == param1)
         {
            return;
         }
         var _loc8_:int = int(UnknownVarFromHabboFriendBarView_IWindowController_1_1 != null ? UnknownVarFromHabboFriendBarView_IWindowController_1_1.x : 0);
         var _loc5_:int = int(UnknownVarFromHabboFriendBarView_IWindowController_1_1 != null ? UnknownVarFromHabboFriendBarView_IWindowController_1_1.width : 0);
         var _loc6_:int = _currentFriendBarWidth;
         UnknownVarFromHabboFriendBarView_Boolean_2 = param1;
         if(param2)
         {
            _sessionDataManager.setFriendBarState(!UnknownVarFromHabboFriendBarView_Boolean_2);
         }
         if(UnknownVarFromHabboFriendBarView_Timer_3 != null)
         {
            UnknownVarFromHabboFriendBarView_Timer_3.stop();
         }
         deSelect(true);
         resizeAndPopulate(true);
         setCollapseButtonVisibility();
         if(!UnknownVarFromHabboFriendBarView_Boolean_2)
         {
            resizeAndPopulate(true);
         }
         var _loc7_:int = int(UnknownVarFromHabboFriendBarView_IWindowController_1_1 != null ? UnknownVarFromHabboFriendBarView_IWindowController_1_1.x : 0);
         var _loc9_:int = int(UnknownVarFromHabboFriendBarView_IWindowController_1_1 != null ? UnknownVarFromHabboFriendBarView_IWindowController_1_1.width : 0);
         var _loc4_:int = getReservedFriendBarWidth();
         if(param3)
         {
            startCollapseAnimation(_loc8_,_loc7_,_loc5_,_loc9_,_loc6_,_loc4_);
         }
         else
         {
            applyCollapseAnimationFrame(_loc7_,_loc9_,_loc4_);
         }
      }
      
      private function onOpenMessenger(param1:WindowMouseEvent) : void
      {
         _friendBarData.toggleMessenger();
         notifyMessenger(false);
      }
      
      private function onOpenFriendsList(param1:WindowMouseEvent) : void
      {
         _friendBarData.toggleFriendList();
      }
      
      private function onOpenSearchFriends(param1:WindowMouseEvent) : void
      {
         _friendBarData.openUserTextSearch();
      }
      
      public function removeMessengerNotifications() : void
      {
         for each(var _loc1_ in UnknownVarFromHabboFriendBarView_Vector_1)
         {
            if(_loc1_ is FriendEntityTab)
            {
               FriendEntityTab(_loc1_).removeNotificationToken(-1,true);
            }
         }
      }
      
      public function updateFriendRequestCounter(param1:int) : void
      {
         var _loc2_:IRegionWindow = null;
         if(!UnknownVarFromHabboFriendBarView_IWindowController_1_2)
         {
            UnknownVarFromHabboFriendBarView_IWindowController_1_2 = _windowManager.createUnseenItemCounter();
         }
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_2)
         {
            _loc2_ = UnknownVarFromHabboFriendBarView_IWindowController_1_1.findChildByName("icon_all_friends") as IRegionWindow;
            if(_loc2_)
            {
               _loc2_.addChild(UnknownVarFromHabboFriendBarView_IWindowController_1_2);
               UnknownVarFromHabboFriendBarView_IWindowController_1_2.x = _loc2_.width - UnknownVarFromHabboFriendBarView_IWindowController_1_2.width - 5;
               UnknownVarFromHabboFriendBarView_IWindowController_1_2.y = 0;
               if(param1 > 0)
               {
                  UnknownVarFromHabboFriendBarView_IWindowController_1_2.visible = true;
                  UnknownVarFromHabboFriendBarView_IWindowController_1_2.findChildByName("count").caption = param1.toString();
               }
               else
               {
                  UnknownVarFromHabboFriendBarView_IWindowController_1_2.visible = false;
               }
            }
         }
      }
      
      private function toggleWindowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(UnknownVarFromHabboFriendBarView_IWindowController_1_3.visible)
         {
            if(param1.type == "WME_DOWN")
            {
               var _loc3_:* = param2.name;
               if("button_open" === _loc3_)
               {
                  visible = true;
               }
            }
         }
      }
      
      private function toggleArrowButtons(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:IRegionWindow = UnknownVarFromHabboFriendBarView_IWindowController_1_1.findChildByName("button_left_page") as IRegionWindow;
         var _loc5_:IRegionWindow = UnknownVarFromHabboFriendBarView_IWindowController_1_1.findChildByName("button_right_page") as IRegionWindow;
         if(_loc4_ != null)
         {
            _loc4_.visible = param1;
            if(param2)
            {
               _loc4_.enable();
               _loc4_.blend = 1;
            }
            else
            {
               _loc4_.disable();
               _loc4_.blend = 0.2;
            }
         }
         if(_loc5_ != null)
         {
            _loc5_.visible = param1;
            if(param3)
            {
               _loc5_.enable();
               _loc5_.blend = 1;
            }
            else
            {
               _loc5_.disable();
               _loc5_.blend = 0.2;
            }
         }
         arrangeWindows();
      }
      
      private function resizeAndPopulate(param1:Boolean = false) : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:int = 0;
         if(!disposed)
         {
            if(UnknownVarFromHabboFriendBarView_IWindowController_1_1)
            {
               _loc2_ = _toolbar.getRect();
               UnknownVarFromHabboFriendBarView_IWindowController_1_1.width = UnknownVarFromHabboFriendBarView_IWindowController_1_1.parent.width - _loc2_.right;
               UnknownVarFromHabboFriendBarView_IStaticBitmapWrapperWindow_1.visible = !UnknownVarFromHabboFriendBarView_Boolean_2;
               if(!param1)
               {
                  _loc3_ = maxNumOfTabsVisible;
                  if(_loc3_ < UnknownVarFromHabboFriendBarView_Vector_1.length)
                  {
                     param1 = true;
                  }
                  else if(_loc3_ > UnknownVarFromHabboFriendBarView_Vector_1.length)
                  {
                     if(UnknownVarFromHabboFriendBarView_Vector_1.length < 3)
                     {
                        param1 = true;
                     }
                     else if(UnknownVarFromHabboFriendBarView_Vector_1.length < _friendBarData.numFriends + (UnknownVarFromHabboFriendBarView_Boolean_1 ? 1 : 0))
                     {
                        param1 = true;
                     }
                     else if(numFriendEntityTabsVisible < _friendBarData.numFriends)
                     {
                        param1 = true;
                     }
                  }
               }
               if(param1)
               {
                  populate();
                  arrangeWindows();
               }
               if(UnknownVarFromHabboFriendBarView_Boolean_2)
               {
                  UnknownVarFromHabboFriendBarView_IWindowController_1_1.x = UnknownVarFromHabboFriendBarView_IWindowController_1_1.desktop.width - 150;
               }
               else
               {
                  UnknownVarFromHabboFriendBarView_IWindowController_1_1.x = UnknownVarFromHabboFriendBarView_IWindowController_1_1.desktop.width - UnknownVarFromHabboFriendBarView_IWindowController_1_1.width;
                  UnknownVarFromHabboFriendBarView_IStaticBitmapWrapperWindow_1.x = 1;
               }
               _currentFriendBarWidth = getReservedFriendBarWidth();
            }
         }
      }
      
      private function arrangeWindows() : void
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in UnknownVarFromHabboFriendBarView_IWindowController_1_1.iterator)
         {
            if(_loc2_.visible)
            {
               _loc2_.x = _loc1_;
               _loc1_ += _loc2_.width;
            }
         }
         UnknownVarFromHabboFriendBarView_IWindowController_1_1.width = _loc1_;
      }
      
      private function get numFriendEntityTabsVisible() : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = int(UnknownVarFromHabboFriendBarView_Vector_1.length);
         while(_loc3_-- > 0)
         {
            if(UnknownVarFromHabboFriendBarView_Vector_1[_loc3_] is FriendEntityTab)
            {
               _loc2_++;
            }
         }
         var _loc1_:int = int(UnknownVarFromHabboFriendBarView_Vector_1.length);
         while(_loc1_-- > 0)
         {
            if(UnknownVarFromHabboFriendBarView_Vector_1[_loc1_] is FriendEntityTab)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      private function get maxNumOfTabsVisible() : int
      {
         return 2;
      }
      
      private function onDesktopResized(param1:WindowEvent) : void
      {
         resizeAndPopulate(true);
      }
      
      public function get linkPattern() : String
      {
         return "friendbar/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "findfriends":
               _friendBarData.findNewFriends();
               break;
            case "user":
               if(_loc2_.length > 2)
               {
                  _friendBarData.showProfileByName(_loc2_[2]);
               }
               break;
            default:
               Logger.log("HabboFriendBarView unknown link-type received: " + _loc2_[1]);
         }
      }
   }
}


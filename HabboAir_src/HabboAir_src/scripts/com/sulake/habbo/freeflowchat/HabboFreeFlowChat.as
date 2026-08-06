package com.sulake.habbo.freeflowchat
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
   import com.sulake.habbo.communication.messages.incoming.perk.PerkAllowancesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.preferences.AccountPreferencesEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.RoomChatSettingsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomChatSettings;
   import com.sulake.habbo.communication.messages.outgoing.preferences.SetChatPreferencesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.preferences.SetChatStylePreferenceComposer;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.freeflowchat.data.ChatEventHandler;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.data.RoomSessionEventHandler;
   import com.sulake.habbo.freeflowchat.history.ChatHistoryBuffer;
   import com.sulake.habbo.freeflowchat.history.visualization.ChatHistoryScrollView;
   import com.sulake.habbo.freeflowchat.history.visualization.ChatHistoryTray;
   import com.sulake.habbo.freeflowchat.style.UnknownIHabboFreeflowchatStyle2;
   import com.sulake.habbo.freeflowchat.viewer.ChatBubbleFactory;
   import com.sulake.habbo.freeflowchat.viewer.ChatFlowViewer;
   import com.sulake.habbo.freeflowchat.viewer.enum.ChatMarkup;
   import com.sulake.habbo.freeflowchat.viewer.simulation.ChatFlowStage;
   import com.sulake.habbo.freeflowchat.viewer.visualization.ManualNineSliceSprite;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;
   import com.sulake.habbo.game.IHabboGameManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.moderation.IHabboModeration;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomUI;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboGameManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboModeration;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboRoomUI;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class HabboFreeFlowChat extends Component implements IHabboFreeFlowChat
   {
      private static const CHAT_FONT_SIZE_MODE_MIN:int = 0;
      
      private static const CHAT_FONT_SIZE_MODE_MAX:int = 4;
      
      private static const ZERO_POINT:Point = new Point(0,0);
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _navigator:IHabboNavigator_1;
      
      private var _moderation:IHabboModeration;
      
      private var _roomUI:IRoomUI;
      
      private var _gameManager:IHabboGameManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _toolbar:IHabboToolbar;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var UnknownVarFromHabboFreeFlowChat_ChatEventHandler_1:ChatEventHandler;
      
      private var UnknownVarFromHabboFreeFlowChat_RoomSessionEventHandler_1:RoomSessionEventHandler;
      
      private var UnknownVarFromHabboFreeFlowChat_ChatHistoryBuffer_1:ChatHistoryBuffer;
      
      private var UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1:ChatFlowStage;
      
      private var _chatHistoryScrollView:ChatHistoryScrollView;
      
      private var _chatHistoryPulldown:ChatHistoryTray;
      
      private var _chatFlowViewer:ChatFlowViewer;
      
      private var UnknownVarFromHabboFreeFlowChat_ChatViewController_1:ChatViewController;
      
      private var _chatBubbleFactory:ChatBubbleFactory;
      
      private var UnknownVarFromHabboFreeFlowChat_Boolean_1:Boolean = false;
      
      private var _isInRoom:Boolean = false;
      
      private var _roomChatSettings:RoomChatSettings;
      
      private var _preferedChatStyle:int = 1;
      
      private var _chatFontSizeMode:int = 0;
      
      private var _chatMode:int = 0;
      
      private var _chatBubbleWidth:int = 1;
      
      private var _chatScrollSpeed:int = 1;
      
      private var UnknownVarFromHabboFreeFlowChat_Int_1:int = 1;
      
      private var UnknownVarFromHabboFreeFlowChat_Boolean_2:Boolean = false;
      
      public function HabboFreeFlowChat(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         refreshEffectiveChatSettings();
      }
      
      public static function getTimeStampNow() : String
      {
         var _loc1_:Date = new Date();
         var _loc2_:Number = Number(_loc1_.getHours());
         var _loc4_:Number = Number(_loc1_.getMinutes());
         var _loc3_:Number = Number(_loc1_.getSeconds());
         var _loc5_:String = _loc2_ < 10 ? "0" + _loc2_ : _loc2_.toString();
         _loc5_ = _loc5_ + ":" + (_loc4_ < 10 ? "0" + _loc4_ : _loc4_.toString());
         return _loc5_ + ":" + (_loc3_ < 10 ? "0" + _loc3_ : _loc3_.toString());
      }
      
      public static function create9SliceSprite(param1:Rectangle, param2:BitmapData) : Sprite
      {
         var _loc8_:int = 0;
         var _loc5_:Number = NaN;
         var _loc9_:int = 0;
         var _loc7_:Sprite = new Sprite();
         var _loc3_:Array = [param1.left,param1.right,param2.width];
         var _loc4_:Array = [param1.top,param1.bottom,param2.height];
         _loc7_.graphics.clear();
         var _loc6_:Number = 0;
         _loc8_ = 0;
         while(_loc8_ < 3)
         {
            _loc5_ = 0;
            _loc9_ = 0;
            while(_loc9_ < 3)
            {
               _loc7_.graphics.beginBitmapFill(param2);
               _loc7_.graphics.drawRect(_loc6_,_loc5_,_loc3_[_loc8_] - _loc6_,_loc4_[_loc9_] - _loc5_);
               _loc7_.graphics.endFill();
               _loc5_ = Number(_loc4_[_loc9_]);
               _loc9_++;
            }
            _loc6_ = Number(_loc3_[_loc8_]);
            _loc8_++;
         }
         _loc7_.scale9Grid = param1;
         return _loc7_;
      }
      
      public static function createPixelPerfect9SliceSprite(param1:Rectangle, param2:BitmapData) : Sprite
      {
         return new ManualNineSliceSprite(param1,param2);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },false),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         },false),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator_1):void
         {
            _navigator = param1;
         },false),new ComponentDependency(new IIDHabboModeration(),function(param1:IHabboModeration):void
         {
            _moderation = param1;
         },false),new ComponentDependency(new IIDHabboRoomUI(),function(param1:IRoomUI):void
         {
            _roomUI = param1;
         },false),new ComponentDependency(new IIDHabboGameManager(),function(param1:IHabboGameManager):void
         {
            _gameManager = param1;
         },false),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         },false),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         _communication.addHabboConnectionMessageEvent(new RoomChatSettingsMessageEvent(onRoomChatSettings));
         _communication.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(onGuestRoomData));
         _communication.addHabboConnectionMessageEvent(new AccountPreferencesEvent(onAccountPreferences));
         _communication.addHabboConnectionMessageEvent(new PerkAllowancesMessageEvent(onPerkAllowances));
         _communication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
      }
      
      private function onPerkAllowances(param1:PerkAllowancesMessageEvent) : void
      {
         var _loc2_:Boolean = UnknownVarFromHabboFreeFlowChat_Boolean_1;
         UnknownVarFromHabboFreeFlowChat_Boolean_1 = true;
         if(!_loc2_ && UnknownVarFromHabboFreeFlowChat_Boolean_1)
         {
            _chatBubbleFactory = new ChatBubbleFactory(this);
            UnknownVarFromHabboFreeFlowChat_ChatEventHandler_1 = new ChatEventHandler(this);
            UnknownVarFromHabboFreeFlowChat_RoomSessionEventHandler_1 = new RoomSessionEventHandler(this);
            UnknownVarFromHabboFreeFlowChat_ChatHistoryBuffer_1 = new ChatHistoryBuffer(this);
            if(_isInRoom)
            {
               roomEntered();
            }
         }
         else if(_loc2_ && !UnknownVarFromHabboFreeFlowChat_Boolean_1)
         {
            if(_chatBubbleFactory)
            {
               _chatBubbleFactory.dispose();
               _chatBubbleFactory = null;
            }
            if(UnknownVarFromHabboFreeFlowChat_ChatEventHandler_1)
            {
               UnknownVarFromHabboFreeFlowChat_ChatEventHandler_1.dispose();
               UnknownVarFromHabboFreeFlowChat_ChatEventHandler_1 = null;
            }
            if(UnknownVarFromHabboFreeFlowChat_RoomSessionEventHandler_1)
            {
               UnknownVarFromHabboFreeFlowChat_RoomSessionEventHandler_1.dispose();
               UnknownVarFromHabboFreeFlowChat_RoomSessionEventHandler_1 = null;
            }
            if(UnknownVarFromHabboFreeFlowChat_ChatHistoryBuffer_1)
            {
               UnknownVarFromHabboFreeFlowChat_ChatHistoryBuffer_1.dispose();
               UnknownVarFromHabboFreeFlowChat_ChatHistoryBuffer_1 = null;
            }
            roomLeft();
         }
      }
      
      private function onGuestRoomData(param1:GetGuestRoomResultEvent) : void
      {
         if(UnknownVarFromHabboFreeFlowChat_ChatHistoryBuffer_1 && !UnknownVarFromHabboFreeFlowChat_Boolean_2)
         {
            UnknownVarFromHabboFreeFlowChat_ChatHistoryBuffer_1.insertRoomChange(param1.getParser().data);
         }
         UnknownVarFromHabboFreeFlowChat_Boolean_2 = true;
         if(param1.getParser().chatSettings != null)
         {
            UnknownVarFromHabboFreeFlowChat_Int_1 = param1.getParser().chatSettings.floodSensitivity;
            refreshEffectiveChatSettings();
         }
         if(UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1)
         {
            UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1.refreshSettings();
         }
      }
      
      private function onRoomEnter(param1:RoomEntryInfoMessageEvent) : void
      {
         UnknownVarFromHabboFreeFlowChat_Boolean_2 = false;
         clear();
      }
      
      private function onRoomChatSettings(param1:RoomChatSettingsMessageEvent) : void
      {
         UnknownVarFromHabboFreeFlowChat_Int_1 = param1.getParser().chatSettings != null ? param1.getParser().chatSettings.floodSensitivity : 1;
         refreshEffectiveChatSettings();
         if(_isInRoom && UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1)
         {
            UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1.refreshSettings();
         }
      }
      
      private function onAccountPreferences(param1:AccountPreferencesEvent) : void
      {
         _preferedChatStyle = param1.getParser().preferedChatStyle;
         _chatFontSizeMode = clampChatFontSizeMode(param1.getParser().chatSizePreference);
         _chatMode = sanitizeChatMode(param1.getParser().chatMode);
         _chatBubbleWidth = sanitizeChatBubbleWidth(param1.getParser().chatBubbleWidth);
         _chatScrollSpeed = sanitizeChatScrollSpeed(param1.getParser().chatScrollSpeed);
         refreshEffectiveChatSettings();
         if(_isInRoom && UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1)
         {
            UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1.refreshSettings();
         }
      }
      
      public function getRoomChangeBitmap() : BitmapData
      {
         return BitmapData(assets.getAssetByName("room_change").content);
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get gameManager() : IHabboGameManager
      {
         return _gameManager;
      }
      
      public function get localizations() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function roomEntered() : void
      {
         _isInRoom = true;
         if(UnknownVarFromHabboFreeFlowChat_Boolean_1 && _chatBubbleFactory && UnknownVarFromHabboFreeFlowChat_ChatEventHandler_1 && UnknownVarFromHabboFreeFlowChat_RoomSessionEventHandler_1)
         {
            UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1 = new ChatFlowStage(this);
            _chatFlowViewer = new ChatFlowViewer(this,UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1);
            _chatHistoryScrollView = new ChatHistoryScrollView(this,UnknownVarFromHabboFreeFlowChat_ChatHistoryBuffer_1);
            _chatHistoryPulldown = new ChatHistoryTray(this,_chatHistoryScrollView);
            UnknownVarFromHabboFreeFlowChat_ChatViewController_1 = new ChatViewController(this,_chatFlowViewer,_chatHistoryPulldown);
         }
      }
      
      public function roomLeft() : void
      {
         if(_chatHistoryPulldown)
         {
            _chatHistoryPulldown.dispose();
            _chatHistoryPulldown = null;
         }
         if(_chatHistoryScrollView)
         {
            _chatHistoryScrollView.dispose();
            _chatHistoryPulldown = null;
         }
         if(_chatFlowViewer)
         {
            _chatFlowViewer.dispose();
            _chatFlowViewer = null;
         }
         if(UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1)
         {
            UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1.dispose();
            UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1 = null;
         }
         if(UnknownVarFromHabboFreeFlowChat_ChatViewController_1)
         {
            UnknownVarFromHabboFreeFlowChat_ChatViewController_1.dispose();
            UnknownVarFromHabboFreeFlowChat_ChatViewController_1 = null;
         }
         _isInRoom = false;
      }
      
      private function fixHtml(param1:ChatItem, param2:ChatStyle) : void
      {
         if(!param2.allowHTML)
         {
            param1.text = param1.text.replace(/</g,"&lt;").replace(/>/g,"&gt;");
            param1.text = param1.text.replace(/&#[0-9]+;/g,"");
            param1.text = param1.text.replace(/&#x[0-9]+;/g,"");
         }
         var _loc3_:uint = uint(param2.textFormat && param2.textFormat.color != null ? uint(param2.textFormat.color) : 0);
         if(param2.isNotification)
         {
            param1.text = ChatMarkup.applyToElements(param1.text,_loc3_);
         }
         param1.text = ChatMarkup.applyColourToChat(param1.text,_loc3_);
      }
      
      public function insertChat(param1:ChatItem) : void
      {
         var _loc2_:PooledChatBubble = null;
         var _loc4_:Point = null;
         if(!UnknownVarFromHabboFreeFlowChat_Boolean_1 || !UnknownVarFromHabboFreeFlowChat_ChatHistoryBuffer_1 || !UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1)
         {
            return;
         }
         var _loc3_:ChatStyle = ChatStyle(chatStyleLibrary.getStyle(param1.style));
         fixHtml(param1,_loc3_);
         UnknownVarFromHabboFreeFlowChat_ChatHistoryBuffer_1.insertChat(param1);
         if(this.windowManager.LilithCustomsInstance.IsChatEnabled == false)
         {
            return;
         }
         try
         {
            _loc2_ = _chatBubbleFactory.getNewChatBubble(param1);
         }
         catch(e:Error)
         {
            if(e.errorID == 2015)
            {
               return;
            }
            throw e;
         }
         _loc4_ = UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1.insertBubble(_loc2_);
         _chatFlowViewer.insertBubble(_loc2_,_loc4_);
      }
      
      public function getScreenPointFromRoomLocation(param1:int, param2:IVector3d) : Point
      {
         var _loc9_:Point = null;
         var _loc5_:Point = null;
         if(_roomEngine == null || _chatFlowViewer == null || _chatFlowViewer.rootDisplayObject.stage == null)
         {
            return ZERO_POINT;
         }
         var _loc3_:int = HabboComponentFlags.isRoomViewerMode(flags) ? 1 : -1;
         var _loc8_:IRoomGeometry = roomEngine.getRoomCanvasGeometry(param1,_loc3_);
         var _loc7_:Number = roomEngine.getRoomCanvasScale(param1);
         var _loc6_:Number = _chatFlowViewer.rootDisplayObject.stage.stageWidth * _loc7_ / 2;
         var _loc4_:Number = _chatFlowViewer.rootDisplayObject.stage.stageHeight * _loc7_ / 2;
         if(_loc8_ != null && param2 != null)
         {
            _loc9_ = _loc8_.getScreenPoint(param2);
            if(_loc9_ != null)
            {
               _loc6_ += _loc9_.x * _loc7_;
               _loc4_ += _loc9_.y * _loc7_;
               _loc5_ = roomEngine.getRoomCanvasScreenOffset(param1);
               if(_loc5_ != null)
               {
                  _loc6_ += _loc5_.x;
                  _loc4_ += _loc5_.y;
               }
            }
         }
         return new Point(_loc6_,_loc4_);
      }
      
      public function get chatFlowViewer() : ChatFlowViewer
      {
         return _chatFlowViewer;
      }
      
      public function get chatBubbleFactory() : ChatBubbleFactory
      {
         return _chatBubbleFactory;
      }
      
      public function get chatHistoryScrollView() : ChatHistoryScrollView
      {
         return _chatHistoryScrollView;
      }
      
      public function get displayObject() : DisplayObject
      {
         if(UnknownVarFromHabboFreeFlowChat_ChatViewController_1)
         {
            return UnknownVarFromHabboFreeFlowChat_ChatViewController_1.rootDisplayObject;
         }
         return null;
      }
      
      public function disableRoomMouseEventsLeftOfX(param1:int) : void
      {
         _roomEngine.mouseEventsDisabledLeftToX = param1;
      }
      
      public function selectAvatarWithChatItem(param1:ChatItem) : void
      {
         selectAvatar(param1.roomId,param1.userId);
      }
      
      public function selectAvatar(param1:int, param2:int) : void
      {
         var _loc5_:IUserData = null;
         var _loc4_:IUserData = null;
         if(_roomUI == null)
         {
            return;
         }
         var _loc3_:IRoomDesktop = _roomUI.desktop;
         _loc3_.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO",param2,100));
         roomEngine.selectAvatar(param1,param2);
         var _loc6_:IRoomSession = _roomSessionManager.getSession(param1);
         if(_loc6_)
         {
            _loc5_ = _loc6_.userDataManager.getUserDataByIndex(param2);
            if(_loc5_ != null)
            {
               _loc4_ = _roomSessionManager.getSession(param1).userDataManager.getUserDataByIndex(param2);
               if(_loc4_ && _moderation)
               {
                  _moderation.userSelected(_loc5_.webID,_loc4_.name);
               }
            }
         }
      }
      
      public function get roomChatSettings() : RoomChatSettings
      {
         return _roomChatSettings;
      }
      
      public function get roomChatBorderLimited() : Boolean
      {
         if(_roomChatSettings)
         {
            return _roomChatSettings.mode == 1;
         }
         return false;
      }
      
      public function clickHasToPropagate(param1:MouseEvent) : Boolean
      {
         return !!_roomUI ? _roomUI.mouseEventPositionHasContextMenu(param1) : false;
      }
      
      public function get chatStyleLibrary() : UnknownIHabboFreeflowchatStyle2
      {
         return !!_chatBubbleFactory ? _chatBubbleFactory.chatStyleLibrary : null;
      }
      
      public function get preferedChatStyle() : int
      {
         return _preferedChatStyle;
      }
      
      public function set preferedChatStyle(param1:int) : void
      {
         _preferedChatStyle = param1;
         _communication.connection.send(new SetChatStylePreferenceComposer(_preferedChatStyle,_chatFontSizeMode));
      }
      
      public function get chatFontSizeMode() : int
      {
         return _chatFontSizeMode;
      }
      
      public function set chatFontSizeMode(param1:int) : void
      {
         param1 = clampChatFontSizeMode(param1);
         _chatFontSizeMode = param1;
         _communication.connection.send(new SetChatStylePreferenceComposer(_preferedChatStyle,_chatFontSizeMode));
      }
      
      public function get chatMode() : int
      {
         return _chatMode;
      }
      
      public function set chatMode(param1:int) : void
      {
         updateChatPreferences(param1,_chatBubbleWidth,_chatScrollSpeed);
      }
      
      public function get chatBubbleWidth() : int
      {
         return _chatBubbleWidth;
      }
      
      public function set chatBubbleWidth(param1:int) : void
      {
         updateChatPreferences(_chatMode,param1,_chatScrollSpeed);
      }
      
      public function get chatScrollSpeed() : int
      {
         return _chatScrollSpeed;
      }
      
      public function set chatScrollSpeed(param1:int) : void
      {
         updateChatPreferences(_chatMode,_chatBubbleWidth,param1);
      }
      
      public function updateChatPreferences(param1:int, param2:int, param3:int) : void
      {
         param1 = sanitizeChatMode(param1);
         param2 = sanitizeChatBubbleWidth(param2);
         param3 = sanitizeChatScrollSpeed(param3);
         if(_chatMode == param1 && _chatBubbleWidth == param2 && _chatScrollSpeed == param3)
         {
            return;
         }
         _chatMode = param1;
         _chatBubbleWidth = param2;
         _chatScrollSpeed = param3;
         refreshEffectiveChatSettings();
         refreshChatSettings();
         sendChatPreferences();
      }
      
      public function get chatFontSizeScale() : Number
      {
         switch(_chatFontSizeMode - 1)
         {
            case 0:
               return 1.15;
            case 1:
               return 1.3;
            case 2:
               return 1.5;
            case 3:
               return 1.75;
            default:
               return 1;
         }
      }
      
      private function clampChatFontSizeMode(param1:int) : int
      {
         if(param1 < 0)
         {
            return 0;
         }
         if(param1 > 4)
         {
            return 4;
         }
         return param1;
      }
      
      private function refreshEffectiveChatSettings() : void
      {
         _roomChatSettings = new RoomChatSettings(_chatMode,_chatBubbleWidth,_chatScrollSpeed,UnknownVarFromHabboFreeFlowChat_Int_1);
      }
      
      private function refreshChatSettings() : void
      {
         if(_isInRoom && UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1)
         {
            UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1.refreshSettings();
         }
      }
      
      private function sendChatPreferences() : void
      {
         _communication.connection.send(new SetChatPreferencesMessageComposer(_chatMode,_chatBubbleWidth,_chatScrollSpeed));
      }
      
      private function sanitizeChatMode(param1:int) : int
      {
         switch(param1)
         {
            case 0:
            case 1:
               return param1;
            default:
               return 0;
         }
      }
      
      private function sanitizeChatBubbleWidth(param1:int) : int
      {
         switch(param1)
         {
            case 0:
            case 1:
            case 2:
               return param1;
            default:
               return 1;
         }
      }
      
      private function sanitizeChatScrollSpeed(param1:int) : int
      {
         switch(param1)
         {
            case 0:
            case 1:
            case 2:
               return param1;
            default:
               return 1;
         }
      }
      
      public function clear() : void
      {
         if(UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1)
         {
            UnknownVarFromHabboFreeFlowChat_ChatFlowStage_1.clear();
         }
      }
      
      public function toggleVisibility() : void
      {
         if(!UnknownVarFromHabboFreeFlowChat_Boolean_1 || !_chatHistoryPulldown)
         {
            return;
         }
         _chatHistoryPulldown.toggleHistoryVisibility();
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(_chatHistoryPulldown != null)
         {
            _chatHistoryPulldown.visible = param1;
         }
      }
      
      public function isNotificationStyle(param1:int) : Boolean
      {
         var _loc2_:ChatStyle = chatStyleLibrary.getStyle(param1) as ChatStyle;
         return _loc2_ != null && _loc2_.isNotification;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function createPreviewBitmap(param1:String, param2:int) : BitmapData
      {
         var _loc6_:ChatStyle = chatStyleLibrary.getStyle(param2) as ChatStyle;
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc3_:RoomSessionChatEvent = new RoomSessionChatEvent("RSCE_CHAT_EVENT",null,-1,"",0);
         var _loc4_:ChatItem = new ChatItem(_loc3_,getTimer(),null,0,null,null,null,param1);
         var _loc5_:PooledChatBubble = new PooledChatBubble(this);
         _loc5_.chatItem = _loc4_;
         _loc5_.face = null;
         _loc5_.style = _loc6_;
         _loc5_.recreate(param1,0,false);
         var _loc7_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         _loc7_.draw(_loc5_);
         return _loc7_;
      }
      
      public function GetChatHistoryBuffer() : ChatHistoryBuffer
      {
         return UnknownVarFromHabboFreeFlowChat_ChatHistoryBuffer_1;
      }
   }
}


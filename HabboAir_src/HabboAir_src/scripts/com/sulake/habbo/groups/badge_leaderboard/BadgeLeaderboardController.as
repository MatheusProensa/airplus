package com.sulake.habbo.groups.badge_leaderboard
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.enum.BadgeRarity;
   import com.sulake.habbo.communication.messages.incoming.users.BadgeLeaderboardEntryData;
   import com.sulake.habbo.communication.messages.incoming.users.BadgeLeaderboardResultMessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.BadgeLeaderboardResultMessageParser;
   import com.sulake.habbo.groups.HabboGroupsManager;
   import com.sulake.habbo.groups.badge_leaderboard.server.BadgeLeaderboardDataServer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.HabboFaceFocuser;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import flash.display.BitmapData;
   
   public class BadgeLeaderboardController extends Component implements UnknownIHabboGroupsBadge_Leaderboard1, UnknownIHabboAvatar1, ILinkEventTracker
   {
      public static const PAGE_SIZE:int = 10;
      
      private static const DEFAULT_RANK_BORDER_COLOR:uint = 6521514;
      
      private static const FIRST_PLACE_RANK_BORDER_COLOR:uint = 13938487;
      
      private static const UnknownConstFromBadgeLeaderboardController_Uint_1:uint = 12632256;
      
      private static const THIRD_PLACE_RANK_BORDER_COLOR:uint = 13467442;
      
      private static const BASE_SUPPORTED_RARITIES:Array = [2,3,4,5,6];
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _groupsManager:HabboGroupsManager;
      
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var _view:BadgeLeaderboardView;
      
      private var UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardDataServer_1:BadgeLeaderboardDataServer;
      
      private var UnknownVarFromBadgeLeaderboardController_Int_1:int = 0;
      
      private var UnknownVarFromBadgeLeaderboardController_Int_2:int = -1;
      
      private var UnknownVarFromBadgeLeaderboardController_Int_3:int;
      
      private var UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1:BadgeLeaderboardPageData;
      
      public function BadgeLeaderboardController(param1:HabboGroupsManager, param2:IComponent_2, param3:uint = 0, param4:IAssetLibraryCollection = null)
      {
         super(param2,param3,param4);
         _groupsManager = param1;
         _messageEvents = new Vector.<IMessageEvent>();
         UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardDataServer_1 = new BadgeLeaderboardDataServer(send);
      }
      
      public function showBadgeLeaderboard(param1:int, param2:int = -1, param3:int = 0) : void
      {
         if(_view == null && _windowManager != null)
         {
            _view = new BadgeLeaderboardView(this,_windowManager);
         }
         if(_view == null)
         {
            return;
         }
         UnknownVarFromBadgeLeaderboardController_Int_1 = normalizeType(param1,param2);
         UnknownVarFromBadgeLeaderboardController_Int_2 = normalizeRarity(UnknownVarFromBadgeLeaderboardController_Int_1,param2);
         UnknownVarFromBadgeLeaderboardController_Int_3 = Math.max(0,param3);
         clearVisibleData();
         updateChrome();
         UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardDataServer_1.requestPage(UnknownVarFromBadgeLeaderboardController_Int_1,UnknownVarFromBadgeLeaderboardController_Int_2,UnknownVarFromBadgeLeaderboardController_Int_3,onPageData);
         _view.show();
      }
      
      public function get linkPattern() : String
      {
         return "badge_leaderboard/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1 == null ? [] : param1.split("/");
         if(_loc2_.length == 0 || _loc2_[0] != "badge_leaderboard")
         {
            return;
         }
         showBadgeLeaderboard(getLinkIntValue(_loc2_,1,0),getLinkIntValue(_loc2_,2,-1),getLinkIntValue(_loc2_,3,0));
      }
      
      public function hide() : void
      {
         if(_view != null)
         {
            _view.hide();
         }
      }
      
      public function onDropdownOpenClicked() : void
      {
         if(_view != null)
         {
            _view.openDropdownMenu();
         }
      }
      
      public function onDropdownSelectionChanged(param1:int) : void
      {
         showBadgeLeaderboard(getTypeByDropdownIndex(param1),getRarityByDropdownIndex(param1),0);
      }
      
      public function onPreviousPageClicked() : void
      {
         if(UnknownVarFromBadgeLeaderboardController_Int_3 > 0)
         {
            showBadgeLeaderboard(UnknownVarFromBadgeLeaderboardController_Int_1,UnknownVarFromBadgeLeaderboardController_Int_2,UnknownVarFromBadgeLeaderboardController_Int_3 - 1);
         }
      }
      
      public function onNextPageClicked() : void
      {
         if(UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1 != null && (UnknownVarFromBadgeLeaderboardController_Int_3 + 1) * 10 < UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1.totalEntries)
         {
            showBadgeLeaderboard(UnknownVarFromBadgeLeaderboardController_Int_1,UnknownVarFromBadgeLeaderboardController_Int_2,UnknownVarFromBadgeLeaderboardController_Int_3 + 1);
         }
      }
      
      public function onProfileRegionClicked(param1:int) : void
      {
         var _loc2_:BadgeLeaderboardEntryData = null;
         if(UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1 == null)
         {
            return;
         }
         if(param1 == -1)
         {
            _loc2_ = UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1.ownEntry;
         }
         else if(param1 >= 0 && param1 < UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1.entries.length)
         {
            _loc2_ = UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1.entries[param1] as BadgeLeaderboardEntryData;
         }
         if(_loc2_ != null)
         {
            _groupsManager.showExtendedProfile(_loc2_.userId);
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         if(_communicationManager != null && _communicationManager.connection != null)
         {
            _communicationManager.connection.send(param1);
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_disposed || UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1 == null || !currentPageContainsFigure(param1))
         {
            return;
         }
         renderEntryFacesForFigure(param1);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),setCommunicationManager,true),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         },false)]);
      }
      
      private function setCommunicationManager(param1:IHabboCommunicationManager) : void
      {
         _communicationManager = param1;
         registerMessageEvents();
      }
      
      private function registerMessageEvents() : void
      {
         if(_disposed || _communicationManager == null)
         {
            return;
         }
         if(_messageEvents == null)
         {
            _messageEvents = new Vector.<IMessageEvent>();
         }
         if(_messageEvents.length > 0)
         {
            return;
         }
         _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(new BadgeLeaderboardResultMessageEvent(onBadgeLeaderboardResult)));
      }
      
      private function onBadgeLeaderboardResult(param1:BadgeLeaderboardResultMessageEvent) : void
      {
         var _loc2_:BadgeLeaderboardResultMessageParser = param1.getParser();
         UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardDataServer_1.onBadgeLeaderboardResult(_loc2_);
      }
      
      private function onPageData(param1:BadgeLeaderboardPageData) : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1 = param1;
         updateChrome();
         renderEntries();
      }
      
      private function updateChrome() : void
      {
         if(_view == null)
         {
            return;
         }
         _view.setFrameStyle(getFrameStyle(UnknownVarFromBadgeLeaderboardController_Int_1,UnknownVarFromBadgeLeaderboardController_Int_2));
         _view.setDropdownOptions(getDropdownOptions(),getDropdownSelectionIndex(UnknownVarFromBadgeLeaderboardController_Int_1,UnknownVarFromBadgeLeaderboardController_Int_2));
         _view.setTitle(getTitleText(UnknownVarFromBadgeLeaderboardController_Int_1,UnknownVarFromBadgeLeaderboardController_Int_2));
         _view.setInfo(getHeaderAssetUri(UnknownVarFromBadgeLeaderboardController_Int_1,UnknownVarFromBadgeLeaderboardController_Int_2),getInfoText(UnknownVarFromBadgeLeaderboardController_Int_1,UnknownVarFromBadgeLeaderboardController_Int_2));
         _view.setRankTypeExtendedImageYOffset(getHeaderAssetYOffset(UnknownVarFromBadgeLeaderboardController_Int_1,UnknownVarFromBadgeLeaderboardController_Int_2));
         _view.setPagerEnabled(canGoPrevious(),canGoNext());
      }
      
      private function renderEntries() : void
      {
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc1_:BadgeLeaderboardEntryData = null;
         var _loc6_:BadgeLeaderboardEntryView = null;
         var _loc4_:* = false;
         var _loc2_:BadgeLeaderboardEntryData = null;
         var _loc7_:String = getRowAssetUri(UnknownVarFromBadgeLeaderboardController_Int_1,UnknownVarFromBadgeLeaderboardController_Int_2);
         if(_view == null)
         {
            return;
         }
         _loc3_ = UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1?.entries;
         _loc5_ = 0;
         while(_loc5_ < _view.entryViews.length)
         {
            _loc6_ = _view.entryViews[_loc5_];
            _loc1_ = _loc5_ < _loc3_.length ? _loc3_[_loc5_] as BadgeLeaderboardEntryData : null;
            if(_loc1_ == null)
            {
               _view.setEntryVisible(_loc5_,false);
               clearFaceBitmap(_loc6_.profileCanvas);
            }
            else
            {
               _loc4_ = (UnknownVarFromBadgeLeaderboardController_Int_3 * 10 + _loc5_) % 2 == 0;
               _view.setEntryVisible(_loc5_,true);
               _loc6_.evenBackground.visible = _loc4_;
               _loc6_.unevenBackground.visible = !_loc4_;
               _loc6_.rankText.text = getRankText(_loc1_.rank);
               _loc6_.usernameText.text = _loc1_.userName;
               _loc6_.scoreText.text = _loc1_.score.toString();
               applyRankBorderColor(_loc6_,_loc1_.rank);
               _loc6_.rankTypeImage.assetUri = _loc7_;
            }
            _loc5_++;
         }
         _loc2_ = UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1?.ownEntry;
         _view.setOwnEntryVisible(_loc2_ != null);
         if(_loc2_ != null)
         {
            _view.ownEntryView.rankText.text = getRankText(_loc2_.rank);
            _view.ownEntryView.usernameText.text = _loc2_.userName;
            _view.ownEntryView.scoreText.text = _loc2_.score.toString();
            applyRankBorderColor(_view.ownEntryView,_loc2_.rank);
            _view.ownEntryView.rankTypeImage.assetUri = _loc7_;
         }
         else
         {
            clearFaceBitmap(_view.ownEntryView.profileCanvas);
         }
         renderEntryFaces();
         _view.setPagerEnabled(canGoPrevious(),canGoNext());
      }
      
      private function renderEntryFaces() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BadgeLeaderboardEntryData = null;
         var _loc2_:Array = UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1?.entries;
         if(_view == null)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _view.entryViews.length)
         {
            _loc1_ = _loc3_ < _loc2_.length ? _loc2_[_loc3_] as BadgeLeaderboardEntryData : null;
            renderEntryFace(_view.entryViews[_loc3_],_loc1_);
            _loc3_++;
         }
         renderEntryFace(_view.ownEntryView,UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1?.ownEntry);
      }
      
      private function renderEntryFacesForFigure(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc2_:BadgeLeaderboardEntryData = null;
         var _loc3_:Array = UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1?.entries;
         if(_view == null || param1 == null)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _view.entryViews.length)
         {
            _loc2_ = _loc4_ < _loc3_.length ? _loc3_[_loc4_] as BadgeLeaderboardEntryData : null;
            if(_loc2_ != null && _loc2_.figureString == param1)
            {
               renderEntryFace(_view.entryViews[_loc4_],_loc2_);
            }
            _loc4_++;
         }
         _loc2_ = UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1?.ownEntry;
         if(_loc2_ != null && _loc2_.figureString == param1)
         {
            renderEntryFace(_view.ownEntryView,_loc2_);
         }
      }
      
      private function renderEntryFace(param1:BadgeLeaderboardEntryView, param2:BadgeLeaderboardEntryData) : void
      {
         var _loc4_:IAvatarImage_2 = null;
         var _loc3_:BitmapData = null;
         clearFaceBitmap(param1.profileCanvas);
         if(param2 == null || _avatarRenderManager == null || param2.figureString == null || param2.figureString.length == 0)
         {
            return;
         }
         _loc4_ = _avatarRenderManager.createAvatarImage(param2.figureString,"h",null,this);
         if(_loc4_ == null)
         {
            return;
         }
         _loc3_ = HabboFaceFocuser.focusUserFace(_loc4_,"head",2,1);
         _loc4_.dispose();
         if(_loc3_ != null)
         {
            setFaceBitmap(param1.profileCanvas,_loc3_);
         }
      }
      
      private function setFaceBitmap(param1:IBitmapWrapperController, param2:BitmapData) : void
      {
         clearFaceBitmap(param1);
         param1.bitmap = param2;
         param1.width = param2.width;
         param1.height = param2.height;
         param1.invalidate();
      }
      
      private function clearFaceBitmap(param1:IBitmapWrapperController) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.bitmap != null)
         {
            param1.bitmap.dispose();
            param1.bitmap = null;
         }
         param1.invalidate();
      }
      
      private function clearVisibleData() : void
      {
         var _loc1_:int = 0;
         UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1 = null;
         if(_view == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _view.entryViews.length)
         {
            _view.setEntryVisible(_loc1_,false);
            clearFaceBitmap(_view.entryViews[_loc1_].profileCanvas);
            _loc1_++;
         }
         _view.setOwnEntryVisible(false);
         clearFaceBitmap(_view.ownEntryView.profileCanvas);
         _view.setPagerEnabled(canGoPrevious(),false);
      }
      
      private function currentPageContainsFigure(param1:String) : Boolean
      {
         var _loc2_:* = null;
         if(UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1 == null || param1 == null)
         {
            return false;
         }
         for each(_loc2_ in UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1.entries)
         {
            if(_loc2_ != null && _loc2_.figureString == param1)
            {
               return true;
            }
         }
         return UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1.ownEntry != null && UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1.ownEntry.figureString == param1;
      }
      
      private function getLinkIntValue(param1:Array, param2:int, param3:int) : int
      {
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         if(param1 == null || param2 < 0 || param2 >= param1.length)
         {
            return param3;
         }
         _loc4_ = param1[param2] as String;
         if(_loc4_ == null || _loc4_.length == 0)
         {
            return param3;
         }
         _loc5_ = Number(_loc4_);
         return isNaN(_loc5_) ? param3 : int(_loc5_);
      }
      
      private function canGoPrevious() : Boolean
      {
         return UnknownVarFromBadgeLeaderboardController_Int_3 > 0;
      }
      
      private function canGoNext() : Boolean
      {
         return UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1 != null && (UnknownVarFromBadgeLeaderboardController_Int_3 + 1) * 10 < UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1.totalEntries;
      }
      
      private function normalizeType(param1:int, param2:int) : int
      {
         if(param1 == 2)
         {
            return param1;
         }
         if(param1 == 1 && isSupportedRarity(param2))
         {
            return param1;
         }
         return 0;
      }
      
      private function normalizeRarity(param1:int, param2:int) : int
      {
         if(param1 == 1)
         {
            return param2;
         }
         return -1;
      }
      
      private function isSupportedRarity(param1:int) : Boolean
      {
         return getSupportedRarities().indexOf(param1) >= 0;
      }
      
      private function getDropdownOptions() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [localizationManager.getLocalization("badge_leaderboard.option.total_badges"),localizationManager.getLocalization("badge_leaderboard.option.achievement_level")];
         var _loc1_:Array = getSupportedRarities();
         for each(_loc3_ in _loc1_)
         {
            _loc2_.push(localizationManager.getLocalizationWithParams("badge_leaderboard.option.rarity","","rarity",getRarityText(_loc3_)));
         }
         return _loc2_;
      }
      
      private function getDropdownSelectionIndex(param1:int, param2:int) : int
      {
         var _loc4_:Array = null;
         var _loc3_:int = 0;
         if(param1 == 0)
         {
            return 0;
         }
         if(param1 == 2)
         {
            return 1;
         }
         _loc4_ = getSupportedRarities();
         _loc3_ = int(_loc4_.indexOf(param2));
         return _loc3_ < 0 ? 0 : _loc3_ + 2;
      }
      
      private function getTypeByDropdownIndex(param1:int) : int
      {
         if(param1 <= 0)
         {
            return 0;
         }
         if(param1 == 1)
         {
            return 2;
         }
         return 1;
      }
      
      private function getRarityByDropdownIndex(param1:int) : int
      {
         var _loc2_:Array = getSupportedRarities();
         if(param1 <= 1 || param1 > _loc2_.length + 1)
         {
            return -1;
         }
         return _loc2_[param1 - 2];
      }
      
      private function getTitleText(param1:int, param2:int) : String
      {
         if(param1 == 1)
         {
            return localizationManager.getLocalizationWithParams("badge_leaderboard.title.rarity","","rarity",getRarityText(param2));
         }
         if(param1 == 2)
         {
            return localizationManager.getLocalization("badge_leaderboard.title.achievement_level");
         }
         return localizationManager.getLocalization("badge_leaderboard.title.total_badges");
      }
      
      private function getInfoText(param1:int, param2:int) : String
      {
         if(param1 == 1)
         {
            return localizationManager.getLocalization(getInfoLocalizationKey(param2));
         }
         if(param1 == 2)
         {
            return localizationManager.getLocalization("badge_leaderboard.info.achievement_level");
         }
         return localizationManager.getLocalization("badge_leaderboard.info.total_badges");
      }
      
      private function getInfoLocalizationKey(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "badge_leaderboard.info.rarity.uncommon";
            case 1:
               return "badge_leaderboard.info.rarity.rare";
            case 2:
               return "badge_leaderboard.info.rarity.epic";
            case 3:
               return "badge_leaderboard.info.rarity.mythical";
            case 4:
               return "badge_leaderboard.info.rarity.legendary";
            case 5:
               return "badge_leaderboard.info.rarity.unique";
            default:
               return "badge_leaderboard.info.total_badges";
         }
      }
      
      private function getRarityText(param1:int) : String
      {
         return localizationManager.getLocalization(BadgeRarity.getLocalizationKey(param1,isUncommonBadgeRarityEnabled()));
      }
      
      private function getHeaderAssetUri(param1:int, param2:int) : String
      {
         if(param1 == 1)
         {
            return getRarityAssetBase(param2) + "_extended";
         }
         if(param1 == 2)
         {
            return "badges_emblem_achievement_extended";
         }
         return "badge_rarity_badges_emblem";
      }
      
      private function getFrameStyle(param1:int, param2:int) : int
      {
         if(param1 == 1)
         {
            switch(param2 - 1)
            {
               case 0:
                  return 10007;
               case 1:
                  return 10002;
               case 2:
                  return 10003;
               case 3:
                  return 10004;
               case 4:
                  return 10005;
               case 5:
                  return 10006;
            }
         }
         if(param1 == 2)
         {
            return 10001;
         }
         return 10000;
      }
      
      private function getHeaderAssetYOffset(param1:int, param2:int) : int
      {
         if(param1 == 0 || param1 == 1 && param2 == 1)
         {
            return -9;
         }
         if(param1 == 2)
         {
            return -7;
         }
         return 0;
      }
      
      private function getRowAssetUri(param1:int, param2:int) : String
      {
         if(param1 == 1)
         {
            return getRarityAssetBase(param2);
         }
         if(param1 == 2)
         {
            return "badges_emblem_achievement";
         }
         return "badge_rarity_badges_emblem";
      }
      
      private function getRarityAssetBase(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "badge_rarity_badges_emblem_uncommon";
            case 1:
               return "badge_rarity_badges_emblem_rare";
            case 2:
               return "badge_rarity_badges_emblem_very_rare";
            case 3:
               return "badge_rarity_badges_emblem_mythical";
            case 4:
               return "badge_rarity_badges_emblem_legendary";
            case 5:
               return "badge_rarity_badges_emblem_unique";
            default:
               return "badge_rarity_badges_emblem";
         }
      }
      
      private function getSupportedRarities() : Array
      {
         var _loc1_:Array = BASE_SUPPORTED_RARITIES.concat();
         if(isUncommonBadgeRarityEnabled())
         {
            _loc1_.unshift(1);
         }
         return _loc1_;
      }
      
      private function isUncommonBadgeRarityEnabled() : Boolean
      {
         return _groupsManager != null && _groupsManager.getBoolean("badge_rarity.uncommon");
      }
      
      private function getRankText(param1:int) : String
      {
         return param1 < 0 ? "--" : param1.toString();
      }
      
      private function applyRankBorderColor(param1:BadgeLeaderboardEntryView, param2:int) : void
      {
         if(param1 == null || param1.rankBorder == null)
         {
            return;
         }
         param1.rankBorder.color = getRankBorderColor(param2);
      }
      
      private function getRankBorderColor(param1:int) : uint
      {
         switch(param1 - 1)
         {
            case 0:
               return 13938487;
            case 1:
               return 12632256;
            case 2:
               return 13467442;
            default:
               return 6521514;
         }
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get groupsManager() : HabboGroupsManager
      {
         return _groupsManager;
      }
      
      public function get view() : BadgeLeaderboardView
      {
         return _view;
      }
      
      override public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         if(_disposed)
         {
            return;
         }
         clearVisibleData();
         if(_view != null)
         {
            _view.dispose();
            _view = null;
         }
         if(UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardDataServer_1 != null)
         {
            UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardDataServer_1.dispose();
            UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardDataServer_1 = null;
         }
         if(_messageEvents != null && _communicationManager != null)
         {
            for each(_loc1_ in _messageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         _messageEvents = null;
         _communicationManager = null;
         _localizationManager = null;
         _windowManager = null;
         _avatarRenderManager = null;
         _groupsManager = null;
         UnknownVarFromBadgeLeaderboardController_BadgeLeaderboardPageData_1 = null;
         _disposed = true;
         super.dispose();
      }
   }
}


package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarFigureContainer;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2ExitGameMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class GameLoadingViewController implements IComponentInterfaceQueue, UnknownIHabboAvatar1
   {
      private var _disposed:Boolean;
      
      private var UnknownVarFromGameLoadingViewController_SnowWarEngine_1:SnowWarEngine;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromGameLoadingViewController_Map_1:Map;
      
      private var UnknownVarFromGameLoadingViewController_GameLobbyData_1:GameLobbyData;
      
      private var UnknownVarFromGameLoadingViewController_BackgroundViewController_1:BackgroundViewController;
      
      private var _avatarFigures:Array = [];
      
      public function GameLoadingViewController(param1:SnowWarEngine)
      {
         super();
         UnknownVarFromGameLoadingViewController_SnowWarEngine_1 = param1;
         UnknownVarFromGameLoadingViewController_Map_1 = new Map();
         createMainWindow();
         UnknownVarFromGameLoadingViewController_BackgroundViewController_1 = new BackgroundViewController(UnknownVarFromGameLoadingViewController_SnowWarEngine_1);
         UnknownVarFromGameLoadingViewController_BackgroundViewController_1.background.visible = true;
         UnknownVarFromGameLoadingViewController_SnowWarEngine_1.windowManager.getDesktop(1).visible = false;
         UnknownVarFromGameLoadingViewController_SnowWarEngine_1.roomUI.visible = false;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromGameLoadingViewController_SnowWarEngine_1.windowManager.getDesktop(1).visible = true;
         UnknownVarFromGameLoadingViewController_SnowWarEngine_1 = null;
         if(UnknownVarFromGameLoadingViewController_Map_1)
         {
            for each(var _loc1_ in UnknownVarFromGameLoadingViewController_Map_1)
            {
               _loc1_.dispose();
            }
            UnknownVarFromGameLoadingViewController_Map_1.dispose();
            UnknownVarFromGameLoadingViewController_Map_1 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromGameLoadingViewController_BackgroundViewController_1)
         {
            UnknownVarFromGameLoadingViewController_BackgroundViewController_1.dispose();
            UnknownVarFromGameLoadingViewController_BackgroundViewController_1 = null;
         }
         _disposed = true;
         _avatarFigures = [];
      }
      
      private function createMainWindow() : void
      {
         _window = WindowUtils.createWindow("snowwar_ending") as IWindowController_1;
         _window.x = (_window.desktop.width - _window.width) / 2;
         _window.y = _window.desktop.height > 685 ? 115 : 10;
         WindowUtils.setCaption(_window.findChildByName("endingInformation"),"${snowwar.loading.title}");
         WindowUtils.hideElement(_window,"buttonsContainer");
         WindowUtils.hideElement(_window,"mostKillsContainer");
         WindowUtils.hideElement(_window,"mostHitsContainer");
         WindowUtils.hideElement(_window,"team1Score");
         WindowUtils.hideElement(_window,"team2Score");
         WindowUtils.hideElement(_window,"statusContainer");
         _window.findChildByName("loadingContainer").visible = true;
         _window.findChildByName("leave_link_region").procedure = onCancel;
      }
      
      private function onCancel(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         onClose();
      }
      
      private function onClose() : void
      {
         if(UnknownVarFromGameLoadingViewController_SnowWarEngine_1 != null)
         {
            UnknownVarFromGameLoadingViewController_SnowWarEngine_1.gameCancelled(true);
            UnknownVarFromGameLoadingViewController_SnowWarEngine_1.send(new Game2ExitGameMessageComposer());
            if(UnknownVarFromGameLoadingViewController_SnowWarEngine_1.roomBeforeGame > -1)
            {
               UnknownVarFromGameLoadingViewController_SnowWarEngine_1.send(new GetGuestRoomMessageComposer(UnknownVarFromGameLoadingViewController_SnowWarEngine_1.roomBeforeGame,false,true));
            }
            UnknownVarFromGameLoadingViewController_SnowWarEngine_1.disposeLoadingView();
         }
      }
      
      public function show(param1:GameLobbyData) : void
      {
         UnknownVarFromGameLoadingViewController_GameLobbyData_1 = param1;
         var _loc2_:IBitmapWrapperController = _window.findChildByName("arenaPreview") as IBitmapWrapperController;
         var _loc3_:ISoundAsset = UnknownVarFromGameLoadingViewController_SnowWarEngine_1.assets.getAssetByName("arena_" + param1.fieldType + "_preview");
         if(_loc3_)
         {
            _loc2_.bitmap = _loc3_.content as BitmapData;
            _loc2_.disposesBitmap = false;
         }
         WindowUtils.setCaption(_window.findChildByName("arenaName"),UnknownVarFromGameLoadingViewController_SnowWarEngine_1.getArenaName(param1));
         renderPlayers();
      }
      
      private function renderPlayers() : void
      {
         clearPlayers();
         for each(var _loc1_ in UnknownVarFromGameLoadingViewController_GameLobbyData_1.players.sort(GameLobbyPlayerData.UnknownVarFromGameLobbyPlayerData_Function_2))
         {
            addPlayer(_loc1_);
         }
      }
      
      private function clearPlayers() : void
      {
         var _loc2_:IItemListWindow = null;
         var _loc1_:int = 1;
         while(true)
         {
            _loc2_ = _window.findChildByName("team" + _loc1_++ + "PlayersList") as IItemListWindow;
            if(_loc2_ == null)
            {
               break;
            }
            _loc2_.destroyListItems();
         }
      }
      
      private function addPlayer(param1:GameLobbyPlayerData) : void
      {
         var _loc12_:int = 0;
         var _loc5_:int = param1.teamId;
         var _loc8_:IItemListWindow = _window.findChildByName("team" + _loc5_ + "PlayersList") as IItemListWindow;
         var _loc7_:IItemListWindow = WindowUtils.createWindow("snowwar_results_player_team_" + _loc5_) as IItemListWindow;
         var _loc9_:IWindowController_1 = _loc7_.getListItemByName("playerImageContainer") as IWindowController_1;
         var _loc6_:IWindowController_1 = _loc7_.getListItemByName("playerDataContainer") as IWindowController_1;
         var _loc2_:IWindowController_1 = _loc7_.getListItemByName("playerScoreContainer") as IWindowController_1;
         if(param1.userId == UnknownVarFromGameLoadingViewController_SnowWarEngine_1.sessionDataManager.userId)
         {
            WindowUtils.setElementImage(_loc9_.findChildByName("playerImageBackground"),getBitmap("green_square"));
         }
         switch(_loc5_ - 1)
         {
            case 1:
               _loc12_ = 4;
               break;
            default:
               _loc12_ = 2;
         }
         WindowUtils.setElementImage(getElement(_loc9_,"playerImage"),getAvatarFigure(param1.teamId,param1.figure,param1.gender,_loc12_));
         WindowUtils.setCaption(getElement(_loc6_,"playerName"),param1.name);
         WindowUtils.hideElement(_loc6_,"playerStats");
         WindowUtils.hideElement(_loc2_,"playerScore");
         WindowUtils.hideElement(_loc6_,"playerTotalStats");
         var _loc10_:IBitmapWrapperController = _loc6_.findChildByName("skillLevel") as IBitmapWrapperController;
         if(_loc10_.bitmap)
         {
            _loc10_.bitmap.dispose();
         }
         _loc10_.bitmap = getSkillLevelImage(param1.skillLevel,param1.teamId);
         var _loc3_:IRegionWindow = _loc6_.findChildByName("scoreTooltip") as IRegionWindow;
         _loc3_.toolTipCaption = param1.totalScore.toString() + "/" + param1.scoreToNextLevel.toString();
         _loc3_.visible = true;
         _loc8_.addListItem(_loc7_);
         var _loc4_:IBitmapWrapperController = _loc2_.findChildByName("loadingIcon") as IBitmapWrapperController;
         var _loc11_:SnowWarAnimatedWindowElement = UnknownVarFromGameLoadingViewController_Map_1.remove(param1.userId);
         if(_loc11_)
         {
            _loc11_.dispose();
         }
         _loc11_ = new SnowWarAnimatedWindowElement(UnknownVarFromGameLoadingViewController_SnowWarEngine_1.assets,_loc4_,"load_",8);
         UnknownVarFromGameLoadingViewController_Map_1.add(param1.userId,_loc11_);
         _loc4_.visible = true;
      }
      
      private function getSkillLevelImage(param1:int, param2:int) : BitmapData
      {
         var _loc6_:BitmapData = null;
         var _loc8_:int = 0;
         var _loc7_:Point = null;
         param1 = Math.min(param1,30);
         var _loc3_:BitmapData = UnknownVarFromGameLoadingViewController_SnowWarEngine_1.assets.getAssetByName("star_empty").content as BitmapData;
         var _loc11_:BitmapData = UnknownVarFromGameLoadingViewController_SnowWarEngine_1.assets.getAssetByName("star_filled_bronze").content as BitmapData;
         var _loc9_:BitmapData = UnknownVarFromGameLoadingViewController_SnowWarEngine_1.assets.getAssetByName("star_filled_silver").content as BitmapData;
         var _loc10_:BitmapData = UnknownVarFromGameLoadingViewController_SnowWarEngine_1.assets.getAssetByName("star_filled_gold").content as BitmapData;
         var _loc5_:int = param1 > 0 ? (param1 - 1) % 10 + 1 : 0;
         var _loc4_:BitmapData = new BitmapData(150,13,true,0);
         _loc8_ = 0;
         while(_loc8_ < 10)
         {
            _loc7_ = param2 == 1 ? new Point(_loc8_ * 15,0) : new Point((9 - _loc8_) * 15,0);
            _loc6_ = param1 > 20 ? (_loc5_-- > 0 ? _loc10_ : _loc3_) : (param1 > 10 ? (_loc5_-- > 0 ? _loc9_ : _loc3_) : (_loc5_-- > 0 ? _loc11_ : _loc3_));
            _loc4_.copyPixels(_loc6_,_loc6_.rect,_loc7_);
            _loc8_++;
         }
         return _loc4_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_avatarFigures.indexOf(param1) == -1)
         {
            renderPlayers();
            _avatarFigures.push(param1);
         }
      }
      
      private function getElement(param1:IWindowController_1, param2:String) : IWindowModel
      {
         return param1.findChildByName(param2);
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         return UnknownVarFromGameLoadingViewController_SnowWarEngine_1.assets.getAssetByName(param1).content as BitmapData;
      }
      
      private function getAvatarFigure(param1:int, param2:String, param3:String, param4:int) : BitmapData
      {
         var _loc5_:IAvatarFigureContainer = UnknownVarFromGameLoadingViewController_SnowWarEngine_1.avatarManager.createFigureContainer(param2);
         switch(param1 - 1)
         {
            case 0:
               _loc5_.updatePart("ch",20000,[1]);
               break;
            case 1:
               _loc5_.updatePart("ch",20001,[1]);
               break;
            default:
               _loc5_.updatePart("ch",20000,[1]);
         }
         _loc5_.removePart("cc");
         var _loc6_:IAvatarImage_2 = UnknownVarFromGameLoadingViewController_SnowWarEngine_1.avatarManager.createAvatarImage(_loc5_.getFigureString(),"h_50",param3,this);
         if(_loc6_)
         {
            _loc6_.setDirection("full",param4);
            return _loc6_.getCroppedImage("full");
         }
         return null;
      }
      
      public function showReadyPlayers(param1:Array) : void
      {
         var _loc3_:SnowWarAnimatedWindowElement = null;
         for each(var _loc2_ in param1)
         {
            _loc3_ = UnknownVarFromGameLoadingViewController_Map_1.remove(_loc2_);
            if(_loc3_)
            {
               _loc3_.dispose();
            }
         }
         if(UnknownVarFromGameLoadingViewController_Map_1.length == 0)
         {
            UnknownVarFromGameLoadingViewController_Map_1.add(-1,new SnowWarAnimatedWindowElement(UnknownVarFromGameLoadingViewController_SnowWarEngine_1.assets,_window.findChildByName("mainLoadingIcon") as IBitmapWrapperController,"load_",8));
            WindowUtils.setCaption(_window.findChildByName("loadingText"),"${snowwar.loading_arena}");
         }
      }
   }
}


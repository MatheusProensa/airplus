package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GamesMainViewController implements IComponentInterfaceQueue
   {
      private static const INSTRUCTION_FRAME_LENGTH:int = 1000;
      
      private static const INSTRUCTION_ASSETS:Array = ["move_","throw_1_","throw_2_","throw_3_","balls_"];
      
      private static const INSTRUCTION_FRAME_COUNTS:Array = [4,4,5,5,5];
      
      private var _gameEngine:SnowWarEngine;
      
      private var _rootWindow:IWindowController_1;
      
      private var UnknownVarFromGamesMainViewController_IWindowController_1_1:IWindowController_1;
      
      private var _lobbyView:GameLobbyWindowCtrl;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromGamesMainViewController_SnowWarAnimatedWindowElement_1:SnowWarAnimatedWindowElement;
      
      private var UnknownVarFromGamesMainViewController_Timer_1:Timer;
      
      private var UnknownVarFromGamesMainViewController_Int_1:int = 0;
      
      private var UnknownVarFromGamesMainViewController_Int_2:int = 0;
      
      public function GamesMainViewController(param1:SnowWarEngine)
      {
         super();
         _gameEngine = param1;
      }
      
      public function get gameEngine() : SnowWarEngine
      {
         return _gameEngine;
      }
      
      public function get rootWindow() : IWindowController_1
      {
         return _rootWindow;
      }
      
      public function get lobbyView() : GameLobbyWindowCtrl
      {
         return _lobbyView;
      }
      
      public function toggleVisibility() : void
      {
         if(_rootWindow)
         {
            _rootWindow.visible = !rootWindow.visible;
         }
         else
         {
            openMainWindow(true);
         }
      }
      
      private function createWindow() : void
      {
         var _loc1_:int = 0;
         _rootWindow = WindowUtils.createWindow("games_main",1) as IWindowController_1;
         _rootWindow.findChildByTag("close").addEventListener("WME_CLICK",onClose);
         _rootWindow.visible = true;
         _rootWindow.center();
         UnknownVarFromGamesMainViewController_IWindowController_1_1 = _rootWindow.findChildByName("quick_play_container") as IWindowController_1;
         UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("play.button").addEventListener("WME_CLICK",onPlay);
         UnknownVarFromGamesMainViewController_IWindowController_1_1.visible = false;
         UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("instructions_link").addEventListener("WME_CLICK",onInstructions);
         UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("leaderboard_link").addEventListener("WME_CLICK",onLeaderboard);
         UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("instructions_back").addEventListener("WME_CLICK",onBack);
         UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("instructions_next").addEventListener("WME_CLICK",onNext);
         UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("instructions_prev").addEventListener("WME_CLICK",onPrevious);
         UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("games_vip_region").addEventListener("WME_CLICK",onOpenClubCenter);
         UnknownVarFromGamesMainViewController_IWindowController_1_1.procedure = windowEventProc;
         UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("leaderboard_link").visible = _gameEngine.config.getBoolean("games.highscores.enabled");
         var _loc2_:IItemListWindow = UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("page_list") as IItemListWindow;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.numListItems)
         {
            _loc2_.getListItemAt(_loc1_).addEventListener("WME_CLICK",onSelectPage);
            _loc1_++;
         }
         _disposed = false;
         updateGameStartingStatus();
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_OVER" || param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "btn_more_games_10":
                  WindowUtils.setElementImage(param2,getBitmap("btn_more_games_10" + (param1.type == "WME_OVER" ? "_hi" : "")));
                  break;
               case "btn_more_games_100":
                  WindowUtils.setElementImage(param2,getBitmap("btn_more_games_100" + (param1.type == "WME_OVER" ? "_hi" : "")));
                  break;
               case "btn_more_games_300":
                  WindowUtils.setElementImage(param2,getBitmap("btn_more_games_300" + (param1.type == "WME_OVER" ? "_hi" : "")));
            }
         }
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "btn_more_games_10":
                  _gameEngine.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS");
                  _gameEngine.logGameEvent("gameFramework.buyTokens.clicked.frontView");
                  break;
               case "btn_more_games_100":
                  _gameEngine.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS2");
                  _gameEngine.logGameEvent("gameFramework.buyTokens.clicked.frontView");
                  break;
               case "btn_more_games_300":
                  _gameEngine.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS3");
                  _gameEngine.logGameEvent("gameFramework.buyTokens.clicked.frontView");
            }
         }
      }
      
      public function close(param1:Boolean) : void
      {
         if(_lobbyView && _lobbyView.visible)
         {
            _lobbyView.onClose(param1);
         }
         disposeViews();
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         close(true);
      }
      
      private function onPlay(param1:WindowMouseEvent) : void
      {
         if(_gameEngine.freeGamesLeft != 0)
         {
            _gameEngine.startQuickServerGame();
         }
         else
         {
            _gameEngine.openGetMoreGames("gameFramework.onPlay.clicked.frontView");
         }
      }
      
      private function updateGettingMoreGamesOption() : void
      {
         var _loc1_:IWindowModel = UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("play.button");
         if(_gameEngine.freeGamesLeft == 0)
         {
            _loc1_.visible = false;
         }
         else
         {
            _loc1_.visible = true;
         }
      }
      
      private function onInstructions(param1:WindowMouseEvent) : void
      {
         showInstructions(true);
      }
      
      private function onLeaderboard(param1:WindowMouseEvent) : void
      {
         _gameEngine.showLeaderboard();
      }
      
      private function onBack(param1:WindowMouseEvent) : void
      {
         showInstructions(false);
      }
      
      private function onNext(param1:WindowMouseEvent) : void
      {
         UnknownVarFromGamesMainViewController_Int_2++;
         UnknownVarFromGamesMainViewController_Int_2 %= INSTRUCTION_ASSETS.length;
         showInstructions(true);
      }
      
      private function onPrevious(param1:WindowMouseEvent) : void
      {
         UnknownVarFromGamesMainViewController_Int_2 = UnknownVarFromGamesMainViewController_Int_2 - 1 + INSTRUCTION_ASSETS.length;
         UnknownVarFromGamesMainViewController_Int_2 %= INSTRUCTION_ASSETS.length;
         showInstructions(true);
      }
      
      private function onSelectPage(param1:WindowMouseEvent) : void
      {
         UnknownVarFromGamesMainViewController_Int_2 = parseInt(param1.window.name.replace("page_",""));
         showInstructions(true);
      }
      
      private function showInstructions(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc7_:IWindowController_1 = null;
         UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("teaser_container").visible = !param1;
         UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("instructions_container").visible = param1;
         if(UnknownVarFromGamesMainViewController_SnowWarAnimatedWindowElement_1)
         {
            UnknownVarFromGamesMainViewController_SnowWarAnimatedWindowElement_1.dispose();
            UnknownVarFromGamesMainViewController_SnowWarAnimatedWindowElement_1 = null;
         }
         if(!param1)
         {
            return;
         }
         var _loc4_:IBitmapWrapperController = UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("instructions_image") as IBitmapWrapperController;
         var _loc6_:String = INSTRUCTION_ASSETS[UnknownVarFromGamesMainViewController_Int_2];
         var _loc2_:int = int(INSTRUCTION_FRAME_COUNTS[UnknownVarFromGamesMainViewController_Int_2]);
         UnknownVarFromGamesMainViewController_SnowWarAnimatedWindowElement_1 = new SnowWarAnimatedWindowElement(_gameEngine.assets,_loc4_,_loc6_,_loc2_,1000);
         UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("instruction_text").caption = "${snowwar.instructions." + (UnknownVarFromGamesMainViewController_Int_2 + 1) + "}";
         var _loc5_:IItemListWindow = UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("page_list") as IItemListWindow;
         _loc3_ = 0;
         while(_loc3_ < _loc5_.numListItems)
         {
            _loc7_ = _loc5_.getListItemAt(_loc3_) as IWindowController_1;
            _loc6_ = _loc3_ <= UnknownVarFromGamesMainViewController_Int_2 ? "pagination_ball_hilite" : "pagination_ball";
            WindowUtils.setElementImage(_loc7_.getChildAt(0),getBitmap(_loc6_));
            _loc3_++;
         }
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         var _loc2_:ISoundAsset = _gameEngine.assets.getAssetByName(param1);
         if(_loc2_)
         {
            return _loc2_.content as BitmapData;
         }
         return null;
      }
      
      private function onOpenClubCenter(param1:WindowMouseEvent) : void
      {
         _gameEngine.openClubCenter("gameFramework.getVip.clicked.frontView");
      }
      
      public function openMainWindow(param1:Boolean) : void
      {
         if(!_rootWindow && param1)
         {
            createWindow();
         }
         else if(!rootWindow && !param1)
         {
            return;
         }
         if(_lobbyView)
         {
            _lobbyView.visible = false;
         }
         UnknownVarFromGamesMainViewController_IWindowController_1_1.visible = true;
      }
      
      public function openGameLobbyWindow(param1:String, param2:int, param3:int) : void
      {
         if(!_rootWindow)
         {
            createWindow();
         }
         if(!_lobbyView)
         {
            _lobbyView = new GameLobbyWindowCtrl(this,param1,param2,param3);
         }
         else
         {
            _lobbyView.levelName = param1;
            _lobbyView.numberOfTeams = param2;
            _lobbyView.maxNumberOfPlayers = param3;
            _lobbyView.clearPlayerList();
         }
         UnknownVarFromGamesMainViewController_IWindowController_1_1.visible = false;
         _lobbyView.visible = true;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            disposeViews();
            _disposed = true;
            disposeCounter();
         }
      }
      
      private function disposeViews() : void
      {
         if(UnknownVarFromGamesMainViewController_SnowWarAnimatedWindowElement_1)
         {
            UnknownVarFromGamesMainViewController_SnowWarAnimatedWindowElement_1.dispose();
            UnknownVarFromGamesMainViewController_SnowWarAnimatedWindowElement_1 = null;
         }
         if(_lobbyView)
         {
            _lobbyView.dispose();
            _lobbyView = null;
         }
         if(UnknownVarFromGamesMainViewController_IWindowController_1_1)
         {
            UnknownVarFromGamesMainViewController_IWindowController_1_1.dispose();
            UnknownVarFromGamesMainViewController_IWindowController_1_1 = null;
         }
         if(_rootWindow)
         {
            _rootWindow.dispose();
            _rootWindow = null;
         }
      }
      
      private function disposeCounter() : void
      {
         if(UnknownVarFromGamesMainViewController_Timer_1)
         {
            UnknownVarFromGamesMainViewController_Timer_1.removeEventListener("timer",onTick);
            UnknownVarFromGamesMainViewController_Timer_1.stop();
            UnknownVarFromGamesMainViewController_Timer_1 = null;
         }
         UnknownVarFromGamesMainViewController_Int_1 = NaN;
      }
      
      public function get gameLobbyWindowActive() : Boolean
      {
         return _lobbyView && _lobbyView.visible;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function updateGameStartingStatus() : void
      {
         var _loc1_:IWindowController_1 = null;
         var _loc3_:ITextWindow = null;
         var _loc2_:IWindowModel = null;
         if(UnknownVarFromGamesMainViewController_IWindowController_1_1 && UnknownVarFromGamesMainViewController_IWindowController_1_1.visible)
         {
            WindowUtils.setCaption(UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("games_left"),_gameEngine.freeGamesLeft.toString());
            _loc1_ = UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("games_left_region") as IWindowController_1;
            _loc3_ = UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("games_left_stroke") as ITextWindow;
            _loc2_ = UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("play.button");
            _loc2_.visible = true;
            updateGettingMoreGamesOption();
            if(checkGameAmountStatus(_loc1_,_loc3_,_loc2_))
            {
               checkBlockStatus(_loc2_);
            }
         }
      }
      
      private function checkGameAmountStatus(param1:IWindowController_1, param2:ITextWindow, param3:IWindowModel) : Boolean
      {
         if(_gameEngine.hasUnlimitedGames)
         {
            param1.visible = false;
            return true;
         }
         param1.visible = true;
         var _loc4_:IWindowModel = ITextWindow(UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("play_text"));
         param3.color = 5622784;
         switch(_gameEngine.freeGamesLeft - -1)
         {
            case 0:
               param1.visible = false;
               WindowUtils.setCaption(_loc4_,"${snowwar.play}");
               return true;
            case 1:
               param1.visible = true;
               param2.textColor = 16711680;
               WindowUtils.setCaption(_loc4_,"${catalog.vip.buy.title}");
               return false;
            default:
               param1.visible = true;
               param2.textColor = 1079212;
               WindowUtils.setCaption(_loc4_,"${snowwar.play}");
               return true;
         }
      }
      
      private function checkBlockStatus(param1:IWindowModel) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:IWindowModel = ITextWindow(UnknownVarFromGamesMainViewController_IWindowController_1_1.findChildByName("play_text"));
         if(UnknownVarFromGamesMainViewController_Int_1 > 0)
         {
            param1.disable();
            param1.color = 13421772;
            _loc3_ = Math.floor(UnknownVarFromGamesMainViewController_Int_1 / 60);
            _loc2_ = UnknownVarFromGamesMainViewController_Int_1 % 60;
            _loc4_.caption = _loc3_ + ":" + (_loc2_ < 10 ? "0" + _loc2_ : _loc2_);
         }
         else if(UnknownVarFromGamesMainViewController_Int_1 <= 0)
         {
            param1.enable();
            param1.color = 5622784;
            WindowUtils.setCaption(_loc4_,"${snowwar.play}");
         }
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(UnknownVarFromGamesMainViewController_Int_1 && UnknownVarFromGamesMainViewController_Int_1 > 0)
         {
            UnknownVarFromGamesMainViewController_Int_1--;
            HabboGamesCom.log("on block tick " + UnknownVarFromGamesMainViewController_Int_1);
            updateGameStartingStatus();
         }
         if(UnknownVarFromGamesMainViewController_Int_1 <= 0)
         {
            updateGameStartingStatus();
            disposeCounter();
         }
      }
      
      public function changeBlockStatus(param1:int) : void
      {
         if(param1 > 0)
         {
            UnknownVarFromGamesMainViewController_Int_1 = param1;
            if(!UnknownVarFromGamesMainViewController_Timer_1)
            {
               UnknownVarFromGamesMainViewController_Timer_1 = new Timer(1000,UnknownVarFromGamesMainViewController_Int_1);
               UnknownVarFromGamesMainViewController_Timer_1.addEventListener("timer",onTick);
               UnknownVarFromGamesMainViewController_Timer_1.start();
            }
         }
         updateGameStartingStatus();
      }
   }
}


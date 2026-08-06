package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2LeaveGameMessageComposer;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class GameLobbyWindowCtrl implements IComponentInterfaceQueue, UnknownIHabboAvatar1
   {
      private var UnknownVarFromGameLobbyWindowCtrl_GamesMainViewController_1:GamesMainViewController;
      
      private var UnknownVarFromGameLobbyWindowCtrl_SnowWarEngine_1:SnowWarEngine;
      
      private var _levelName:String;
      
      private var _numberOfTeams:int;
      
      private var _numberOfPlayers:int;
      
      private var _maxNumberOfPlayers:int;
      
      private var UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromGameLobbyWindowCtrl_Timer_1:Timer;
      
      private var UnknownVarFromGameLobbyWindowCtrl_Int_1:int = -1;
      
      private var UnknownVarFromGameLobbyWindowCtrl_Int_2:int = -1;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromGameLobbyWindowCtrl_Map_1:Map;
      
      private var UnknownVarFromGameLobbyWindowCtrl_Map_2:Map;
      
      public function GameLobbyWindowCtrl(param1:GamesMainViewController, param2:String, param3:int, param4:int)
      {
         super();
         UnknownVarFromGameLobbyWindowCtrl_GamesMainViewController_1 = param1;
         UnknownVarFromGameLobbyWindowCtrl_SnowWarEngine_1 = param1.gameEngine;
         UnknownVarFromGameLobbyWindowCtrl_Map_1 = new Map();
         UnknownVarFromGameLobbyWindowCtrl_Map_2 = new Map();
         _levelName = param2;
         _numberOfTeams = param3;
         _numberOfPlayers = numberOfPlayers;
         _maxNumberOfPlayers = param4;
      }
      
      private function createLobbyView() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1 = UnknownVarFromGameLobbyWindowCtrl_GamesMainViewController_1.rootWindow.findChildByName("snowwar_lobby_cont") as IWindowController_1;
         UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1.center();
         UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1.findChildByName("cancel_link_region").procedure = onCancel;
         var _loc2_:IItemGridWindow = UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1.findChildByName("players_grid") as IItemGridWindow;
         var _loc4_:IWindowController_1 = WindowUtils.createWindow("snowwar_lobby_player") as IWindowController_1;
         _loc3_ = 0;
         while(_loc3_ < _maxNumberOfPlayers)
         {
            _loc2_.addGridItem(_loc4_.clone());
            _loc3_++;
         }
         _loc4_.dispose();
         UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1.visible = false;
      }
      
      private function createWindow(param1:String) : IWindowController_1
      {
         var _loc2_:XmlAsset = UnknownVarFromGameLobbyWindowCtrl_SnowWarEngine_1.assets.getAssetByName(param1) as XmlAsset;
         return UnknownVarFromGameLobbyWindowCtrl_SnowWarEngine_1.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
      }
      
      private function onCancel(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         onClose(true);
         if(!UnknownVarFromGameLobbyWindowCtrl_SnowWarEngine_1.gameCenterEnabled)
         {
            UnknownVarFromGameLobbyWindowCtrl_GamesMainViewController_1.openMainWindow(true);
         }
         else
         {
            UnknownVarFromGameLobbyWindowCtrl_GamesMainViewController_1.close(true);
         }
      }
      
      public function onClose(param1:Boolean) : void
      {
         if(param1)
         {
            UnknownVarFromGameLobbyWindowCtrl_SnowWarEngine_1.communication.connection.send(new Game2LeaveGameMessageComposer());
         }
         disposeCountdownTimer();
         UnknownVarFromGameLobbyWindowCtrl_Int_2 = -1;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(!UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1)
         {
            createLobbyView();
         }
         UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1.visible = param1;
      }
      
      public function get visible() : Boolean
      {
         if(UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1)
         {
            return UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1.visible;
         }
         return false;
      }
      
      public function dispose() : void
      {
         _disposed = true;
         if(UnknownVarFromGameLobbyWindowCtrl_Map_2)
         {
            for each(var _loc1_ in UnknownVarFromGameLobbyWindowCtrl_Map_2)
            {
               _loc1_.dispose();
            }
            UnknownVarFromGameLobbyWindowCtrl_Map_2.dispose();
            UnknownVarFromGameLobbyWindowCtrl_Map_2 = null;
         }
         if(UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1 != null)
         {
            UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1.dispose();
            UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1 = null;
         }
         disposeCountdownTimer();
         if(UnknownVarFromGameLobbyWindowCtrl_Map_1)
         {
            UnknownVarFromGameLobbyWindowCtrl_Map_1.dispose();
            UnknownVarFromGameLobbyWindowCtrl_Map_1 = null;
         }
         UnknownVarFromGameLobbyWindowCtrl_Int_2 = -1;
      }
      
      private function disposeCountdownTimer() : void
      {
         if(UnknownVarFromGameLobbyWindowCtrl_Timer_1 != null)
         {
            UnknownVarFromGameLobbyWindowCtrl_Timer_1.removeEventListener("timer",onTick);
            UnknownVarFromGameLobbyWindowCtrl_Timer_1.stop();
            UnknownVarFromGameLobbyWindowCtrl_Timer_1 = null;
         }
         UnknownVarFromGameLobbyWindowCtrl_Int_1 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function playerLeft(param1:int) : void
      {
         UnknownVarFromGameLobbyWindowCtrl_Map_1.remove(param1);
         updateDialog(true);
      }
      
      public function playerJoined(param1:GameLobbyPlayerData) : void
      {
         if(param1)
         {
            UnknownVarFromGameLobbyWindowCtrl_Map_1.add(param1.userId,param1);
            updateDialog(true,param1.figure);
         }
      }
      
      public function clearPlayerList() : void
      {
         UnknownVarFromGameLobbyWindowCtrl_Map_1.reset();
      }
      
      public function startCountdown(param1:int) : void
      {
         disposeCountdownTimer();
         UnknownVarFromGameLobbyWindowCtrl_Int_1 = param1;
         UnknownVarFromGameLobbyWindowCtrl_Timer_1 = new Timer(1000,param1);
         UnknownVarFromGameLobbyWindowCtrl_Timer_1.addEventListener("timer",onTick);
         UnknownVarFromGameLobbyWindowCtrl_Timer_1.start();
         updateDialog(false);
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromGameLobbyWindowCtrl_Int_1 && UnknownVarFromGameLobbyWindowCtrl_Int_1 > 0)
         {
            UnknownVarFromGameLobbyWindowCtrl_Int_1--;
            HabboGamesCom.log("on tick " + UnknownVarFromGameLobbyWindowCtrl_Int_1);
            updateDialog(false);
         }
      }
      
      public function stopCountdown() : void
      {
         disposeCountdownTimer();
         updateDialog(false);
      }
      
      public function set queuePosition(param1:int) : void
      {
         UnknownVarFromGameLobbyWindowCtrl_Int_2 = param1;
      }
      
      private function updateDialog(param1:Boolean, param2:String = null) : void
      {
         var _loc16_:String = null;
         var _loc13_:* = null;
         var _loc9_:IRegionWindow = null;
         var _loc8_:IBitmapWrapperController = null;
         var _loc15_:SnowWarAnimatedWindowElement = null;
         var _loc10_:IAvatarImage_2 = null;
         var _loc4_:BitmapData = null;
         var _loc6_:Point = null;
         var _loc14_:IWindowModel = UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1.findChildByName("wait_text") as ITextWindow;
         var _loc5_:IWindowModel = UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1.findChildByName("wait_text_stroke") as ITextWindow;
         var _loc3_:IHabboLocalizationManager = UnknownVarFromGameLobbyWindowCtrl_SnowWarEngine_1.localization;
         if(UnknownVarFromGameLobbyWindowCtrl_Int_1 >= 0)
         {
            _loc16_ = "snowwar.lobby_game_start_countdown";
            _loc3_.registerParameter(_loc16_,"seconds",String(UnknownVarFromGameLobbyWindowCtrl_Int_1));
            _loc13_ = _loc16_ + " " + "%seconds%" + " " + UnknownVarFromGameLobbyWindowCtrl_Int_1;
         }
         else if(UnknownVarFromGameLobbyWindowCtrl_Int_2 >= 0)
         {
            _loc16_ = "snowwar.lobby_arena_queue_position";
            _loc3_.registerParameter(_loc16_,"position",String(UnknownVarFromGameLobbyWindowCtrl_Int_2));
            _loc13_ = _loc16_ + " " + "%position%" + " " + UnknownVarFromGameLobbyWindowCtrl_Int_2;
         }
         else
         {
            _loc13_ = _loc16_ = "snowwar.lobby_waiting_for_more_players";
         }
         var _loc11_:String = _loc3_.getLocalization(_loc16_);
         if(_loc11_)
         {
            _loc14_.caption = _loc11_;
            _loc5_.caption = _loc11_;
         }
         else
         {
            _loc14_.caption = _loc13_;
            _loc5_.caption = _loc13_;
         }
         var _loc7_:int = 0;
         var _loc12_:IItemGridWindow = UnknownVarFromGameLobbyWindowCtrl_IWindowController_1_1.findChildByName("players_grid") as IItemGridWindow;
         if(param1)
         {
            for each(var _loc17_ in UnknownVarFromGameLobbyWindowCtrl_Map_1.getValues())
            {
               _loc10_ = null;
               if(_loc17_.figure == param2 || !param2)
               {
                  _loc10_ = UnknownVarFromGameLobbyWindowCtrl_SnowWarEngine_1.avatarManager.createAvatarImage(_loc17_.figure,"h",_loc17_.gender,this);
               }
               if(_loc10_)
               {
                  _loc10_.setDirection("head",2);
                  _loc4_ = _loc10_.getCroppedImage("head");
                  _loc9_ = _loc12_.getGridItemAt(_loc7_) as IRegionWindow;
                  if(_loc9_)
                  {
                     _loc9_.toolTipCaption = _loc17_.name;
                     _loc9_.mouseThreshold = 0;
                     _loc8_ = _loc9_.findChildByName("image") as IBitmapWrapperController;
                     _loc15_ = UnknownVarFromGameLobbyWindowCtrl_Map_2.remove(_loc8_);
                     if(_loc15_)
                     {
                        _loc15_.dispose();
                     }
                     if(_loc8_.bitmap)
                     {
                        _loc8_.bitmap.dispose();
                     }
                     _loc8_.bitmap = new BitmapData(_loc8_.width,_loc8_.height,true,0);
                     _loc6_ = new Point((_loc8_.width - _loc4_.width) / 2,(_loc8_.height - _loc4_.height) / 2);
                     _loc8_.bitmap.copyPixels(_loc4_,_loc4_.rect,_loc6_);
                  }
                  _loc4_.dispose();
                  _loc10_.dispose();
               }
               _loc7_++;
            }
            while(_loc7_ < maxNumberOfPlayers)
            {
               _loc9_ = _loc12_.getGridItemAt(_loc7_) as IRegionWindow;
               _loc8_ = _loc9_.findChildByName("image") as IBitmapWrapperController;
               if(!UnknownVarFromGameLobbyWindowCtrl_Map_2.hasKey(_loc8_))
               {
                  _loc15_ = new SnowWarAnimatedWindowElement(UnknownVarFromGameLobbyWindowCtrl_SnowWarEngine_1.assets,_loc8_,"load_",8);
                  UnknownVarFromGameLobbyWindowCtrl_Map_2.add(_loc8_,_loc15_);
               }
               _loc7_++;
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         updateDialog(true,param1);
      }
      
      public function get levelName() : String
      {
         return _levelName;
      }
      
      public function get numberOfTeams() : int
      {
         return _numberOfTeams;
      }
      
      public function get numberOfPlayers() : int
      {
         return _numberOfPlayers;
      }
      
      public function get maxNumberOfPlayers() : int
      {
         return _maxNumberOfPlayers;
      }
      
      public function set levelName(param1:String) : void
      {
         _levelName = param1;
      }
      
      public function set maxNumberOfPlayers(param1:int) : void
      {
         _maxNumberOfPlayers = param1;
      }
      
      public function set numberOfTeams(param1:int) : void
      {
         _numberOfTeams = param1;
      }
      
      public function set numberOfPlayers(param1:int) : void
      {
         _numberOfPlayers = param1;
      }
      
      public function set counter(param1:int) : void
      {
         UnknownVarFromGameLobbyWindowCtrl_Int_1 = param1;
      }
   }
}


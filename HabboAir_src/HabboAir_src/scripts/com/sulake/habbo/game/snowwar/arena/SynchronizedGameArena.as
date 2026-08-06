package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.SnowWarGameStage;
   
   public class SynchronizedGameArena implements IComponentInterfaceQueue
   {
      private var _gameEngine:SnowWarEngine;
      
      private var UnknownVarFromSynchronizedGameArena_Array_1:Array;
      
      protected var _turnNumber:int;
      
      private var _subturn:int;
      
      private var UnknownVarFromSynchronizedGameArena_Int_1:int = 1;
      
      private var _currentStage:SynchronizedGameStage;
      
      private var _extension:IDefaultGameStage_2;
      
      private var _checkSums:Map;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromSynchronizedGameArena_Boolean_1:Boolean = false;
      
      private var _numberOfTeams:int;
      
      private var _teamScores:Array;
      
      public function SynchronizedGameArena()
      {
         super();
      }
      
      public function dispose() : void
      {
         _disposed = true;
         _gameEngine = null;
         UnknownVarFromSynchronizedGameArena_Array_1 = null;
         _currentStage = null;
         if(_extension != null)
         {
            _extension.dispose();
            _extension = null;
         }
         _checkSums = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function initialize(param1:SnowWarEngine, param2:int) : void
      {
         _gameEngine = param1;
         _currentStage = new SnowWarGameStage();
         _checkSums = new Map();
         UnknownVarFromSynchronizedGameArena_Array_1 = [];
         _numberOfTeams = param2;
         _turnNumber = 0;
         _subturn = 0;
         UnknownVarFromSynchronizedGameArena_Array_1[_turnNumber] = initEmptyEventQueue();
         _checkSums = new Map();
         resetTeamScores();
      }
      
      public function get gameEngine() : SnowWarEngine
      {
         return _gameEngine;
      }
      
      public function pulse() : void
      {
         gamePulse();
      }
      
      public function gamePulse() : void
      {
         var _loc1_:Array = null;
         var _loc4_:ISynchronizedGameEvent = null;
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Turn " + _turnNumber + " subturn " + (_subturn + 1) + "/" + getNumberOfSubTurns());
         }
         var _loc3_:SynchronizedGameStage = SynchronizedGameStage(getCurrentStage());
         var _loc2_:Array = UnknownVarFromSynchronizedGameArena_Array_1[_turnNumber];
         if(_loc2_)
         {
            _loc1_ = _loc2_[_subturn];
            while(_loc1_.length > 0)
            {
               _loc4_ = _loc1_.shift() as ISynchronizedGameEvent;
               if(HabboGamesCom.logEnabled)
               {
                  HabboGamesCom.log("GameInstance::gameTurn: applying event " + _loc4_ + " turn " + _turnNumber + " subturn " + (_subturn + 1) + "/" + getNumberOfSubTurns());
               }
               _loc4_.apply(_loc3_);
            }
         }
         if(!UnknownVarFromSynchronizedGameArena_Boolean_1)
         {
            _loc3_.subturn();
         }
         if(_subturn >= getNumberOfSubTurns() - 1)
         {
            if(_turnNumber % UnknownVarFromSynchronizedGameArena_Int_1 == 0)
            {
               _checkSums[_turnNumber] = getCurrentStage().calculateChecksum(_turnNumber);
            }
            _turnNumber++;
            UnknownVarFromSynchronizedGameArena_Boolean_1 = false;
            if(HabboGamesCom.logEnabled)
            {
               HabboGamesCom.log("Turn:" + _turnNumber);
            }
         }
         _subturn++;
         if(_subturn >= getNumberOfSubTurns())
         {
            _subturn = 0;
         }
      }
      
      public function addGameEvent(param1:int, param2:int, param3:ISynchronizedGameEvent) : void
      {
         var _loc4_:Array = UnknownVarFromSynchronizedGameArena_Array_1[param1];
         if(_loc4_ == null)
         {
            _loc4_ = initEmptyEventQueue();
            UnknownVarFromSynchronizedGameArena_Array_1[param1] = _loc4_;
         }
         _loc4_[param2].push(param3);
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Add game event: " + param3 + " (subturn/turn): " + param2 + "/" + param1);
         }
      }
      
      public function debugEventQueue() : void
      {
         var _loc5_:int = 0;
         var _loc1_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc2_:String = "";
         _loc5_ = 0;
         while(_loc5_ < UnknownVarFromSynchronizedGameArena_Array_1.length)
         {
            _loc1_ = UnknownVarFromSynchronizedGameArena_Array_1[_loc5_];
            if(_loc1_ != null)
            {
               _loc6_ = 0;
               while(_loc6_ < getNumberOfSubTurns())
               {
                  _loc4_ = _loc1_[_loc6_];
                  if(_loc4_.length != 0)
                  {
                     _loc2_ += _loc5_ + " (" + _loc6_ + ") : ";
                     for each(var _loc3_ in _loc4_)
                     {
                        _loc2_ += _loc3_;
                     }
                     _loc2_ += "\n";
                  }
                  _loc6_++;
               }
            }
            _loc5_++;
         }
         HabboGamesCom.log(_loc2_);
      }
      
      public function getNumberOfSubTurns() : int
      {
         return this.getExtension().getNumberOfSubTurns();
      }
      
      public function getTurnNumber() : int
      {
         return _turnNumber;
      }
      
      public function get subturn() : int
      {
         return _subturn;
      }
      
      public function getCurrentStage() : SynchronizedGameStage
      {
         return _currentStage;
      }
      
      public function getExtension() : IDefaultGameStage_2
      {
         return _extension;
      }
      
      public function setExtension(param1:IDefaultGameStage_2) : void
      {
         _extension = param1;
         param1.gameArena = this;
      }
      
      public function getCheckSum(param1:int) : int
      {
         return _checkSums[param1];
      }
      
      public function seekToTurn(param1:int, param2:int) : void
      {
         _turnNumber = param1;
         _subturn = 0;
         _checkSums[param1] = param2;
         UnknownVarFromSynchronizedGameArena_Array_1 = [];
         UnknownVarFromSynchronizedGameArena_Array_1[_turnNumber] = initEmptyEventQueue();
         UnknownVarFromSynchronizedGameArena_Boolean_1 = true;
      }
      
      private function initEmptyEventQueue() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < getNumberOfSubTurns())
         {
            _loc2_[_loc1_] = [];
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get numberOfTeams() : int
      {
         return _numberOfTeams;
      }
      
      private function resetTeamScores() : void
      {
         var _loc1_:int = 0;
         _teamScores = [];
         _loc1_ = 0;
         while(_loc1_ < _numberOfTeams)
         {
            _teamScores[_loc1_] = 0;
            _loc1_++;
         }
      }
      
      public function addTeamScore(param1:int, param2:int) : void
      {
         if(param1 > 0 && param1 <= _numberOfTeams)
         {
            var _loc3_:* = param1 - 1;
            var _loc4_:* = _teamScores[_loc3_] + param2;
            _teamScores[_loc3_] = _loc4_;
         }
      }
      
      public function getTeamScores() : Array
      {
         return _teamScores;
      }
   }
}


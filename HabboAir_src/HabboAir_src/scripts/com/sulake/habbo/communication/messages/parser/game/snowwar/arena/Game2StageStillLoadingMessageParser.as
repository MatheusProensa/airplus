package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageStillLoadingMessageParser implements IMessageParser
   {
      private var _percentage:int;
      
      private var _finishedPlayers:Array;
      
      public function Game2StageStillLoadingMessageParser()
      {
         super();
      }
      
      public function get percentage() : int
      {
         return _percentage;
      }
      
      public function get finishedPlayers() : Array
      {
         return _finishedPlayers;
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _percentage = param1.readInteger();
         _finishedPlayers = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _finishedPlayers.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
   }
}


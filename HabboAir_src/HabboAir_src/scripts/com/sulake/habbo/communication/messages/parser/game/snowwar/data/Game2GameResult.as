package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class Game2GameResult
   {
      public static const UnknownConstFromGame2GameResult_Int_1:int = 0;
      
      public static const UnknownConstFromGame2GameResult_Int_2:int = 1;
      
      public static const UnknownConstFromGame2GameResult_Int_3:int = 2;
      
      private var _isDeathMatch:Boolean;
      
      private var _resultType:int;
      
      private var _winnerId:int;
      
      public function Game2GameResult(param1:IMessageDataWrapper)
      {
         super();
         _isDeathMatch = param1.readBoolean();
         _resultType = param1.readInteger();
         _winnerId = param1.readInteger();
      }
      
      public function get isDeathMatch() : Boolean
      {
         return _isDeathMatch;
      }
      
      public function get resultType() : int
      {
         return _resultType;
      }
      
      public function get winnerId() : int
      {
         return _winnerId;
      }
   }
}


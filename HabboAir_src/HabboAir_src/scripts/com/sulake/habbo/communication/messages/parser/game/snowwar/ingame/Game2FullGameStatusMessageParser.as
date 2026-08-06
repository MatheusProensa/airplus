package com.sulake.habbo.communication.messages.parser.game.snowwar.ingame
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FullGameStatusData;
   
   [SecureSWF(rename="true")]
   public class Game2FullGameStatusMessageParser implements IMessageParser
   {
      private var _fullStatus:FullGameStatusData;
      
      public function Game2FullGameStatusMessageParser()
      {
         super();
      }
      
      public function get fullStatus() : FullGameStatusData
      {
         return _fullStatus;
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _fullStatus = new FullGameStatusData(param1);
         return true;
      }
   }
}


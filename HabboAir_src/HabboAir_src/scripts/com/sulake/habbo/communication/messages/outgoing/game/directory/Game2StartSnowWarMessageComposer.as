package com.sulake.habbo.communication.messages.outgoing.game.directory
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class Game2StartSnowWarMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function Game2StartSnowWarMessageComposer(param1:String)
      {
         super();
         _messageArray.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = [];
      }
   }
}


package com.sulake.habbo.communication.messages.outgoing.game.directory
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2CheckGameDirectoryStatusMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function Game2CheckGameDirectoryStatusMessageComposer()
      {
         super();
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


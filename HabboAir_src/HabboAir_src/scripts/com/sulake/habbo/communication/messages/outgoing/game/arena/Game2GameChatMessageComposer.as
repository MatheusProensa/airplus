package com.sulake.habbo.communication.messages.outgoing.game.arena
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2GameChatMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromGame2GameChatMessageComposer_String_1:String;
      
      public function Game2GameChatMessageComposer(param1:String)
      {
         super();
         UnknownVarFromGame2GameChatMessageComposer_String_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGame2GameChatMessageComposer_String_1];
      }
      
      public function dispose() : void
      {
         UnknownVarFromGame2GameChatMessageComposer_String_1 = null;
      }
   }
}


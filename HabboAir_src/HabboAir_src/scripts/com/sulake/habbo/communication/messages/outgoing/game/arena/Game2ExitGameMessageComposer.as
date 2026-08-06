package com.sulake.habbo.communication.messages.outgoing.game.arena
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2ExitGameMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromGame2ExitGameMessageComposer_Boolean_1:Boolean;
      
      public function Game2ExitGameMessageComposer(param1:Boolean = true)
      {
         super();
         UnknownVarFromGame2ExitGameMessageComposer_Boolean_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGame2ExitGameMessageComposer_Boolean_1];
      }
      
      public function dispose() : void
      {
      }
   }
}


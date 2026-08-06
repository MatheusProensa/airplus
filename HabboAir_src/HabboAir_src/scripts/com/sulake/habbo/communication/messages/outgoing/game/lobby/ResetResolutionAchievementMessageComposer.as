package com.sulake.habbo.communication.messages.outgoing.game.lobby
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ResetResolutionAchievementMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function ResetResolutionAchievementMessageComposer(param1:int)
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


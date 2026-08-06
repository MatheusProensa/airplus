package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class MoveWallItemMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function MoveWallItemMessageComposer(param1:int, param2:int, param3:String)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param3);
      }
      
      public function dispose() : void
      {
         _messageArray = null;
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
   }
}


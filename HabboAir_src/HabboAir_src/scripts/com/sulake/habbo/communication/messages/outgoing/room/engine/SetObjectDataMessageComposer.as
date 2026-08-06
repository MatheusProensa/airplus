package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class SetObjectDataMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function SetObjectDataMessageComposer(param1:int, param2:Map)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2.length * 2);
         for each(var _loc3_ in param2.getKeys())
         {
            _messageArray.push(_loc3_);
            _messageArray.push(param2.getValue(_loc3_));
         }
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


package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class CreateGuildMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function CreateGuildMessageComposer(param1:String, param2:String, param3:int, param4:int, param5:int, param6:Array)
      {
         var _loc7_:int = 0;
         _messageArray = [];
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3);
         _messageArray.push(param4);
         _messageArray.push(param5);
         _messageArray.push(param6.length);
         _loc7_ = 0;
         while(_loc7_ < param6.length)
         {
            _messageArray.push(int(param6[_loc7_]));
            _loc7_++;
         }
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = null;
      }
   }
}


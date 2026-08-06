package com.sulake.habbo.communication.messages.outgoing.poll
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PollAnswerComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function PollAnswerComposer(param1:int, param2:int, param3:Array)
      {
         var _loc4_:int = 0;
         super();
         _messageArray = [param1,param2];
         _messageArray.push(param3.length);
         _loc4_ = 0;
         while(_loc4_ < param3.length)
         {
            _messageArray.push(String(param3[_loc4_]));
            _loc4_++;
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


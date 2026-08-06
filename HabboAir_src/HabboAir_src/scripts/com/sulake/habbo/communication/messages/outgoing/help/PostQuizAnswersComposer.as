package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PostQuizAnswersComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function PostQuizAnswersComposer(param1:String, param2:Array)
      {
         var _loc3_:int = 0;
         _messageArray = [];
         super();
         _messageArray.push(param1);
         _messageArray.push(param2.length);
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            _messageArray.push(param2[_loc3_]);
            _loc3_++;
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


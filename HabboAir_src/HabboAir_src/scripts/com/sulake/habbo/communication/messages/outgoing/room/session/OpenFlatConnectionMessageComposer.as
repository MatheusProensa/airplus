package com.sulake.habbo.communication.messages.outgoing.room.session
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class OpenFlatConnectionMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function OpenFlatConnectionMessageComposer(param1:int, param2:String = "", param3:int = -1)
      {
         super();
         _messageArray = [param1,param2,param3];
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


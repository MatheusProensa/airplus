package com.sulake.habbo.communication.messages.outgoing.newnavigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class NavigatorSetSearchCodeViewModeMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function NavigatorSetSearchCodeViewModeMessageComposer(param1:String, param2:int)
      {
         super();
         _messageArray = [param1,param2];
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


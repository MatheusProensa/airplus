package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class WiredGetAllVariablesDiffsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var _messageArray:Array;
      
      public function WiredGetAllVariablesDiffsMessageComposer(param1:Dictionary)
      {
         var _loc5_:int = 0;
         _messageArray = [];
         super();
         if(param1 == null)
         {
            _messageArray.push(0);
            return;
         }
         var _loc2_:int = 0;
         for(var _loc4_ in param1)
         {
            _loc2_ += 1;
         }
         _messageArray.push(_loc2_);
         for(var _loc3_ in param1)
         {
            _loc5_ = int(param1[_loc3_]);
            _messageArray.push(_loc3_);
            _messageArray.push(_loc5_);
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
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UpdateRoomCategoryAndTradeSettingsComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var _messageArray:Array = [];
      
      public function UpdateRoomCategoryAndTradeSettingsComposer(param1:int, param2:int, param3:int)
      {
         super();
         _messageArray = [param1,param2,param3];
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
         return _messageArray == null;
      }
   }
}


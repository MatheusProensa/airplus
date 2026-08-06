package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UpdateRoomFilterMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      public static var UnknownVarFromUpdateRoomFilterMessageComposer_Boolean_1:Boolean = true;
      
      public static var UnknownVarFromUpdateRoomFilterMessageComposer_Boolean_2:Boolean = false;
      
      private var _messageArray:Array = [];
      
      public function UpdateRoomFilterMessageComposer(param1:int, param2:Boolean, param3:String)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3);
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


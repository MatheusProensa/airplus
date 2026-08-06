package com.sulake.habbo.communication.messages.outgoing.room.layout
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class UpdateFloorPropertiesMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function UpdateFloorPropertiesMessageComposer(param1:String, param2:int = -1, param3:int = -1, param4:int = -1, param5:int = -1, param6:int = -1, param7:int = -1)
      {
         super();
         if(param2 == -1 && param3 == -1 && param4 == -1 && param5 == -1 && param6 == -1)
         {
            _messageArray = [param1];
         }
         else if(param7 == -1)
         {
            _messageArray = [param1,param2,param3,param4,param5,param6];
         }
         else
         {
            _messageArray = [param1,param2,param3,param4,param5,param6,param7];
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


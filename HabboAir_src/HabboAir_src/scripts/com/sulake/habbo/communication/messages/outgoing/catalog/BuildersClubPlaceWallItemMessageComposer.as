package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class BuildersClubPlaceWallItemMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function BuildersClubPlaceWallItemMessageComposer(param1:int, param2:int, param3:String, param4:String, param5:Boolean = false)
      {
         super();
         _messageArray = [param1,param2,param3,param4,param5];
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


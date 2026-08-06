package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CallForHelpFromPhotoMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCallForHelpFromPhotoMessageComposer_Array_1:Array = [];
      
      public function CallForHelpFromPhotoMessageComposer(param1:String, param2:int, param3:int, param4:int, param5:int, param6:String, param7:String)
      {
         super();
         this.UnknownVarFromCallForHelpFromPhotoMessageComposer_Array_1 = [param1,param2,param3,param4,param5,param6,param7];
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCallForHelpFromPhotoMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCallForHelpFromPhotoMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


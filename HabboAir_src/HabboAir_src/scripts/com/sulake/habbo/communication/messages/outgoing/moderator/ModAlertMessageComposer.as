package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ModAlertMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromModAlertMessageComposer_Array_1:Array = [];
      
      public function ModAlertMessageComposer(param1:int, param2:String, param3:int, param4:int)
      {
         super();
         this.UnknownVarFromModAlertMessageComposer_Array_1.push(param1);
         this.UnknownVarFromModAlertMessageComposer_Array_1.push(param2);
         this.UnknownVarFromModAlertMessageComposer_Array_1.push(param3);
         if(param4 != -1)
         {
            this.UnknownVarFromModAlertMessageComposer_Array_1.push(param4);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromModAlertMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromModAlertMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


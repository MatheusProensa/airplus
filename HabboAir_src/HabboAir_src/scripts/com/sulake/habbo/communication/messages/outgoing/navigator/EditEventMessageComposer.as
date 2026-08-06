package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class EditEventMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromEditEventMessageComposer_Array_1:Array = [];
      
      public function EditEventMessageComposer(param1:int, param2:String, param3:String)
      {
         super();
         this.UnknownVarFromEditEventMessageComposer_Array_1.push(param1);
         this.UnknownVarFromEditEventMessageComposer_Array_1.push(param2);
         this.UnknownVarFromEditEventMessageComposer_Array_1.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromEditEventMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromEditEventMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


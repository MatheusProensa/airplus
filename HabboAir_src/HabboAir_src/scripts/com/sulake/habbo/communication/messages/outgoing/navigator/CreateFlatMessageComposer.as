package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CreateFlatMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCreateFlatMessageComposer_Array_1:Array = [];
      
      public function CreateFlatMessageComposer(param1:String, param2:String, param3:String, param4:int, param5:int, param6:int)
      {
         super();
         this.UnknownVarFromCreateFlatMessageComposer_Array_1.push(param1);
         this.UnknownVarFromCreateFlatMessageComposer_Array_1.push(param2);
         this.UnknownVarFromCreateFlatMessageComposer_Array_1.push(param3);
         this.UnknownVarFromCreateFlatMessageComposer_Array_1.push(param4);
         this.UnknownVarFromCreateFlatMessageComposer_Array_1.push(param5);
         this.UnknownVarFromCreateFlatMessageComposer_Array_1.push(param6);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCreateFlatMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCreateFlatMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


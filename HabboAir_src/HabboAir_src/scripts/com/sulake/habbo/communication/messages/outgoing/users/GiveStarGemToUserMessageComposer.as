package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GiveStarGemToUserMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGiveStarGemToUserMessageComposer_Array_1:Array = [];
      
      public function GiveStarGemToUserMessageComposer(param1:int, param2:int = 1)
      {
         super();
         this.UnknownVarFromGiveStarGemToUserMessageComposer_Array_1.push(param1);
         this.UnknownVarFromGiveStarGemToUserMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGiveStarGemToUserMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGiveStarGemToUserMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


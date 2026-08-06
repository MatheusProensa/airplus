package com.sulake.habbo.communication.messages.outgoing.nux
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceGetGiftsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromNewUserExperienceGetGiftsMessageComposer_Array_1:Array = [];
      
      public function NewUserExperienceGetGiftsMessageComposer(param1:Vector.<NewUserExperienceGetGiftsSelection>)
      {
         super();
         UnknownVarFromNewUserExperienceGetGiftsMessageComposer_Array_1.push(param1.length * 3);
         for each(var _loc2_ in param1)
         {
            UnknownVarFromNewUserExperienceGetGiftsMessageComposer_Array_1.push(_loc2_.dayIndex);
            UnknownVarFromNewUserExperienceGetGiftsMessageComposer_Array_1.push(_loc2_.stepIndex);
            UnknownVarFromNewUserExperienceGetGiftsMessageComposer_Array_1.push(_loc2_.giftIndex);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromNewUserExperienceGetGiftsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromNewUserExperienceGetGiftsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


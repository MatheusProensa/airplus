package com.sulake.habbo.communication.messages.outgoing.nux
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceScriptProceedComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromNewUserExperienceScriptProceedComposer_Array_1:Array = [];
      
      public function NewUserExperienceScriptProceedComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromNewUserExperienceScriptProceedComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromNewUserExperienceScriptProceedComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


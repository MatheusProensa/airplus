package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class SetChestPreferencesMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromSetChestPreferencesMessageComposer_Array_1:Array = [];
      
      public function SetChestPreferencesMessageComposer(param1:int, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:int, param7:int, param8:int, param9:Boolean)
      {
         super();
         UnknownVarFromSetChestPreferencesMessageComposer_Array_1.push(param1);
         UnknownVarFromSetChestPreferencesMessageComposer_Array_1.push(param2);
         UnknownVarFromSetChestPreferencesMessageComposer_Array_1.push(param3);
         UnknownVarFromSetChestPreferencesMessageComposer_Array_1.push(param4);
         UnknownVarFromSetChestPreferencesMessageComposer_Array_1.push(param5);
         UnknownVarFromSetChestPreferencesMessageComposer_Array_1.push(param6);
         UnknownVarFromSetChestPreferencesMessageComposer_Array_1.push(param7);
         UnknownVarFromSetChestPreferencesMessageComposer_Array_1.push(param8);
         UnknownVarFromSetChestPreferencesMessageComposer_Array_1.push(param9);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromSetChestPreferencesMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromSetChestPreferencesMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


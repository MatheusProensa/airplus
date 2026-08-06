package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class SetChestNotificationPreferencesMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromSetChestNotificationPreferencesMessageComposer_Array_1:Array = [];
      
      public function SetChestNotificationPreferencesMessageComposer(param1:int, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean)
      {
         super();
         UnknownVarFromSetChestNotificationPreferencesMessageComposer_Array_1.push(param1);
         UnknownVarFromSetChestNotificationPreferencesMessageComposer_Array_1.push(param2);
         UnknownVarFromSetChestNotificationPreferencesMessageComposer_Array_1.push(param3);
         UnknownVarFromSetChestNotificationPreferencesMessageComposer_Array_1.push(param4);
         UnknownVarFromSetChestNotificationPreferencesMessageComposer_Array_1.push(param5);
         UnknownVarFromSetChestNotificationPreferencesMessageComposer_Array_1.push(param6);
         UnknownVarFromSetChestNotificationPreferencesMessageComposer_Array_1.push(param7);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromSetChestNotificationPreferencesMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromSetChestNotificationPreferencesMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


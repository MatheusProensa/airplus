package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredSetPreferencesMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredSetPreferencesMessageComposer_Array_1:Array = [];
      
      public function WiredSetPreferencesMessageComposer(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:String)
      {
         super();
         UnknownVarFromWiredSetPreferencesMessageComposer_Array_1.push(param1);
         UnknownVarFromWiredSetPreferencesMessageComposer_Array_1.push(param2);
         UnknownVarFromWiredSetPreferencesMessageComposer_Array_1.push(param3);
         UnknownVarFromWiredSetPreferencesMessageComposer_Array_1.push(0);
         UnknownVarFromWiredSetPreferencesMessageComposer_Array_1.push(param4);
         UnknownVarFromWiredSetPreferencesMessageComposer_Array_1.push(param5);
         UnknownVarFromWiredSetPreferencesMessageComposer_Array_1.push(param6);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredSetPreferencesMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredSetPreferencesMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredSetObjectVariableValueMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      public static const UnknownConstFromWiredSetObjectVariableValueMessageComposer_Int_1:int = 0;
      
      public static const UnknownConstFromWiredSetObjectVariableValueMessageComposer_Int_2:int = 1;
      
      public static const UnknownConstFromWiredSetObjectVariableValueMessageComposer_Int_3:int = 2;
      
      private var UnknownVarFromWiredSetObjectVariableValueMessageComposer_Array_1:Array = [];
      
      public function WiredSetObjectVariableValueMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:int)
      {
         super();
         UnknownVarFromWiredSetObjectVariableValueMessageComposer_Array_1.push(param1);
         UnknownVarFromWiredSetObjectVariableValueMessageComposer_Array_1.push(param2);
         UnknownVarFromWiredSetObjectVariableValueMessageComposer_Array_1.push(param3);
         UnknownVarFromWiredSetObjectVariableValueMessageComposer_Array_1.push(param4);
         UnknownVarFromWiredSetObjectVariableValueMessageComposer_Array_1.push(param5);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredSetObjectVariableValueMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredSetObjectVariableValueMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


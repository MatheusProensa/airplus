package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetMannequinNameComposer implements IMessageComposer
   {
      private var UnknownVarFromSetMannequinNameComposer_Int_1:int;
      
      private var _name:String;
      
      public function SetMannequinNameComposer(param1:int, param2:String)
      {
         super();
         UnknownVarFromSetMannequinNameComposer_Int_1 = param1;
         _name = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromSetMannequinNameComposer_Int_1,_name];
      }
      
      public function dispose() : void
      {
      }
   }
}


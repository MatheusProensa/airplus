package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetMannequinFigureComposer implements IMessageComposer
   {
      private var UnknownVarFromSetMannequinFigureComposer_Int_1:int;
      
      public function SetMannequinFigureComposer(param1:int)
      {
         super();
         UnknownVarFromSetMannequinFigureComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromSetMannequinFigureComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}


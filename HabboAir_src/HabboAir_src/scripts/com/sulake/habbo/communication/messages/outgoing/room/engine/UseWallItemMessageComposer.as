package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class UseWallItemMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromUseWallItemMessageComposer_Int_1:int;
      
      private var UnknownVarFromUseWallItemMessageComposer_Int_2:int = 0;
      
      public function UseWallItemMessageComposer(param1:int, param2:int = 0)
      {
         super();
         UnknownVarFromUseWallItemMessageComposer_Int_1 = param1;
         UnknownVarFromUseWallItemMessageComposer_Int_2 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromUseWallItemMessageComposer_Int_1,UnknownVarFromUseWallItemMessageComposer_Int_2];
      }
   }
}


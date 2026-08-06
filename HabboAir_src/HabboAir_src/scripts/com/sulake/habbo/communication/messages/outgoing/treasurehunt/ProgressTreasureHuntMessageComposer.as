package com.sulake.habbo.communication.messages.outgoing.treasurehunt
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ProgressTreasureHuntMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromProgressTreasureHuntMessageComposer_String_1:String;
      
      private var UnknownVarFromProgressTreasureHuntMessageComposer_String_2:String;
      
      public function ProgressTreasureHuntMessageComposer(param1:String, param2:String)
      {
         super();
         UnknownVarFromProgressTreasureHuntMessageComposer_String_1 = param1;
         UnknownVarFromProgressTreasureHuntMessageComposer_String_2 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromProgressTreasureHuntMessageComposer_String_1,UnknownVarFromProgressTreasureHuntMessageComposer_String_2];
      }
   }
}


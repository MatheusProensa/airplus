package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AddSpamWallPostItMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromAddSpamWallPostItMessageComposer_Int_1:int;
      
      private var UnknownVarFromAddSpamWallPostItMessageComposer_String_1:String;
      
      private var UnknownVarFromAddSpamWallPostItMessageComposer_String_2:String;
      
      private var UnknownVarFromAddSpamWallPostItMessageComposer_String_3:String;
      
      public function AddSpamWallPostItMessageComposer(param1:int, param2:String, param3:String, param4:String)
      {
         super();
         UnknownVarFromAddSpamWallPostItMessageComposer_Int_1 = param1;
         UnknownVarFromAddSpamWallPostItMessageComposer_String_1 = param2;
         UnknownVarFromAddSpamWallPostItMessageComposer_String_2 = param4;
         UnknownVarFromAddSpamWallPostItMessageComposer_String_3 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromAddSpamWallPostItMessageComposer_Int_1,UnknownVarFromAddSpamWallPostItMessageComposer_String_1,UnknownVarFromAddSpamWallPostItMessageComposer_String_3,UnknownVarFromAddSpamWallPostItMessageComposer_String_2];
      }
   }
}


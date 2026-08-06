package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PlacePostItMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromPlacePostItMessageComposer_Int_1:int;
      
      private var UnknownVarFromPlacePostItMessageComposer_String_1:String;
      
      public function PlacePostItMessageComposer(param1:int, param2:String)
      {
         super();
         UnknownVarFromPlacePostItMessageComposer_Int_1 = param1;
         UnknownVarFromPlacePostItMessageComposer_String_1 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromPlacePostItMessageComposer_Int_1,UnknownVarFromPlacePostItMessageComposer_String_1];
      }
   }
}


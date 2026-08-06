package com.sulake.habbo.communication.messages.outgoing.room.chat
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ShoutMessageComposer implements IMessageComposer
   {
      private var _text:String;
      
      private var UnknownVarFromShoutMessageComposer_Int_1:int = 0;
      
      public function ShoutMessageComposer(param1:String, param2:int = 0)
      {
         super();
         _text = param1;
         UnknownVarFromShoutMessageComposer_Int_1 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [_text,UnknownVarFromShoutMessageComposer_Int_1];
      }
   }
}


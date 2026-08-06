package com.sulake.habbo.communication.messages.outgoing.room.chat
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class WhisperMessageComposer implements IMessageComposer
   {
      private var _text:String;
      
      private var _recipientName:String;
      
      private var UnknownVarFromWhisperMessageComposer_Int_1:int = 0;
      
      public function WhisperMessageComposer(param1:String, param2:String, param3:int = 0)
      {
         super();
         _recipientName = param1;
         _text = param2;
         UnknownVarFromWhisperMessageComposer_Int_1 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [_recipientName + " " + _text,UnknownVarFromWhisperMessageComposer_Int_1];
      }
   }
}


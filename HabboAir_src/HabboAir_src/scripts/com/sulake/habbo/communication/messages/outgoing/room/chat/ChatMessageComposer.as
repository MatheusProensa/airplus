package com.sulake.habbo.communication.messages.outgoing.room.chat
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ChatMessageComposer implements IMessageComposer
   {
      private var _text:String;
      
      private var UnknownVarFromChatMessageComposer_Int_1:int = 0;
      
      private var UnknownVarFromChatMessageComposer_Int_2:int = 0;
      
      public function ChatMessageComposer(param1:String, param2:int = 0, param3:int = -1)
      {
         super();
         _text = param1;
         UnknownVarFromChatMessageComposer_Int_2 = param2;
         UnknownVarFromChatMessageComposer_Int_1 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [_text,UnknownVarFromChatMessageComposer_Int_2,UnknownVarFromChatMessageComposer_Int_1];
      }
   }
}


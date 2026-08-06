package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class UniqueIDMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromUniqueIDMessageComposer_String_1:String;
      
      private var UnknownVarFromUniqueIDMessageComposer_String_2:String;
      
      private var UnknownVarFromUniqueIDMessageComposer_String_3:String;
      
      public function UniqueIDMessageComposer(param1:String, param2:String, param3:String)
      {
         super();
         UnknownVarFromUniqueIDMessageComposer_String_1 = param1;
         UnknownVarFromUniqueIDMessageComposer_String_2 = param2;
         UnknownVarFromUniqueIDMessageComposer_String_3 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromUniqueIDMessageComposer_String_1,UnknownVarFromUniqueIDMessageComposer_String_2,UnknownVarFromUniqueIDMessageComposer_String_3];
      }
   }
}


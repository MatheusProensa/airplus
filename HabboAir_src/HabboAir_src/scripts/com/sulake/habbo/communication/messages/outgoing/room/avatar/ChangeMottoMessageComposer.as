package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ChangeMottoMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromChangeMottoMessageComposer_String_1:String;
      
      public function ChangeMottoMessageComposer(param1:String)
      {
         super();
         UnknownVarFromChangeMottoMessageComposer_String_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromChangeMottoMessageComposer_String_1];
      }
   }
}


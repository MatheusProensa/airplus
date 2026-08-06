package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AssignRightsMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromAssignRightsMessageComposer_Int_1:int;
      
      public function AssignRightsMessageComposer(param1:int)
      {
         super();
         UnknownVarFromAssignRightsMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromAssignRightsMessageComposer_Int_1];
      }
   }
}


package com.sulake.habbo.communication.messages.outgoing.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetIsBadgeRequestFulfilledComposer implements IMessageComposer
   {
      private var UnknownVarFromGetIsBadgeRequestFulfilledComposer_Array_1:Array = [];
      
      public function GetIsBadgeRequestFulfilledComposer(param1:String)
      {
         super();
         this.UnknownVarFromGetIsBadgeRequestFulfilledComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetIsBadgeRequestFulfilledComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetIsBadgeRequestFulfilledComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


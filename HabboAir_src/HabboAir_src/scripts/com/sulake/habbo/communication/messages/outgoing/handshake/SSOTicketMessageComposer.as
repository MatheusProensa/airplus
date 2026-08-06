package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class SSOTicketMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromSSOTicketMessageComposer_Array_1:Array;
      
      public function SSOTicketMessageComposer(param1:String)
      {
         super();
         UnknownVarFromSSOTicketMessageComposer_Array_1 = [];
         UnknownVarFromSSOTicketMessageComposer_Array_1.push(param1);
         UnknownVarFromSSOTicketMessageComposer_Array_1.push(getTimer());
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return UnknownVarFromSSOTicketMessageComposer_Array_1;
      }
   }
}


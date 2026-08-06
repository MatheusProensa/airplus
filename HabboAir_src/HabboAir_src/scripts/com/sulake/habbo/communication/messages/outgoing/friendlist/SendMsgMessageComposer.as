package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class SendMsgMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromSendMsgMessageComposer_Array_1:Array = [];
      
      public function SendMsgMessageComposer(param1:int, param2:String, param3:int)
      {
         super();
         this.UnknownVarFromSendMsgMessageComposer_Array_1.push(param1);
         this.UnknownVarFromSendMsgMessageComposer_Array_1.push(param2);
         this.UnknownVarFromSendMsgMessageComposer_Array_1.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromSendMsgMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromSendMsgMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


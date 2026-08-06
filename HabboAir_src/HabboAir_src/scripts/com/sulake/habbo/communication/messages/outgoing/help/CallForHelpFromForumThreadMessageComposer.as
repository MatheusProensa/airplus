package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CallForHelpFromForumThreadMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCallForHelpFromForumThreadMessageComposer_Array_1:Array = [];
      
      public function CallForHelpFromForumThreadMessageComposer(param1:int, param2:int, param3:int, param4:String, param5:String, param6:String)
      {
         super();
         this.UnknownVarFromCallForHelpFromForumThreadMessageComposer_Array_1 = [param1,param2,param3,param4,param5,param6];
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCallForHelpFromForumThreadMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCallForHelpFromForumThreadMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


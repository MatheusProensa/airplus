package com.sulake.habbo.communication.messages.outgoing.campaign
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class OpenCampaignCalendarDoorComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromOpenCampaignCalendarDoorComposer_Array_1:Array = [];
      
      public function OpenCampaignCalendarDoorComposer(param1:String, param2:int)
      {
         super();
         UnknownVarFromOpenCampaignCalendarDoorComposer_Array_1.push(param1);
         UnknownVarFromOpenCampaignCalendarDoorComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromOpenCampaignCalendarDoorComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromOpenCampaignCalendarDoorComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


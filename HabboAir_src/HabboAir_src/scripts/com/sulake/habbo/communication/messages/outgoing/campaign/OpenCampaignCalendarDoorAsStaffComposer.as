package com.sulake.habbo.communication.messages.outgoing.campaign
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class OpenCampaignCalendarDoorAsStaffComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromOpenCampaignCalendarDoorAsStaffComposer_Array_1:Array = [];
      
      public function OpenCampaignCalendarDoorAsStaffComposer(param1:String, param2:int)
      {
         super();
         UnknownVarFromOpenCampaignCalendarDoorAsStaffComposer_Array_1.push(param1);
         UnknownVarFromOpenCampaignCalendarDoorAsStaffComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromOpenCampaignCalendarDoorAsStaffComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromOpenCampaignCalendarDoorAsStaffComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


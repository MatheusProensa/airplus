package com.sulake.habbo.communication.messages.outgoing.marketplace
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetMarketplaceItemStatsComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      public static const UnknownConstFromGetMarketplaceItemStatsComposer_Int_1:int = 1;
      
      public static const UnknownConstFromGetMarketplaceItemStatsComposer_Int_2:int = 2;
      
      public static const UnknownConstFromGetMarketplaceItemStatsComposer_Int_3:int = 3;
      
      private var UnknownVarFromGetMarketplaceItemStatsComposer_Array_1:Array = [];
      
      public function GetMarketplaceItemStatsComposer(param1:int, param2:int, param3:String = null)
      {
         super();
         UnknownVarFromGetMarketplaceItemStatsComposer_Array_1.push(param1);
         UnknownVarFromGetMarketplaceItemStatsComposer_Array_1.push(param2);
         if(param3 != null && param3.length > 0)
         {
            UnknownVarFromGetMarketplaceItemStatsComposer_Array_1.push(param3);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetMarketplaceItemStatsComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetMarketplaceItemStatsComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}


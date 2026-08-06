package com.sulake.habbo.communication.messages.outgoing.recycler
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetRecyclerPrizesMessageComposer implements IMessageComposer
   {
      public function GetRecyclerPrizesMessageComposer()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
   }
}


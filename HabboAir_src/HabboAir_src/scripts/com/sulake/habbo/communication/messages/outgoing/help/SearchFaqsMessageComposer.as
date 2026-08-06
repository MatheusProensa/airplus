package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SearchFaqsMessageComposer implements IMessageComposer
   {
      private var _searchString:String;
      
      public function SearchFaqsMessageComposer(param1:String)
      {
         super();
         _searchString = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [_searchString];
      }
      
      public function dispose() : void
      {
      }
   }
}


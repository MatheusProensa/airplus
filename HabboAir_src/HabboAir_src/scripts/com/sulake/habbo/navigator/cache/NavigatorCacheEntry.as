package com.sulake.habbo.navigator.cache
{
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultContainer;
   
   public class NavigatorCacheEntry
   {
      private var _key:String;
      
      private var _payload:SearchResultContainer;
      
      private var UnknownVarFromNavigatorCacheEntry_Number_1:Number;
      
      private var UnknownVarFromNavigatorCacheEntry_Number_2:Number;
      
      public function NavigatorCacheEntry(param1:String, param2:SearchResultContainer, param3:Number, param4:Number)
      {
         super();
         _key = param1;
         _payload = param2;
         UnknownVarFromNavigatorCacheEntry_Number_1 = param3;
         UnknownVarFromNavigatorCacheEntry_Number_2 = param4;
      }
      
      public function hasExpired(param1:Number) : Boolean
      {
         return param1 >= UnknownVarFromNavigatorCacheEntry_Number_2;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function get payload() : SearchResultContainer
      {
         return _payload;
      }
   }
}


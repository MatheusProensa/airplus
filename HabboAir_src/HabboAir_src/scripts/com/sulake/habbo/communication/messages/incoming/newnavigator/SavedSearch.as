package com.sulake.habbo.communication.messages.incoming.newnavigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class SavedSearch
   {
      private var _id:int;
      
      private var _searchCode:String;
      
      private var _filter:String;
      
      private var _localization:String;
      
      public function SavedSearch(param1:IMessageDataWrapper)
      {
         super();
         _id = param1.readInteger();
         _searchCode = param1.readString();
         _filter = param1.readString();
         _localization = param1.readString();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get searchCode() : String
      {
         return _searchCode;
      }
      
      public function get filter() : String
      {
         return _filter;
      }
      
      public function get localization() : String
      {
         return _localization;
      }
   }
}


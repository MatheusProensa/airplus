package com.sulake.habbo.communication.messages.incoming.newnavigator
{
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   
   [SecureSWF(rename="true")]
   public class SearchResultContainer
   {
      private var _searchCodeOriginal:String;
      
      private var _filteringData:String;
      
      private var _resultSet:SearchResultSet;
      
      public function SearchResultContainer(param1:SearchResultSet)
      {
         super();
         _searchCodeOriginal = param1.searchCodeOriginal;
         _filteringData = param1.filteringData;
         _resultSet = param1;
      }
      
      public function get searchCodeOriginal() : String
      {
         return _searchCodeOriginal;
      }
      
      public function get filteringData() : String
      {
         return _filteringData;
      }
      
      public function get resultSet() : SearchResultSet
      {
         return _resultSet;
      }
      
      public function findGuestRoom(param1:int) : GuestRoomData
      {
         if(_resultSet != null)
         {
            return _resultSet.findGuestRoom(param1);
         }
         return null;
      }
   }
}


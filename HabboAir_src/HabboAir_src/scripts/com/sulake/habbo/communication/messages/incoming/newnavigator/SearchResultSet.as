package com.sulake.habbo.communication.messages.incoming.newnavigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   
   [SecureSWF(rename="true")]
   public class SearchResultSet
   {
      private var _searchCodeOriginal:String;
      
      private var _filteringData:String;
      
      private var _blocks:Vector.<SearchResultList>;
      
      public function SearchResultSet(param1:IMessageDataWrapper, param2:SearchResultList = null)
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _blocks = new Vector.<SearchResultList>(0);
         super();
         if(param2 != null)
         {
            _searchCodeOriginal = param2.searchCode;
            _filteringData = param2.text;
            _blocks.push(param2);
         }
         else
         {
            _searchCodeOriginal = param1.readString();
            _filteringData = param1.readString();
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _blocks.push(new SearchResultList(param1));
               _loc4_++;
            }
         }
      }
      
      public function get searchCodeOriginal() : String
      {
         return _searchCodeOriginal;
      }
      
      public function get filteringData() : String
      {
         return _filteringData;
      }
      
      public function get blocks() : Vector.<SearchResultList>
      {
         return _blocks;
      }
      
      public function findGuestRoom(param1:int) : GuestRoomData
      {
         var _loc3_:GuestRoomData = null;
         for each(var _loc2_ in _blocks)
         {
            _loc3_ = _loc2_.findGuestRoom(param1);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}


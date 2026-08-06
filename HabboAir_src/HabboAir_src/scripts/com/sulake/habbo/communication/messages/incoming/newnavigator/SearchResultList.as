package com.sulake.habbo.communication.messages.incoming.newnavigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   
   [SecureSWF(rename="true")]
   public class SearchResultList
   {
      public static const UnknownConstFromSearchResultList_Int_1:int = 0;
      
      public static const UnknownConstFromSearchResultList_Int_2:int = 1;
      
      public static const UnknownConstFromSearchResultList_Int_3:int = 2;
      
      private var _searchCode:String;
      
      private var _text:String;
      
      private var _actionAllowed:int;
      
      private var _forceClosed:Boolean;
      
      private var _viewMode:int;
      
      private var _guestRooms:Vector.<GuestRoomData>;
      
      public function SearchResultList(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _guestRooms = new Vector.<GuestRoomData>(0);
         super();
         _searchCode = param1.readString();
         _text = param1.readString();
         _actionAllowed = param1.readInteger();
         _forceClosed = param1.readBoolean();
         _viewMode = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _guestRooms.push(new GuestRoomData(param1));
            _loc3_++;
         }
      }
      
      public function get guestRooms() : Vector.<GuestRoomData>
      {
         return _guestRooms;
      }
      
      public function get searchCode() : String
      {
         return _searchCode;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get actionAllowed() : int
      {
         return _actionAllowed;
      }
      
      public function get forceClosed() : Boolean
      {
         return _forceClosed;
      }
      
      public function get viewMode() : int
      {
         return _viewMode;
      }
      
      public function set viewMode(param1:int) : void
      {
         _viewMode = param1;
      }
      
      public function findGuestRoom(param1:int) : GuestRoomData
      {
         for each(var _loc2_ in _guestRooms)
         {
            if(_loc2_.flatId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}


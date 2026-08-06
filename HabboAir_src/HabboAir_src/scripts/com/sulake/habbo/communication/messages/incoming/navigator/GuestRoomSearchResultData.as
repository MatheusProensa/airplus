package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GuestRoomSearchResultData implements IComponentInterfaceQueue, UnknownIHabboCommunicationMessagesIncomingNavigator1
   {
      private var _searchType:int;
      
      private var _searchParam:String;
      
      private var _rooms:Array;
      
      private var _ad:OfficialRoomEntryData;
      
      private var _disposed:Boolean;
      
      public function GuestRoomSearchResultData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _rooms = [];
         super();
         _searchType = param1.readInteger();
         _searchParam = param1.readString();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _rooms.push(new GuestRoomData(param1));
            _loc3_++;
         }
         var _loc4_:Boolean = param1.readBoolean();
         if(_loc4_)
         {
            _ad = new OfficialRoomEntryData(param1);
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(this._rooms != null)
         {
            for each(var _loc1_ in this._rooms)
            {
               _loc1_.dispose();
            }
         }
         if(_ad != null)
         {
            _ad.dispose();
            _ad = null;
         }
         this._rooms = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get searchType() : int
      {
         return _searchType;
      }
      
      public function get searchParam() : String
      {
         return _searchParam;
      }
      
      public function get rooms() : Array
      {
         return _rooms;
      }
      
      public function get ad() : OfficialRoomEntryData
      {
         return _ad;
      }
   }
}


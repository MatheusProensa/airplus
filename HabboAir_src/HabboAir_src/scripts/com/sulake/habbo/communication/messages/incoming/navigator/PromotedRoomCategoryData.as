package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class PromotedRoomCategoryData implements IComponentInterfaceQueue
   {
      private var _code:String;
      
      private var _leaderFigure:String;
      
      private var _bestRoom:GuestRoomData;
      
      private var _rooms:Array;
      
      private var _open:Boolean;
      
      private var _figurePending:Boolean;
      
      private var _disposed:Boolean;
      
      public function PromotedRoomCategoryData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _rooms = [];
         super();
         _code = param1.readString();
         _leaderFigure = param1.readString();
         var _loc2_:int = param1.readInteger();
         _bestRoom = new GuestRoomData(param1);
         _loc3_ = 1;
         while(_loc3_ < _loc2_)
         {
            _rooms.push(new GuestRoomData(param1));
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_bestRoom)
         {
            _bestRoom.dispose();
            _bestRoom = null;
         }
         for each(var _loc1_ in rooms)
         {
            _loc1_.dispose();
         }
         _rooms = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get code() : String
      {
         return _code;
      }
      
      public function get leaderFigure() : String
      {
         return _leaderFigure;
      }
      
      public function get rooms() : Array
      {
         return _rooms;
      }
      
      public function get open() : Boolean
      {
         return _open;
      }
      
      public function set open(param1:Boolean) : void
      {
         _open = param1;
      }
      
      public function toggleOpen() : void
      {
         _open = !_open;
      }
      
      public function get bestRoom() : GuestRoomData
      {
         return _bestRoom;
      }
      
      public function get figurePending() : Boolean
      {
         return _figurePending;
      }
      
      public function set figurePending(param1:Boolean) : void
      {
         _figurePending = param1;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FavouritesMessageParser implements IMessageParser
   {
      private var _limit:int;
      
      private var _favouriteRoomIds:Array;
      
      public function FavouritesMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _favouriteRoomIds = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         this._limit = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _favouriteRoomIds.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get limit() : int
      {
         return _limit;
      }
      
      public function get favouriteRoomIds() : Array
      {
         return _favouriteRoomIds;
      }
   }
}


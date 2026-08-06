package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.RoomEntryData;
   
   [SecureSWF(rename="true")]
   public class RoomAdPurchaseInfoEventParser implements IMessageParser
   {
      private var _isVip:Boolean;
      
      private var _rooms:Array;
      
      public function RoomAdPurchaseInfoEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function get rooms() : Array
      {
         return _rooms;
      }
      
      public function get isVip() : Boolean
      {
         return _isVip;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc4_:Boolean = false;
         var _loc7_:RoomEntryData = null;
         _rooms = [];
         _isVip = param1.readBoolean();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = param1.readInteger();
            _loc6_ = param1.readString();
            _loc4_ = param1.readBoolean();
            _loc7_ = new RoomEntryData(_loc5_,_loc6_,_loc4_);
            _rooms.push(_loc7_);
            _loc3_++;
         }
         return true;
      }
   }
}


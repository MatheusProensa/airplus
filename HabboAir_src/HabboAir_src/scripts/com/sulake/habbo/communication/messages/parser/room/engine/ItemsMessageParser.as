package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
   
   [SecureSWF(rename="true")]
   public class ItemsMessageParser implements IMessageParser
   {
      private var _items:Array = [];
      
      public function ItemsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _items = [];
         return true;
      }
      
      public function getItemCount() : int
      {
         return _items.length;
      }
      
      public function getItem(param1:int) : ItemMessageData
      {
         if(param1 < 0 || param1 >= getItemCount())
         {
            return null;
         }
         var _loc2_:ItemMessageData = _items[param1] as ItemMessageData;
         if(_loc2_ != null)
         {
            _loc2_.setReadOnly();
         }
         return _loc2_;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:String = null;
         var _loc2_:ItemMessageData = null;
         if(param1 == null)
         {
            return false;
         }
         _items = [];
         var _loc6_:Map = new Map();
         var _loc4_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1.readInteger();
            _loc3_ = param1.readString();
            _loc6_.add(_loc7_,_loc3_);
            _loc5_++;
         }
         var _loc8_:int = param1.readInteger();
         Logger.log("We have: " + _loc8_ + " items");
         _loc5_ = 0;
         while(_loc5_ < _loc8_)
         {
            _loc2_ = UnknownHabboCommunicationMessagesParserRoomEngine2.parseItemData(param1);
            _loc2_.ownerName = _loc6_.getValue(_loc2_.ownerId);
            _items.push(_loc2_);
            _loc5_++;
         }
         return true;
      }
   }
}


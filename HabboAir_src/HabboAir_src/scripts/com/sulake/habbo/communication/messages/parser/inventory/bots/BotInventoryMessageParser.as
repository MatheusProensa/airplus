package com.sulake.habbo.communication.messages.parser.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class BotInventoryMessageParser implements IMessageParser
   {
      private var _items:Map;
      
      public function BotInventoryMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(_items)
         {
            _items.dispose();
            _items = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:BotData = null;
         _items = new Map();
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new BotData(param1);
            _items.add(_loc2_.id,_loc2_);
            _loc4_++;
         }
         return true;
      }
      
      public function get items() : Map
      {
         return _items;
      }
   }
}


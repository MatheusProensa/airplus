package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.event.SnowWarGameEventData;
   
   public class GameStatusData
   {
      private var _turn:int;
      
      private var _checksum:int;
      
      private var _events:Map;
      
      public function GameStatusData(param1:IMessageDataWrapper)
      {
         super();
         parse(param1);
      }
      
      public function get turn() : int
      {
         return _turn;
      }
      
      public function get checksum() : int
      {
         return _checksum;
      }
      
      public function get events() : Map
      {
         return _events;
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:Array = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SnowWarGameEventData = null;
         _turn = param1.readInteger();
         _checksum = param1.readInteger();
         _events = new Map();
         var _loc2_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc6_ = param1.readInteger();
            _loc8_ = [];
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc3_ = param1.readInteger();
               _loc4_ = SnowWarGameEventData.create(_loc3_);
               if(_loc4_)
               {
                  _loc4_.parse(param1);
                  _loc8_.push(_loc4_);
               }
               _loc7_++;
            }
            _events.add(_loc5_,_loc8_);
            _loc5_++;
         }
      }
   }
}


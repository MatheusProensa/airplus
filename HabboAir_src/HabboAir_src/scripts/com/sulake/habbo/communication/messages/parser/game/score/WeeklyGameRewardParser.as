package com.sulake.habbo.communication.messages.parser.game.score
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
   
   public class WeeklyGameRewardParser implements IMessageParser
   {
      private var _gameTypeId:int;
      
      private var _products:Array = [];
      
      private var _minutesUntilNextWeek:int;
      
      private var _rewardingOn:Boolean;
      
      public function WeeklyGameRewardParser()
      {
         super();
      }
      
      public function get gameTypeId() : int
      {
         return _gameTypeId;
      }
      
      public function get products() : Array
      {
         return _products;
      }
      
      public function get minutesUntilNextWeek() : int
      {
         return _minutesUntilNextWeek;
      }
      
      public function get rewardingOn() : Boolean
      {
         return _rewardingOn;
      }
      
      public function flush() : Boolean
      {
         _gameTypeId = -1;
         _products = [];
         _minutesUntilNextWeek = 0;
         _rewardingOn = true;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         _gameTypeId = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _products.push(new CatalogPageMessageProductData(param1));
            _loc2_++;
         }
         _minutesUntilNextWeek = param1.readInteger();
         _rewardingOn = param1.readBoolean();
         return true;
      }
   }
}


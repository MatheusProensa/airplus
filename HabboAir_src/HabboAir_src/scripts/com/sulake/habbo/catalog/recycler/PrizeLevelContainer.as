package com.sulake.habbo.catalog.recycler
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.communication.messages.parser.recycler.PrizeLevelMessageData;
   import com.sulake.habbo.communication.messages.parser.recycler.PrizeMessageData;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   
   public class PrizeLevelContainer
   {
      private var _prizeLevelId:int;
      
      private var _prizes:Array;
      
      private var _probabilityDenominator:int;
      
      public function PrizeLevelContainer(param1:PrizeLevelMessageData, param2:HabboCatalog)
      {
         var _loc4_:int = 0;
         var _loc3_:PrizeMessageData = null;
         var _loc6_:PrizeContainer = null;
         var _loc5_:IFurnitureData = null;
         super();
         _prizeLevelId = param1.prizeLevelId;
         _probabilityDenominator = param1.probabilityDenominator;
         _prizes = [];
         _loc4_ = 0;
         while(_loc4_ < param1.prizes.length)
         {
            _loc3_ = param1.prizes[_loc4_];
            if(_loc3_.isDeal)
            {
               _loc6_ = new DealPrizeContainer(_loc3_.subProducts,_prizeLevelId,param2);
            }
            else
            {
               _loc5_ = param2.getFurnitureData(_loc3_.productItemTypeId,_loc3_.productItemType);
               _loc6_ = new PrizeContainer(_loc3_.productItemType,_loc3_.productItemTypeId,_loc5_,_prizeLevelId,param2);
            }
            _prizes.push(_loc6_);
            _loc4_++;
         }
      }
      
      public function get prizeLevelId() : int
      {
         return _prizeLevelId;
      }
      
      public function get prizes() : Array
      {
         return _prizes;
      }
      
      public function get probabilityDenominator() : int
      {
         return _probabilityDenominator;
      }
   }
}


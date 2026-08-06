package com.sulake.habbo.inventory.trading
{
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.room.IStuffData;
   
   public interface ITradingModel
   {
      function requestAddItemsToTrading(param1:Vector.<int>, param2:Boolean, param3:int, param4:int, param5:Boolean, param6:IStuffData) : void;
      
      function requestRemoveItemFromTrading(param1:int) : void;
      
      function getOwnItemIdsInTrade() : Array;
      
      function getInventory() : HabboInventory;
   }
}


package com.sulake.habbo.inventory.collectibles
{
   import com.sulake.habbo.communication.messages.parser.collectibles.trading.TradeNftItem;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public class RenderableTradeNftItem implements IProductDisplayInfo
   {
      private var _item:TradeNftItem;
      
      public function RenderableTradeNftItem(param1:TradeNftItem)
      {
         super();
         _item = param1;
      }
      
      public function get item() : TradeNftItem
      {
         return _item;
      }
      
      public function get productTypeId() : int
      {
         return _item.productTypeId;
      }
      
      public function get itemTypeId() : String
      {
         return _item.itemTypeId;
      }
      
      public function get extraData() : String
      {
         return "";
      }
      
      public function get petFigureString() : String
      {
         return _item.petFigureString;
      }
      
      public function get botFigureString() : String
      {
         return "";
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return _item.figureSetIds;
      }
   }
}


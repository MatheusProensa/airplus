package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleBaseItem;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public class RenderableShopNftItem implements IProductDisplayInfo
   {
      private var _item:CollectibleBaseItem;
      
      public function RenderableShopNftItem(param1:CollectibleBaseItem)
      {
         super();
         _item = param1;
      }
      
      public function get item() : CollectibleBaseItem
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
      
      public function get extraData() : String
      {
         return "";
      }
   }
}


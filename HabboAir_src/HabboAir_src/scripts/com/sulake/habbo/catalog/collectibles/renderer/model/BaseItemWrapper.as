package com.sulake.habbo.catalog.collectibles.renderer.model
{
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleBaseItem;
   
   public class BaseItemWrapper implements IRenderableCollectibleItem
   {
      private var _baseItem:CollectibleBaseItem;
      
      public function BaseItemWrapper(param1:CollectibleBaseItem)
      {
         super();
         _baseItem = param1;
      }
      
      public function get productTypeId() : int
      {
         return _baseItem.productTypeId;
      }
      
      public function get itemTypeId() : String
      {
         return _baseItem.itemTypeId;
      }
      
      public function get petFigureString() : String
      {
         return _baseItem.petFigureString;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return _baseItem.figureSetIds;
      }
      
      public function get baseItem() : CollectibleBaseItem
      {
         return _baseItem;
      }
      
      public function get amount() : int
      {
         return 0;
      }
      
      public function get extraData() : String
      {
         return "";
      }
      
      public function get botFigureString() : String
      {
         return "";
      }
   }
}


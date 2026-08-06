package com.sulake.habbo.catalog.collectibles.renderer.model
{
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleItem;
   
   public class CollectionItemWrapper implements IRenderableCollectibleItem
   {
      private var _collectionItem:CollectibleItem;
      
      public function CollectionItemWrapper(param1:CollectibleItem)
      {
         super();
         _collectionItem = param1;
      }
      
      public function get productTypeId() : int
      {
         return _collectionItem.productTypeId;
      }
      
      public function get itemTypeId() : String
      {
         return _collectionItem.itemTypeId;
      }
      
      public function get extraData() : String
      {
         return "";
      }
      
      public function get amount() : int
      {
         return _collectionItem.amount;
      }
      
      public function get petFigureString() : String
      {
         return _collectionItem.petFigureString;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return _collectionItem.figureSetIds;
      }
      
      public function get collectionItem() : CollectibleItem
      {
         return _collectionItem;
      }
      
      public function get botFigureString() : String
      {
         return "";
      }
   }
}


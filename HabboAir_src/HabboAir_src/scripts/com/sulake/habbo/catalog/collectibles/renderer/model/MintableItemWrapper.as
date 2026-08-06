package com.sulake.habbo.catalog.collectibles.renderer.model
{
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectiblesProductItem;
   
   public class MintableItemWrapper implements IRenderableCollectibleItem
   {
      private var _productItem:CollectiblesProductItem;
      
      private var _amount:int;
      
      public function MintableItemWrapper(param1:CollectiblesProductItem, param2:int)
      {
         super();
         _productItem = param1;
         _amount = param2;
      }
      
      public function get productTypeId() : int
      {
         switch(_productItem.itemType)
         {
            case "i":
               return 0;
            case "s":
               return 1;
            case "cl":
               return 11;
            default:
               return -1;
         }
      }
      
      public function get itemTypeId() : String
      {
         return String(_productItem.itemTypeId);
      }
      
      public function get extraData() : String
      {
         return "";
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function set amount(param1:int) : void
      {
         _amount = param1;
      }
      
      public function get petFigureString() : String
      {
         return "";
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return new Vector.<int>();
      }
      
      public function get productItem() : CollectiblesProductItem
      {
         return _productItem;
      }
      
      public function get botFigureString() : String
      {
         return "";
      }
   }
}


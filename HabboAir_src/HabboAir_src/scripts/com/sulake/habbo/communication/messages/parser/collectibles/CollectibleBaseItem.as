package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class CollectibleBaseItem
   {
      protected var _productTypeId:int;
      
      protected var _itemTypeId:String;
      
      protected var _score:int;
      
      protected var _petFigureString:String;
      
      protected var _figureSetIds:Vector.<int>;
      
      protected var _productCode:String;
      
      protected var _rarity:String;
      
      public function CollectibleBaseItem(param1:IMessageDataWrapper)
      {
         var _loc2_:int = 0;
         super();
         _productTypeId = param1.readShort();
         _itemTypeId = param1.readString();
         _score = param1.readInteger();
         readAdditionalParams(param1);
         _petFigureString = param1.readString();
         _figureSetIds = new Vector.<int>();
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _figureSetIds.push(param1.readInteger());
            _loc2_++;
         }
         _productCode = param1.readString();
         _rarity = param1.readString();
      }
      
      public function readAdditionalParams(param1:IMessageDataWrapper) : void
      {
      }
      
      public function get productTypeId() : int
      {
         return _productTypeId;
      }
      
      public function get itemTypeId() : String
      {
         return _itemTypeId;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get petFigureString() : String
      {
         return _petFigureString;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return _figureSetIds;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get rarity() : String
      {
         return _rarity;
      }
   }
}


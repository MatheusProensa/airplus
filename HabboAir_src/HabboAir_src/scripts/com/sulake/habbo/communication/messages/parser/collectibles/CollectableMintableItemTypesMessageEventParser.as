package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CollectableMintableItemTypesMessageEventParser implements IMessageParser
   {
      private var _collectibleProductItems:Vector.<CollectiblesProductItem> = new Vector.<CollectiblesProductItem>(0);
      
      public function CollectableMintableItemTypesMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _collectibleProductItems = new Vector.<CollectiblesProductItem>(0);
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _collectibleProductItems.push(new CollectiblesProductItem(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function hasData() : Boolean
      {
         return _collectibleProductItems.length > 0;
      }
      
      public function get collectibleProductItems() : Vector.<CollectiblesProductItem>
      {
         return _collectibleProductItems;
      }
   }
}


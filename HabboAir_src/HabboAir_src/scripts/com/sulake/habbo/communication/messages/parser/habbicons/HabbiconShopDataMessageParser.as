package com.sulake.habbo.communication.messages.parser.habbicons
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HabbiconShopDataMessageParser implements IMessageParser
   {
      private var _collections:Array;
      
      private var UnknownVarFromHabbiconShopDataMessageParser_HabbiconShopCollectionDataParser_1:HabbiconShopCollectionDataParser;
      
      public function HabbiconShopDataMessageParser()
      {
         super();
         UnknownVarFromHabbiconShopDataMessageParser_HabbiconShopCollectionDataParser_1 = new HabbiconShopCollectionDataParser();
         _collections = [];
      }
      
      public function get collections() : Array
      {
         return _collections;
      }
      
      public function flush() : Boolean
      {
         _collections = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _collections = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _collections.push(UnknownVarFromHabbiconShopDataMessageParser_HabbiconShopCollectionDataParser_1.parse(param1));
            _loc3_++;
         }
         return true;
      }
   }
}


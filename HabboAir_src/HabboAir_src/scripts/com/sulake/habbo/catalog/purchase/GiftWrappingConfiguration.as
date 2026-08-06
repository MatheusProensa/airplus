package com.sulake.habbo.catalog.purchase
{
   import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationParser;
   
   public class GiftWrappingConfiguration
   {
      private var _isEnabled:Boolean = false;
      
      private var _price:int;
      
      private var _stuffTypes:Array;
      
      private var _boxTypes:Array;
      
      private var _ribbonTypes:Array;
      
      private var _defaultStuffTypes:Array;
      
      public function GiftWrappingConfiguration(param1:GiftWrappingConfigurationEvent)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var _loc2_:GiftWrappingConfigurationParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         _isEnabled = _loc2_.isWrappingEnabled;
         _price = _loc2_.wrappingPrice;
         _stuffTypes = _loc2_.stuffTypes;
         _boxTypes = _loc2_.boxTypes;
         _ribbonTypes = _loc2_.ribbonTypes;
         _defaultStuffTypes = _loc2_.defaultStuffTypes;
      }
      
      public function get isEnabled() : Boolean
      {
         return _isEnabled;
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      public function get stuffTypes() : Array
      {
         return _stuffTypes;
      }
      
      public function get boxTypes() : Array
      {
         return _boxTypes;
      }
      
      public function get ribbonTypes() : Array
      {
         return _ribbonTypes;
      }
      
      public function get defaultStuffTypes() : Array
      {
         return _defaultStuffTypes;
      }
   }
}


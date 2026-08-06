package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GiftWrappingConfigurationParser implements IMessageParser
   {
      private var _isWrappingEnabled:Boolean;
      
      private var _wrappingPrice:int;
      
      private var _stuffTypes:Array;
      
      private var _boxTypes:Array;
      
      private var _ribbonTypes:Array;
      
      private var _defaultStuffTypes:Array;
      
      public function GiftWrappingConfigurationParser()
      {
         super();
      }
      
      public function get isWrappingEnabled() : Boolean
      {
         return _isWrappingEnabled;
      }
      
      public function get wrappingPrice() : int
      {
         return _wrappingPrice;
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
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _stuffTypes = [];
         _boxTypes = [];
         _ribbonTypes = [];
         _defaultStuffTypes = [];
         _isWrappingEnabled = param1.readBoolean();
         _wrappingPrice = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _stuffTypes.push(param1.readInteger());
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _boxTypes.push(param1.readInteger());
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _ribbonTypes.push(param1.readInteger());
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _defaultStuffTypes.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
   }
}


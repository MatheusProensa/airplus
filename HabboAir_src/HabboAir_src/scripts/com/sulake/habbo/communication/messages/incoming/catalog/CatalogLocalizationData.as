package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class CatalogLocalizationData
   {
      private var _images:Array;
      
      private var _texts:Array;
      
      public function CatalogLocalizationData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         super();
         _images = [];
         _texts = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _images.push(param1.readString());
            _loc3_++;
         }
         var _loc4_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _texts.push(param1.readString());
            _loc5_++;
         }
      }
      
      public function get images() : Array
      {
         return _images;
      }
      
      public function get texts() : Array
      {
         return _texts;
      }
   }
}


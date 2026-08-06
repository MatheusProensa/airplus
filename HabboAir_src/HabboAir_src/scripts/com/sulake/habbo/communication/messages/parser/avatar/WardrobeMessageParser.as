package com.sulake.habbo.communication.messages.parser.avatar
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.avatar.OutfitData;
   
   [SecureSWF(rename="true")]
   public class WardrobeMessageParser implements IMessageParser
   {
      private var _state:int;
      
      private var _outfits:Array;
      
      public function WardrobeMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _state = 0;
         _outfits = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:OutfitData = null;
         _state = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new OutfitData(param1);
            _outfits.push(_loc2_);
            _loc4_++;
         }
         return true;
      }
      
      public function get outfits() : Array
      {
         return _outfits;
      }
      
      public function get state() : int
      {
         return _state;
      }
   }
}


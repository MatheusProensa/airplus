package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
   
   [SecureSWF(rename="true")]
   public class FurniListParser implements IMessageParser
   {
      protected var _totalFragments:int;
      
      protected var _fragmentNo:int;
      
      private var _furniFragment:Map;
      
      public function FurniListParser()
      {
         super();
      }
      
      public function get totalFragments() : int
      {
         return _totalFragments;
      }
      
      public function get fragmentNo() : int
      {
         return _fragmentNo;
      }
      
      public function get furniFragment() : Map
      {
         return _furniFragment;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:FurniData = null;
         _totalFragments = param1.readInteger();
         _fragmentNo = param1.readInteger();
         _furniFragment = new Map();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new FurniData(param1);
            _furniFragment.add(_loc4_.itemId,_loc4_);
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         if(_furniFragment)
         {
            _furniFragment.dispose();
            _furniFragment = null;
         }
         return true;
      }
   }
}


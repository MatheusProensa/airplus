package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class RarityCategoryData
   {
      private var _chance:int;
      
      private var _breeds:Array;
      
      public function RarityCategoryData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         super();
         _chance = param1.readInteger();
         _breeds = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _breeds.push(param1.readInteger());
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         _chance = -1;
         _breeds = [];
      }
      
      public function get chance() : int
      {
         return _chance;
      }
      
      public function get breeds() : Array
      {
         return _breeds;
      }
   }
}


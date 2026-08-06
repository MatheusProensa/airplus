package com.sulake.habbo.sound.trax
{
   public class TraxChannelItem
   {
      private var _id:int;
      
      private var _length:int;
      
      public function TraxChannelItem(param1:int, param2:int)
      {
         super();
         _id = param1;
         _length = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get length() : int
      {
         return _length;
      }
   }
}


package com.sulake.core.communication.util
{
   public class Byte
   {
      private var _value:int;
      
      public function Byte(param1:int)
      {
         super();
         _value = param1;
      }
      
      public function get value() : int
      {
         return _value;
      }
   }
}


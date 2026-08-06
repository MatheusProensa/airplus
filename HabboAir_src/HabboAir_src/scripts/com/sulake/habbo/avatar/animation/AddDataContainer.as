package com.sulake.habbo.avatar.animation
{
   public class AddDataContainer
   {
      private var _id:String;
      
      private var _align:String;
      
      private var _base:String;
      
      private var _ink:String;
      
      private var _blend:Number = 1;
      
      public function AddDataContainer(param1:XML)
      {
         super();
         _id = String(param1.@id);
         _align = String(param1.@align);
         _base = String(param1.@base);
         _ink = String(param1.@ink);
         var _loc2_:String = String(param1.@blend);
         if(_loc2_.length > 0)
         {
            _blend = Number(_loc2_);
            if(_blend > 1)
            {
               _blend /= 100;
            }
         }
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get align() : String
      {
         return _align;
      }
      
      public function get base() : String
      {
         return _base;
      }
      
      public function get ink() : String
      {
         return _ink;
      }
      
      public function get blend() : Number
      {
         return _blend;
      }
      
      public function get isBlended() : Boolean
      {
         return _blend != 1;
      }
   }
}


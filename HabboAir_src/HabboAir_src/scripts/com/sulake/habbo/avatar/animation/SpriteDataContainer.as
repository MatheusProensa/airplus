package com.sulake.habbo.avatar.animation
{
   public class SpriteDataContainer implements ISpriteDataContainer
   {
      private var _animation:IAnimation;
      
      private var _id:String;
      
      private var _ink:int;
      
      private var _member:String;
      
      private var _hasDirections:Boolean;
      
      private var _hasStaticY:Boolean;
      
      private var UnknownVarFromSpriteDataContainer_Array_1:Array;
      
      private var UnknownVarFromSpriteDataContainer_Array_2:Array;
      
      private var UnknownVarFromSpriteDataContainer_Array_3:Array;
      
      public function SpriteDataContainer(param1:IAnimation, param2:XML)
      {
         var _loc4_:int = 0;
         super();
         _animation = param1;
         _id = String(param2.@id);
         _ink = parseInt(param2.@ink);
         _member = String(param2.@member);
         _hasStaticY = Boolean(parseInt(param2.@staticY));
         _hasDirections = Boolean(parseInt(param2.@directions));
         UnknownVarFromSpriteDataContainer_Array_1 = [];
         UnknownVarFromSpriteDataContainer_Array_2 = [];
         UnknownVarFromSpriteDataContainer_Array_3 = [];
         for each(var _loc3_ in param2.direction)
         {
            _loc4_ = parseInt(_loc3_.@id);
            UnknownVarFromSpriteDataContainer_Array_1[_loc4_] = parseInt(_loc3_.@dx);
            UnknownVarFromSpriteDataContainer_Array_2[_loc4_] = parseInt(_loc3_.@dy);
            UnknownVarFromSpriteDataContainer_Array_3[_loc4_] = parseInt(_loc3_.@dz);
         }
      }
      
      public function getDirectionOffsetX(param1:int) : int
      {
         if(param1 < UnknownVarFromSpriteDataContainer_Array_1.length)
         {
            return UnknownVarFromSpriteDataContainer_Array_1[param1];
         }
         return 0;
      }
      
      public function getDirectionOffsetY(param1:int) : int
      {
         if(param1 < UnknownVarFromSpriteDataContainer_Array_2.length)
         {
            return UnknownVarFromSpriteDataContainer_Array_2[param1];
         }
         return 0;
      }
      
      public function getDirectionOffsetZ(param1:int) : int
      {
         if(param1 < UnknownVarFromSpriteDataContainer_Array_3.length)
         {
            return UnknownVarFromSpriteDataContainer_Array_3[param1];
         }
         return 0;
      }
      
      public function get animation() : IAnimation
      {
         return _animation;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get ink() : int
      {
         return _ink;
      }
      
      public function get member() : String
      {
         return _member;
      }
      
      public function get hasDirections() : Boolean
      {
         return _hasDirections;
      }
      
      public function get hasStaticY() : Boolean
      {
         return _hasStaticY;
      }
   }
}


package com.sulake.habbo.avatar.structure.animation
{
   public class AnimationFrame
   {
      private var _number:int;
      
      private var _assetPartDefinition:String;
      
      public function AnimationFrame(param1:XML)
      {
         super();
         _number = parseInt(param1.@number);
         _assetPartDefinition = param1.@assetpartdefinition;
      }
      
      public function get number() : int
      {
         return _number;
      }
      
      public function get assetPartDefinition() : String
      {
         return _assetPartDefinition;
      }
   }
}


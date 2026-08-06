package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   
   public class ExpressionAddition implements IExpressionAddition
   {
      protected var _id:int;
      
      protected var UnknownVarFromExpressionAddition_AvatarVisualization_1:AvatarVisualization;
      
      private var _type:int = -1;
      
      public function ExpressionAddition(param1:int, param2:int, param3:AvatarVisualization)
      {
         super();
         _type = param2;
         _id = param1;
         UnknownVarFromExpressionAddition_AvatarVisualization_1 = param3;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromExpressionAddition_AvatarVisualization_1 == null;
      }
      
      public function dispose() : void
      {
         UnknownVarFromExpressionAddition_AvatarVisualization_1 = null;
      }
      
      public function update(param1:IRoomObjectSprite, param2:Number) : void
      {
      }
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         return false;
      }
   }
}


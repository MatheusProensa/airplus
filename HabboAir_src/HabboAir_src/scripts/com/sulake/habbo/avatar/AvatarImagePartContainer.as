package com.sulake.habbo.avatar
{
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   import com.sulake.habbo.avatar.structure.animation.AnimationFrame;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.geom.ColorTransform;
   
   public class AvatarImagePartContainer
   {
      private var _bodyPartId:String;
      
      private var _partType:String;
      
      private var _flippedPartType:String;
      
      private var _partId:String;
      
      private var _color:IPartColor;
      
      private var _frames:Array;
      
      private var _action:IActionDefinition;
      
      private var _isColorable:Boolean;
      
      private var _isBlendable:Boolean;
      
      private var _blendTransform:ColorTransform;
      
      private var _paletteMapId:int;
      
      public function AvatarImagePartContainer(param1:String, param2:String, param3:String, param4:IPartColor, param5:Array, param6:IActionDefinition, param7:Boolean, param8:int, param9:String = "", param10:Boolean = false, param11:Number = 1)
      {
         super();
         _bodyPartId = param1;
         _partType = param2;
         _partId = param3;
         _color = param4;
         _frames = param5;
         _action = param6;
         _isColorable = param7;
         _paletteMapId = param8;
         _flippedPartType = param9;
         _isBlendable = param10;
         _blendTransform = new ColorTransform(1,1,1,param11);
         if(_frames == null)
         {
            Logger.log("Null frame list");
         }
         if(_partType == "ey")
         {
            _isColorable = false;
         }
      }
      
      public function getFrameIndex(param1:int) : int
      {
         var _loc3_:AnimationFrame = null;
         if(!_frames || _frames.length == 0)
         {
            return 0;
         }
         var _loc2_:int = param1 % _frames.length;
         if(_frames[_loc2_] is AnimationFrame)
         {
            _loc3_ = _frames[_loc2_];
            return _loc3_.number;
         }
         return _loc2_;
      }
      
      public function getFrameDefinition(param1:int) : AnimationFrame
      {
         var _loc2_:int = param1 % _frames.length;
         if(_frames && _frames.length > _loc2_)
         {
            if(_frames[_loc2_] is AnimationFrame)
            {
               return _frames[_loc2_] as AnimationFrame;
            }
         }
         return null;
      }
      
      public function getCacheableKey(param1:int) : String
      {
         var _loc3_:AnimationFrame = null;
         var _loc2_:int = param1 % _frames.length;
         if(_frames && _frames.length > _loc2_)
         {
            if(_frames[_loc2_] is AnimationFrame)
            {
               _loc3_ = _frames[_loc2_] as AnimationFrame;
               return partId + ":" + _loc3_.assetPartDefinition + ":" + _loc3_.number;
            }
         }
         return partId + ":" + _loc2_;
      }
      
      public function get bodyPartId() : String
      {
         return _bodyPartId;
      }
      
      public function get partType() : String
      {
         return _partType;
      }
      
      public function get partId() : String
      {
         return _partId;
      }
      
      public function get color() : IPartColor
      {
         return _color;
      }
      
      public function get action() : IActionDefinition
      {
         return _action;
      }
      
      public function set isColorable(param1:Boolean) : void
      {
         _isColorable = param1;
      }
      
      public function get isColorable() : Boolean
      {
         return _isColorable;
      }
      
      public function get paletteMapId() : int
      {
         return _paletteMapId;
      }
      
      public function get flippedPartType() : String
      {
         return _flippedPartType;
      }
      
      public function get isBlendable() : Boolean
      {
         return _isBlendable;
      }
      
      public function get blendTransform() : ColorTransform
      {
         return _blendTransform;
      }
      
      public function toString() : String
      {
         return [_bodyPartId,_partType,_partId].join(":");
      }
   }
}


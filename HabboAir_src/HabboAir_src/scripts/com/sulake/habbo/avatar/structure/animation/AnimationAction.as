package com.sulake.habbo.avatar.structure.animation
{
   import com.sulake.core.utils.Map;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class AnimationAction
   {
      public static const DEFAULT_OFFSET:Point = new Point(0,0);
      
      private var _id:String;
      
      private var _parts:Dictionary;
      
      private var UnknownVarFromAnimationAction_Map_1:Map;
      
      private var _frameCount:int;
      
      private var _frameIndexes:Array;
      
      public function AnimationAction(param1:XML)
      {
         var _loc10_:AnimationActionPart = null;
         var _loc5_:int = 0;
         var _loc12_:Map = null;
         var _loc6_:int = 0;
         var _loc4_:Map = null;
         var _loc11_:String = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc3_:int = 0;
         UnknownVarFromAnimationAction_Map_1 = new Map();
         super();
         _id = String(param1.@id);
         _parts = new Dictionary();
         for each(var _loc8_ in param1.part)
         {
            _loc10_ = new AnimationActionPart(_loc8_);
            _parts[String(_loc8_["set-type"])] = _loc10_;
            _frameCount = Math.max(_frameCount,_loc10_.frames.length);
         }
         _frameIndexes = [];
         for each(var _loc2_ in param1.offsets.frame)
         {
            _loc5_ = parseInt(_loc2_.@id);
            _frameCount = Math.max(_frameCount,_loc5_);
            _loc12_ = new Map();
            UnknownVarFromAnimationAction_Map_1[_loc5_] = _loc12_;
            for each(var _loc9_ in _loc2_.directions.direction)
            {
               _loc6_ = parseInt(_loc9_.@id);
               _loc4_ = new Map();
               _loc12_[_loc6_] = _loc4_;
               for each(var _loc7_ in _loc9_.bodypart)
               {
                  _loc11_ = String(_loc7_.@id);
                  _loc13_ = !!_loc7_.hasOwnProperty("@dx") ? parseInt(_loc7_.@dx) : 0;
                  _loc14_ = !!_loc7_.hasOwnProperty("@dy") ? parseInt(_loc7_.@dy) : 0;
                  _loc4_[_loc11_] = new Point(_loc13_,_loc14_);
               }
            }
            _frameIndexes.push(_loc5_);
            _loc3_ = parseInt(_loc2_.@repeats);
            if(_loc3_ > 1)
            {
               while(true)
               {
                  _loc3_--;
                  if(_loc3_ <= 0)
                  {
                     break;
                  }
                  _frameIndexes.push(_loc5_);
               }
            }
         }
      }
      
      public function getPart(param1:String) : AnimationActionPart
      {
         return _parts[param1] as AnimationActionPart;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get parts() : Dictionary
      {
         return _parts;
      }
      
      public function get frameCount() : int
      {
         return _frameCount;
      }
      
      public function getFrameBodyPartOffset(param1:int, param2:int, param3:String) : Point
      {
         var _loc8_:Point = null;
         var _loc6_:Map = null;
         var _loc7_:int = param2 % _frameIndexes.length;
         var _loc4_:int = int(_frameIndexes[_loc7_]);
         var _loc5_:Map = UnknownVarFromAnimationAction_Map_1[_loc4_];
         if(_loc5_)
         {
            _loc6_ = _loc5_[param1];
            if(_loc6_)
            {
               _loc8_ = _loc6_[param3];
            }
         }
         return _loc8_ ?? DEFAULT_OFFSET;
      }
   }
}


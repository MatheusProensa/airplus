package com.sulake.habbo.avatar.animation
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.actions.ActiveActionData;
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   import com.sulake.habbo.avatar.actions.IActiveActionData;
   
   public class AnimationLayerData implements IAnimationLayerData
   {
      public static const UnknownConstFromAnimationLayerData_String_1:String = "bodypart";
      
      public static const UnknownConstFromAnimationLayerData_String_2:String = "fx";
      
      private var _id:String;
      
      private var _action:IActiveActionData;
      
      private var _animationFrame:int;
      
      private var _dx:int;
      
      private var _dy:int;
      
      private var _dz:int;
      
      private var _directionOffset:int;
      
      private var _type:String;
      
      private var _base:String;
      
      private var _items:Map = new Map();
      
      public function AnimationLayerData(param1:XML, param2:String, param3:IActionDefinition)
      {
         super();
         _id = String(param1.@id);
         _animationFrame = parseInt(param1.@frame);
         _dx = parseInt(param1.@dx);
         _dy = parseInt(param1.@dy);
         _dz = parseInt(param1.@dz);
         _directionOffset = parseInt(param1.@dd);
         _type = param2;
         _base = String(param1.@base);
         for each(var _loc5_ in param1.item)
         {
            _items[String(_loc5_.@id)] = String(_loc5_.@base);
         }
         var _loc4_:String = "";
         if(_base != "")
         {
            _loc4_ = String(baseAsInt());
         }
         if(param3 != null)
         {
            _action = new ActiveActionData(param3.state,base);
            _action.definition = param3;
         }
      }
      
      public function get items() : Map
      {
         return _items;
      }
      
      private function baseAsInt() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _base.length)
         {
            _loc2_ += _base.charCodeAt(_loc1_);
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get animationFrame() : int
      {
         return _animationFrame;
      }
      
      public function get dx() : int
      {
         return _dx;
      }
      
      public function get dy() : int
      {
         return _dy;
      }
      
      public function get dz() : int
      {
         return _dz;
      }
      
      public function get directionOffset() : int
      {
         return _directionOffset;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get base() : String
      {
         return _base;
      }
      
      public function get action() : IActiveActionData
      {
         return _action;
      }
   }
}


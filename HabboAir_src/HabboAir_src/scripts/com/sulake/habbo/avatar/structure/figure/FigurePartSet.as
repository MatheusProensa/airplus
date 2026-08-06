package com.sulake.habbo.avatar.structure.figure
{
   public class FigurePartSet implements IFigurePartSet
   {
      private var _type:String;
      
      private var _id:int;
      
      private var _gender:String;
      
      private var _clubLevel:int;
      
      private var _isColorable:Boolean;
      
      private var _isSelectable:Boolean;
      
      private var _parts:Array;
      
      private var _hiddenLayers:Array;
      
      private var _isPreSelectable:Boolean;
      
      private var _isSellable:Boolean;
      
      public function FigurePartSet(param1:XML, param2:String)
      {
         var _loc3_:FigurePart = null;
         var _loc5_:int = 0;
         super();
         _type = param2;
         _id = parseInt(param1.@id);
         _gender = String(param1.@gender);
         _clubLevel = parseInt(param1.@club);
         _isColorable = Boolean(parseInt(param1.@colorable));
         _isSelectable = Boolean(parseInt(param1.@selectable));
         _isPreSelectable = Boolean(parseInt(param1.@preselectable));
         _isSellable = Boolean(parseInt(param1.@sellable));
         _parts = [];
         _hiddenLayers = [];
         for each(var _loc4_ in param1.part)
         {
            _loc3_ = new FigurePart(_loc4_);
            _loc5_ = indexOfPartType(_loc3_);
            if(_loc5_ != -1)
            {
               _parts.splice(_loc5_,0,_loc3_);
            }
            else
            {
               _parts.push(_loc3_);
            }
         }
         for each(var _loc6_ in param1.hiddenlayers.layer)
         {
            _hiddenLayers.push(String(_loc6_.@parttype));
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in _parts)
         {
            _loc1_.dispose();
         }
         _parts = null;
         _hiddenLayers = null;
      }
      
      private function indexOfPartType(param1:FigurePart) : int
      {
         var _loc3_:int = 0;
         var _loc2_:FigurePart = null;
         _loc3_ = 0;
         while(_loc3_ < _parts.length)
         {
            _loc2_ = _parts[_loc3_];
            if(_loc2_.type == param1.type && _loc2_.index < param1.index)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function getPart(param1:String, param2:int) : IFigurePart
      {
         for each(var _loc3_ in _parts)
         {
            if(_loc3_.type == param1 && _loc3_.id == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get clubLevel() : int
      {
         return _clubLevel;
      }
      
      public function get isColorable() : Boolean
      {
         return _isColorable;
      }
      
      public function get isSelectable() : Boolean
      {
         return _isSelectable;
      }
      
      public function get parts() : Array
      {
         return _parts;
      }
      
      public function get hiddenLayers() : Array
      {
         return _hiddenLayers;
      }
      
      public function get isPreSelectable() : Boolean
      {
         return _isPreSelectable;
      }
      
      public function get isSellable() : Boolean
      {
         return _isSellable;
      }
   }
}


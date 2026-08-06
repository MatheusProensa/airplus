package com.sulake.habbo.avatar.structure.figure
{
   public class FigurePart implements IFigurePart
   {
      private var _id:int;
      
      private var _type:String;
      
      private var _breed:int = -1;
      
      private var _colorLayerIndex:int;
      
      private var _index:int;
      
      private var _paletteMap:int = -1;
      
      public function FigurePart(param1:XML)
      {
         super();
         _id = parseInt(param1.@id);
         _type = String(param1.@type);
         _index = parseInt(param1.@index);
         _colorLayerIndex = parseInt(param1.@colorindex);
         var _loc2_:String = param1.@palettemapid;
         if(_loc2_ != "")
         {
            _paletteMap = int(_loc2_);
         }
         var _loc3_:String = param1.@breed;
         if(_loc3_ != "")
         {
            _breed = int(_loc3_);
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get breed() : int
      {
         return _breed;
      }
      
      public function get colorLayerIndex() : int
      {
         return _colorLayerIndex;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get paletteMap() : int
      {
         return _paletteMap;
      }
   }
}


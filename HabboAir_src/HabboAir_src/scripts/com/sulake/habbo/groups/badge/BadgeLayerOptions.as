package com.sulake.habbo.groups.badge
{
   public class BadgeLayerOptions
   {
      private var _layerIndex:int = -1;
      
      private var _partIndex:int = -1;
      
      private var _colorIndex:int = -1;
      
      private var _gridX:int = -1;
      
      private var _gridY:int = -1;
      
      public function BadgeLayerOptions()
      {
         super();
      }
      
      public function setGrid(param1:int) : void
      {
         _gridX = Math.floor(param1 % 3);
         _gridY = Math.floor(param1 / 3);
      }
      
      public function clone() : BadgeLayerOptions
      {
         var _loc1_:BadgeLayerOptions = new BadgeLayerOptions();
         _loc1_._layerIndex = _layerIndex;
         _loc1_._partIndex = _partIndex;
         _loc1_._colorIndex = _colorIndex;
         _loc1_._gridX = _gridX;
         _loc1_._gridY = _gridY;
         return _loc1_;
      }
      
      public function equalVisuals(param1:BadgeLayerOptions) : Boolean
      {
         if(param1 == null || _gridX != param1.gridX || _gridY != param1.gridY || _colorIndex != param1.colorIndex)
         {
            return false;
         }
         if(_layerIndex == 0 && param1.layerIndex != 0 || _layerIndex != 0 && param1.layerIndex == 0)
         {
            return false;
         }
         return true;
      }
      
      public function isGridEqual(param1:BadgeLayerOptions) : Boolean
      {
         if(param1.gridX == _gridX && param1.gridY == _gridY)
         {
            return true;
         }
         return false;
      }
      
      public function get layerIndex() : int
      {
         return _layerIndex;
      }
      
      public function set layerIndex(param1:int) : void
      {
         _layerIndex = param1;
      }
      
      public function get partIndex() : int
      {
         return _partIndex;
      }
      
      public function set partIndex(param1:int) : void
      {
         _partIndex = param1;
      }
      
      public function get colorIndex() : int
      {
         return _colorIndex;
      }
      
      public function set colorIndex(param1:int) : void
      {
         _colorIndex = param1;
      }
      
      public function get gridX() : int
      {
         return _gridX;
      }
      
      public function set gridX(param1:int) : void
      {
         _gridX = param1;
      }
      
      public function get gridY() : int
      {
         return _gridY;
      }
      
      public function set gridY(param1:int) : void
      {
         _gridY = param1;
      }
      
      public function get position() : int
      {
         return gridY * 3 + gridX;
      }
   }
}


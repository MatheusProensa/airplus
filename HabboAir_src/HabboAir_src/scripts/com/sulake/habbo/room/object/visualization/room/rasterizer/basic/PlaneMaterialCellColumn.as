package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PlaneMaterialCellColumn
   {
      public static const REPEAT_MODE_NONE:int = 0;
      
      public static const REPEAT_MODE_ALL:int = 1;
      
      public static const REPEAT_MODE_BORDERS:int = 2;
      
      public static const REPEAT_MODE_CENTER:int = 3;
      
      public static const REPEAT_MODE_FIRST:int = 4;
      
      public static const REPEAT_MODE_LAST:int = 5;
      
      private var _cells:Array;
      
      private var _repeatMode:int = 1;
      
      private var _width:int = 1;
      
      private var UnknownVarFromPlaneMaterialCellColumn_BitmapData_1:BitmapData;
      
      private var _cachedBitmapNormal:Vector3d = null;
      
      private var UnknownVarFromPlaneMaterialCellColumn_Int_1:int;
      
      private var UnknownVarFromPlaneMaterialCellColumn_Int_2:int;
      
      private var UnknownVarFromPlaneMaterialCellColumn_Boolean_1:Boolean = false;
      
      private var _isStatic:Boolean = true;
      
      public function PlaneMaterialCellColumn(param1:int, param2:Array, param3:int = 1)
      {
         var _loc4_:int = 0;
         var _loc5_:PlaneMaterialCell = null;
         _cells = [];
         super();
         if(param1 < 1)
         {
            param1 = 1;
         }
         _width = param1;
         if(param2 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < param2.length)
            {
               _loc5_ = param2[_loc4_] as PlaneMaterialCell;
               if(_loc5_ != null)
               {
                  _cells.push(_loc5_);
                  if(!_loc5_.isStatic)
                  {
                     _isStatic = false;
                  }
               }
               _loc4_++;
            }
         }
         _repeatMode = param3;
      }
      
      public function get isStatic() : Boolean
      {
         return _isStatic;
      }
      
      public function isRepeated() : Boolean
      {
         return _repeatMode != 0;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PlaneMaterialCell = null;
         if(_cells != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _cells.length)
            {
               _loc2_ = _cells[_loc1_] as PlaneMaterialCell;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            _cells = null;
         }
         if(UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 != null)
         {
            UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.dispose();
            UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 = null;
         }
         if(_cachedBitmapNormal != null)
         {
            _cachedBitmapNormal = null;
         }
      }
      
      public function clearCache() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PlaneMaterialCell = null;
         if(!UnknownVarFromPlaneMaterialCellColumn_Boolean_1)
         {
            return;
         }
         if(UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 != null)
         {
            UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.dispose();
            UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 = null;
         }
         if(_cachedBitmapNormal != null)
         {
            _cachedBitmapNormal.x = 0;
            _cachedBitmapNormal.y = 0;
            _cachedBitmapNormal.z = 0;
         }
         if(_cells != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _cells.length)
            {
               _loc2_ = _cells[_loc1_] as PlaneMaterialCell;
               if(_loc2_ != null)
               {
                  _loc2_.clearCache();
               }
               _loc1_++;
            }
         }
         UnknownVarFromPlaneMaterialCellColumn_Boolean_1 = false;
      }
      
      public function render(param1:int, param2:IVector3d, param3:int, param4:int) : BitmapData
      {
         var _loc5_:int = 0;
         if(_repeatMode == 0)
         {
            param1 = _loc5_ = getCellsHeight(_cells,param2);
         }
         if(_cachedBitmapNormal == null)
         {
            _cachedBitmapNormal = new Vector3d();
         }
         if(isStatic)
         {
            if(UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 != null)
            {
               if(UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height == param1 && Vector3d.isEqual(_cachedBitmapNormal,param2) && UnknownVarFromPlaneMaterialCellColumn_Int_1 == param3 && UnknownVarFromPlaneMaterialCellColumn_Int_2 == param4)
               {
                  return UnknownVarFromPlaneMaterialCellColumn_BitmapData_1;
               }
               UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.dispose();
               UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 = null;
            }
         }
         else if(UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 != null)
         {
            if(UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height == param1)
            {
               UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.fillRect(UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.rect,16777215);
            }
            else
            {
               UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.dispose();
               UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 = null;
            }
         }
         UnknownVarFromPlaneMaterialCellColumn_Boolean_1 = true;
         if(UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 == null)
         {
            try
            {
               UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 = new BitmapData(_width,param1,true,16777215);
            }
            catch(e:Error)
            {
               return null;
            }
         }
         _cachedBitmapNormal.assign(param2);
         UnknownVarFromPlaneMaterialCellColumn_Int_1 = param3;
         UnknownVarFromPlaneMaterialCellColumn_Int_2 = param4;
         if(_cells.length == 0)
         {
            return UnknownVarFromPlaneMaterialCellColumn_BitmapData_1;
         }
         switch(_repeatMode)
         {
            case 0:
               renderRepeatNone(param2);
               break;
            case 2:
               renderRepeatBorders(param2);
               break;
            case 3:
               renderRepeatCenter(param2);
               break;
            case 4:
               renderRepeatFirst(param2);
               break;
            case 5:
               renderRepeatLast(param2);
               break;
            default:
               renderRepeatAll(param2,param3,param4);
         }
         return UnknownVarFromPlaneMaterialCellColumn_BitmapData_1;
      }
      
      private function getCellsHeight(param1:Array, param2:IVector3d) : int
      {
         var _loc3_:int = 0;
         var _loc5_:PlaneMaterialCell = null;
         var _loc6_:int = 0;
         if(param1 == null || param1.length == 0)
         {
            return 0;
         }
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc5_ = param1[_loc3_] as PlaneMaterialCell;
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_.getHeight(param2);
               _loc4_ += _loc6_;
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      private function renderCells(param1:Array, param2:int, param3:Boolean, param4:IVector3d, param5:int = 0, param6:int = 0) : int
      {
         var _loc8_:int = 0;
         if(param1 == null || param1.length == 0 || UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 == null)
         {
            return param2;
         }
         var _loc9_:PlaneMaterialCell = null;
         var _loc7_:BitmapData = null;
         _loc8_ = 0;
         while(_loc8_ < param1.length)
         {
            if(param3)
            {
               _loc9_ = param1[_loc8_] as PlaneMaterialCell;
            }
            else
            {
               _loc9_ = param1[param1.length - 1 - _loc8_] as PlaneMaterialCell;
            }
            if(_loc9_ != null)
            {
               _loc7_ = _loc9_.render(param4,param5,param6);
               if(_loc7_ != null)
               {
                  if(!param3)
                  {
                     param2 -= _loc7_.height;
                  }
                  UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.copyPixels(_loc7_,_loc7_.rect,new Point(0,param2),_loc7_,null,true);
                  if(param3)
                  {
                     param2 += _loc7_.height;
                  }
                  if(param3 && param2 >= UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height || !param3 && param2 <= 0)
                  {
                     return param2;
                  }
               }
            }
            _loc8_++;
         }
         return param2;
      }
      
      private function renderRepeatNone(param1:IVector3d) : void
      {
         if(_cells.length == 0 || UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 == null)
         {
            return;
         }
         renderCells(_cells,0,true,param1);
      }
      
      private function renderRepeatAll(param1:IVector3d, param2:int, param3:int) : void
      {
         if(_cells.length == 0 || UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 == null)
         {
            return;
         }
         var _loc5_:int = getCellsHeight(_cells,param1);
         var _loc4_:int = 0;
         if(_loc5_ > UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height)
         {
         }
         while(_loc4_ < UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height)
         {
            _loc4_ = renderCells(_cells,_loc4_,true,param1,param2,param3);
            if(_loc4_ == 0)
            {
               return;
            }
         }
      }
      
      private function renderRepeatBorders(param1:IVector3d) : void
      {
         if(_cells.length == 0 || UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 == null)
         {
            return;
         }
         var _loc8_:PlaneMaterialCell = null;
         var _loc5_:BitmapData = null;
         var _loc3_:Array = [];
         var _loc2_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         _loc6_ = 1;
         while(_loc6_ < _cells.length - 1)
         {
            _loc8_ = _cells[_loc6_] as PlaneMaterialCell;
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.getHeight(param1);
               if(_loc9_ > 0)
               {
                  _loc2_ += _loc9_;
                  _loc3_.push(_loc8_);
               }
            }
            _loc6_++;
         }
         if(_cells.length == 1)
         {
            _loc8_ = _cells[0] as PlaneMaterialCell;
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.getHeight(param1);
               if(_loc9_ > 0)
               {
                  _loc2_ += _loc9_;
                  _loc3_.push(_loc8_);
               }
            }
         }
         var _loc4_:* = UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height - _loc2_ >> 1;
         var _loc7_:int = renderCells(_loc3_,_loc4_,true,param1);
         _loc8_ = _cells[0] as PlaneMaterialCell;
         if(_loc8_ != null)
         {
            _loc3_ = [_loc8_];
            while(_loc4_ >= 0)
            {
               _loc4_ = renderCells(_loc3_,_loc4_,false,param1);
            }
         }
         _loc8_ = _cells[_cells.length - 1] as PlaneMaterialCell;
         if(_loc8_ != null)
         {
            _loc3_ = [_loc8_];
            while(_loc7_ < UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height)
            {
               _loc7_ = renderCells(_loc3_,_loc7_,true,param1);
            }
         }
      }
      
      private function renderRepeatCenter(param1:IVector3d) : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:Array = null;
         if(_cells.length == 0 || UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 == null)
         {
            return;
         }
         var _loc5_:PlaneMaterialCell = null;
         var _loc9_:BitmapData = null;
         var _loc11_:Array = [];
         var _loc14_:Array = [];
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         var _loc16_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _cells.length >> 1)
         {
            _loc5_ = _cells[_loc4_] as PlaneMaterialCell;
            if(_loc5_ != null)
            {
               _loc16_ = _loc5_.getHeight(param1);
               if(_loc16_ > 0)
               {
                  _loc10_ += _loc16_;
                  _loc11_.push(_loc5_);
               }
            }
            _loc4_++;
         }
         _loc4_ = (_cells.length >> 1) + 1;
         while(_loc4_ < _cells.length)
         {
            _loc5_ = _cells[_loc4_] as PlaneMaterialCell;
            if(_loc5_ != null)
            {
               _loc16_ = _loc5_.getHeight(param1);
               if(_loc16_ > 0)
               {
                  _loc12_ += _loc16_;
                  _loc14_.push(_loc5_);
               }
            }
            _loc4_++;
         }
         var _loc13_:int = 0;
         var _loc2_:int = 0;
         var _loc15_:int = UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height;
         if(_loc10_ + _loc12_ > UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height)
         {
            _loc13_ = _loc10_ + _loc12_ - UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height;
            _loc2_ -= _loc13_ >> 1;
            _loc15_ += _loc13_ - (_loc13_ >> 1);
         }
         if(_loc13_ == 0)
         {
            _loc5_ = _cells[_cells.length >> 1] as PlaneMaterialCell;
            if(_loc5_ != null)
            {
               _loc16_ = _loc5_.getHeight(param1);
               if(_loc16_ > 0)
               {
                  _loc7_ = UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height - (_loc10_ + _loc12_);
                  _loc6_ = Math.ceil(_loc7_ / _loc16_) * _loc16_;
                  _loc2_ = _loc10_ - (_loc6_ - _loc7_ >> 1);
                  _loc3_ = _loc2_ + _loc6_;
                  _loc8_ = [_loc5_];
                  while(_loc2_ < _loc3_)
                  {
                     _loc2_ = renderCells(_loc8_,_loc2_,true,param1);
                  }
               }
            }
         }
         _loc2_ = 0;
         renderCells(_loc11_,_loc2_,true,param1);
         renderCells(_loc14_,_loc15_,false,param1);
      }
      
      private function renderRepeatFirst(param1:IVector3d) : void
      {
         var _loc2_:Array = null;
         if(_cells.length == 0 || UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 == null)
         {
            return;
         }
         var _loc4_:PlaneMaterialCell = null;
         var _loc3_:int = UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height;
         _loc3_ = renderCells(_cells,_loc3_,false,param1);
         _loc4_ = _cells[0] as PlaneMaterialCell;
         if(_loc4_ != null)
         {
            _loc2_ = [_loc4_];
            while(_loc3_ >= 0)
            {
               _loc3_ = renderCells(_loc2_,_loc3_,false,param1);
            }
         }
      }
      
      private function renderRepeatLast(param1:IVector3d) : void
      {
         var _loc2_:Array = null;
         if(_cells.length == 0 || UnknownVarFromPlaneMaterialCellColumn_BitmapData_1 == null)
         {
            return;
         }
         var _loc4_:PlaneMaterialCell = null;
         var _loc3_:int = 0;
         _loc3_ = renderCells(_cells,_loc3_,true,param1);
         _loc4_ = _cells[_cells.length - 1] as PlaneMaterialCell;
         if(_loc4_ != null)
         {
            _loc2_ = [_loc4_];
            while(_loc3_ < UnknownVarFromPlaneMaterialCellColumn_BitmapData_1.height)
            {
               _loc3_ = renderCells(_loc2_,_loc3_,true,param1);
            }
         }
      }
      
      public function getCells() : Array
      {
         return _cells;
      }
   }
}


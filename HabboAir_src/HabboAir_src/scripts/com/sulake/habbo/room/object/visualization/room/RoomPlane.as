package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.memory.SharedBitmapData;
   import com.sulake.habbo.room.object.visualization.room.mask.PlaneMask;
   import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.UnknownIHabboRoomObjectVisualizationRoomRasterizer1;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterialCell;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterialCellColumn;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterialCellMatrix;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualizationLayer;
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
   import com.sulake.habbo.utils.Canvas;
   import com.sulake.room.object.visualization.IRoomPlane;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomPlane implements IRoomPlane
   {
      public static const UnknownConstFromRoomPlane_Int_1:int = 0;
      
      public static const UnknownConstFromRoomPlane_Int_2:int = 1;
      
      public static const UnknownConstFromPresentFurniWidget_String_1:int = 2;
      
      public static const TYPE_LANDSCAPE:int = 3;
      
      private static var UnknownVarFromRoomPlane_Int_1:int = 1;
      
      private static const ZERO_POINT:Point = new Point(0,0);
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromRoomPlane_Int_2:int = 0;
      
      private var _origin:Vector3d = null;
      
      private var _location:Vector3d = null;
      
      private var _leftSide:Vector3d = null;
      
      private var _rightSide:Vector3d = null;
      
      private var _normal:Vector3d = null;
      
      private var _secondaryNormals:Array;
      
      private var UnknownVarFromRoomPlane_Int_3:int = -1;
      
      private var _type:int = 0;
      
      private var UnknownVarFromRoomPlane_Boolean_1:Boolean = false;
      
      private var _bitmapData:BitmapData = null;
      
      private var _hasTexture:Boolean = true;
      
      private var _offset:Point = null;
      
      private var _relativeDepth:Number = 0;
      
      private var _color:uint = 0;
      
      private var UnknownVarFromRoomPlane_UnknownIHabboRoomObjectVisualizationRoomRasterizer1_1:UnknownIHabboRoomObjectVisualizationRoomRasterizer1 = null;
      
      private var UnknownVarFromRoomPlane_PlaneMaskManager_1:PlaneMaskManager = null;
      
      private var UnknownVarFromRoomPlane_String_1:String = null;
      
      private var _uniqueId:int = 0;
      
      private var UnknownVarFromRoomPlane_Number_1:Number = 0;
      
      private var UnknownVarFromRoomPlane_Number_2:Number = 0;
      
      private var UnknownVarFromRoomPlane_Number_3:Number = 0;
      
      private var UnknownVarFromRoomPlane_Number_4:Number = 0;
      
      private var _textures:Map = null;
      
      private var UnknownVarFromRoomPlane_PlaneBitmapData_1:PlaneBitmapData = null;
      
      private var UnknownVarFromRoomPlane_Boolean_2:Boolean = false;
      
      private var UnknownVarFromRoomPlane_Array_1:Array;
      
      private var UnknownVarFromRoomPlane_Array_2:Array;
      
      private var UnknownVarFromRoomPlane_Boolean_3:Boolean = false;
      
      private var UnknownVarFromRoomPlane_BitmapData_1:BitmapData = null;
      
      private var UnknownVarFromRoomPlane_BitmapData_2:BitmapData = null;
      
      private var UnknownVarFromRoomPlane_Array_3:Array;
      
      private var UnknownVarFromRoomPlane_Array_4:Array;
      
      private var UnknownVarFromRoomPlane_Vector3d_1:Vector3d = null;
      
      private var UnknownVarFromRoomPlane_Vector3d_2:Vector3d = null;
      
      private var UnknownVarFromRoomPlane_Vector3d_3:Vector3d = null;
      
      private var UnknownVarFromRoomPlane_Vector3d_4:Vector3d = null;
      
      private var _width:Number = 0;
      
      private var UnknownVarFromRoomPlane_Number_5:Number = 0;
      
      private var _canBeVisible:Boolean = true;
      
      private var _extraDepth:Number = 0;
      
      private var _isHighlighter:Boolean = false;
      
      public function RoomPlane(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:int, param6:Boolean, param7:Array, param8:int, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:Number = 0)
      {
         var _loc14_:int = 0;
         var _loc15_:IVector3d = null;
         var _loc13_:Vector3d = null;
         _secondaryNormals = [];
         UnknownVarFromRoomPlane_Array_1 = [];
         UnknownVarFromRoomPlane_Array_2 = [];
         UnknownVarFromRoomPlane_Array_3 = [];
         UnknownVarFromRoomPlane_Array_4 = [];
         super();
         UnknownVarFromRoomPlane_Int_2 = param8;
         _origin = new Vector3d();
         _origin.assign(param1);
         _location = new Vector3d();
         _location.assign(param2);
         _leftSide = new Vector3d();
         _leftSide.assign(param3);
         _rightSide = new Vector3d();
         _rightSide.assign(param4);
         _normal = Vector3d.crossProduct(_leftSide,_rightSide);
         if(_normal.length > 0)
         {
            _normal.mul(1 / _normal.length);
         }
         if(param7 != null)
         {
            _loc14_ = 0;
            while(_loc14_ < param7.length)
            {
               _loc15_ = param7[_loc14_] as IVector3d;
               if(_loc15_ != null)
               {
                  _loc13_ = new Vector3d();
                  _loc13_.assign(_loc15_);
                  _secondaryNormals.push(_loc13_);
               }
               _loc14_++;
            }
         }
         _offset = new Point();
         _type = param5;
         _textures = new Map();
         UnknownVarFromRoomPlane_Vector3d_1 = new Vector3d();
         UnknownVarFromRoomPlane_Vector3d_2 = new Vector3d();
         UnknownVarFromRoomPlane_Vector3d_3 = new Vector3d();
         UnknownVarFromRoomPlane_Vector3d_4 = new Vector3d();
         UnknownVarFromRoomPlane_Number_1 = param9;
         UnknownVarFromRoomPlane_Number_2 = param10;
         UnknownVarFromRoomPlane_Number_3 = param11;
         UnknownVarFromRoomPlane_Number_4 = param12;
         UnknownVarFromRoomPlane_Boolean_2 = param6;
         _uniqueId = UnknownVarFromRoomPlane_Int_1++;
      }
      
      private static function blend(param1:uint, param2:uint) : uint
      {
         return Canvas.colorize(param2,param1 | 4278190080) & 0xFFFFFF;
      }
      
      public function set canBeVisible(param1:Boolean) : void
      {
         if(param1 != _canBeVisible)
         {
            if(!_canBeVisible)
            {
               resetTextureCache();
            }
            _canBeVisible = param1;
         }
      }
      
      public function get canBeVisible() : Boolean
      {
         return _canBeVisible;
      }
      
      public function cloneBitmapData() : BitmapData
      {
         var _loc1_:BitmapData = null;
         if(visible)
         {
            if(_bitmapData != null)
            {
               try
               {
                  _loc1_ = _bitmapData.clone();
               }
               catch(e:Error)
               {
                  return null;
               }
            }
         }
         return _loc1_;
      }
      
      public function get visible() : Boolean
      {
         return UnknownVarFromRoomPlane_Boolean_1 && _canBeVisible;
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
      
      public function get relativeDepth() : Number
      {
         return _relativeDepth + _extraDepth;
      }
      
      public function set extraDepth(param1:Number) : void
      {
         this._extraDepth = param1;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get leftSide() : IVector3d
      {
         return _leftSide;
      }
      
      public function get rightSide() : IVector3d
      {
         return _rightSide;
      }
      
      public function get location() : IVector3d
      {
         return _location;
      }
      
      public function get normal() : IVector3d
      {
         return _normal;
      }
      
      public function get hasTexture() : Boolean
      {
         return _hasTexture;
      }
      
      public function set hasTexture(param1:Boolean) : void
      {
         _hasTexture = param1;
      }
      
      public function set rasterizer(param1:UnknownIHabboRoomObjectVisualizationRoomRasterizer1) : void
      {
         UnknownVarFromRoomPlane_UnknownIHabboRoomObjectVisualizationRoomRasterizer1_1 = param1;
      }
      
      public function set maskManager(param1:PlaneMaskManager) : void
      {
         UnknownVarFromRoomPlane_PlaneMaskManager_1 = param1;
      }
      
      public function set id(param1:String) : void
      {
         if(param1 != UnknownVarFromRoomPlane_String_1)
         {
            resetTextureCache();
            UnknownVarFromRoomPlane_String_1 = param1;
         }
      }
      
      public function get uniqueId() : int
      {
         return _uniqueId;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlaneBitmapData = null;
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
         if(_textures != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _textures.length)
            {
               _loc1_ = _textures.getWithIndex(_loc2_) as PlaneBitmapData;
               if(_loc1_ != null)
               {
                  if(_loc1_.bitmap != null)
                  {
                     _loc1_.bitmap.dispose();
                  }
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            _textures.dispose();
            _textures = null;
         }
         UnknownVarFromRoomPlane_PlaneBitmapData_1 = null;
         _location = null;
         _origin = null;
         _leftSide = null;
         _rightSide = null;
         _normal = null;
         UnknownVarFromRoomPlane_UnknownIHabboRoomObjectVisualizationRoomRasterizer1_1 = null;
         UnknownVarFromRoomPlane_Vector3d_1 = null;
         UnknownVarFromRoomPlane_Vector3d_2 = null;
         UnknownVarFromRoomPlane_Vector3d_3 = null;
         UnknownVarFromRoomPlane_Vector3d_4 = null;
         UnknownVarFromRoomPlane_Array_1 = null;
         UnknownVarFromRoomPlane_Array_2 = null;
         if(UnknownVarFromRoomPlane_BitmapData_1 != null)
         {
            UnknownVarFromRoomPlane_BitmapData_1.dispose();
            UnknownVarFromRoomPlane_BitmapData_1 = null;
         }
         if(UnknownVarFromRoomPlane_BitmapData_2 != null)
         {
            UnknownVarFromRoomPlane_BitmapData_2.dispose();
            UnknownVarFromRoomPlane_BitmapData_2 = null;
         }
         _disposed = true;
      }
      
      public function copyBitmapData(param1:BitmapData) : BitmapData
      {
         if(visible)
         {
            if(_bitmapData != null && param1 != null)
            {
               if(_bitmapData.width == param1.width && _bitmapData.height == param1.height)
               {
                  param1.copyPixels(_bitmapData,_bitmapData.rect,ZERO_POINT);
                  return param1;
               }
            }
         }
         return null;
      }
      
      private function cacheTexture(param1:String, param2:PlaneBitmapData) : Boolean
      {
         var _loc3_:PlaneBitmapData = _textures.remove(param1) as PlaneBitmapData;
         if(_loc3_ != null)
         {
            if(param2 != null && param2.bitmap != _loc3_.bitmap)
            {
               _loc3_.bitmap.dispose();
            }
            _loc3_.dispose();
         }
         UnknownVarFromRoomPlane_PlaneBitmapData_1 = param2;
         _textures.add(param1,param2);
         return true;
      }
      
      private function resetTextureCache(param1:BitmapData = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PlaneBitmapData = null;
         if(_textures != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _textures.length)
            {
               _loc2_ = _textures.getWithIndex(_loc3_) as PlaneBitmapData;
               if(_loc2_ != null)
               {
                  if(_loc2_.bitmap != null && _loc2_.bitmap != param1)
                  {
                     _loc2_.bitmap.dispose();
                  }
                  _loc2_.dispose();
               }
               _loc3_++;
            }
            _textures.reset();
         }
         UnknownVarFromRoomPlane_PlaneBitmapData_1 = null;
      }
      
      private function getTextureIdentifier(param1:Number) : String
      {
         if(UnknownVarFromRoomPlane_UnknownIHabboRoomObjectVisualizationRoomRasterizer1_1 != null)
         {
            return UnknownVarFromRoomPlane_UnknownIHabboRoomObjectVisualizationRoomRasterizer1_1.getTextureIdentifier(param1,normal);
         }
         return String(param1);
      }
      
      private function needsNewTexture(param1:IRoomGeometry, param2:int) : Boolean
      {
         var _loc3_:String = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc4_:PlaneBitmapData = UnknownVarFromRoomPlane_PlaneBitmapData_1;
         if(_loc4_ == null)
         {
            _loc3_ = getTextureIdentifier(param1.scale);
            _loc4_ = _textures.getValue(_loc3_) as PlaneBitmapData;
         }
         updateMaskChangeStatus();
         if(_canBeVisible && (_loc4_ == null || _loc4_.timeStamp >= 0 && param2 > _loc4_.timeStamp || UnknownVarFromRoomPlane_Boolean_3))
         {
            return true;
         }
         return false;
      }
      
      private function getTexture(param1:IRoomGeometry, param2:int) : BitmapData
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc4_:IVector3d = null;
         var _loc6_:BitmapData = null;
         var _loc5_:BitmapData = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc7_:PlaneBitmapData = null;
         var _loc3_:String = null;
         if(needsNewTexture(param1,param2))
         {
            _loc8_ = _leftSide.length * param1.scale;
            _loc9_ = _rightSide.length * param1.scale;
            _loc4_ = param1.getCoordinatePosition(_normal);
            _loc3_ = getTextureIdentifier(param1.scale);
            if(UnknownVarFromRoomPlane_PlaneBitmapData_1 != null)
            {
               _loc7_ = UnknownVarFromRoomPlane_PlaneBitmapData_1;
            }
            else
            {
               _loc7_ = _textures.getValue(_loc3_) as PlaneBitmapData;
            }
            _loc6_ = null;
            if(_loc7_ != null)
            {
               _loc6_ = _loc7_.bitmap;
            }
            if(UnknownVarFromRoomPlane_UnknownIHabboRoomObjectVisualizationRoomRasterizer1_1 != null)
            {
               _loc7_ = UnknownVarFromRoomPlane_UnknownIHabboRoomObjectVisualizationRoomRasterizer1_1.render(_loc6_,UnknownVarFromRoomPlane_String_1,_loc8_,_loc9_,param1.scale,_loc4_,_hasTexture,UnknownVarFromRoomPlane_Number_1,UnknownVarFromRoomPlane_Number_2,UnknownVarFromRoomPlane_Number_3,UnknownVarFromRoomPlane_Number_4,param2);
               if(_loc7_ != null)
               {
                  if(_loc6_ != null && _loc7_.bitmap != _loc6_)
                  {
                     _loc6_.dispose();
                  }
               }
            }
            else
            {
               _loc5_ = new BitmapData(_loc8_,_loc9_,true,4278190080 | _color);
               _loc7_ = new PlaneBitmapData(_loc5_,-1);
            }
            if(_loc7_ != null)
            {
               updateMask(_loc7_.bitmap,param1);
               cacheTexture(_loc3_,_loc7_);
            }
         }
         else if(UnknownVarFromRoomPlane_PlaneBitmapData_1 != null)
         {
            _loc7_ = UnknownVarFromRoomPlane_PlaneBitmapData_1;
         }
         else
         {
            _loc3_ = getTextureIdentifier(param1.scale);
            _loc7_ = _textures.getValue(_loc3_) as PlaneBitmapData;
         }
         if(_loc7_ != null)
         {
            UnknownVarFromRoomPlane_PlaneBitmapData_1 = _loc7_;
            return _loc7_.bitmap;
         }
         return null;
      }
      
      private function resolveMasks(param1:IRoomGeometry) : PlaneDrawingData
      {
         var _loc8_:int = 0;
         var _loc10_:PlaneMask = null;
         var _loc5_:String = null;
         var _loc4_:IVector3d = null;
         var _loc11_:IGraphicAsset = null;
         var _loc9_:Point = null;
         if(!UnknownVarFromRoomPlane_Boolean_2)
         {
            return null;
         }
         var _loc7_:RoomPlaneBitmapMask = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:PlaneDrawingData = new PlaneDrawingData();
         _loc8_ = 0;
         while(_loc8_ < UnknownVarFromRoomPlane_Array_1.length)
         {
            _loc7_ = UnknownVarFromRoomPlane_Array_1[_loc8_] as RoomPlaneBitmapMask;
            if(_loc7_ != null)
            {
               _loc10_ = UnknownVarFromRoomPlane_PlaneMaskManager_1.getMask(_loc7_.type);
               if(_loc10_ != null)
               {
                  _loc5_ = _loc10_.getAssetName(param1.scale);
                  if(_loc5_ != null)
                  {
                     _loc4_ = param1.getCoordinatePosition(_normal);
                     _loc11_ = _loc10_.getGraphicAsset(param1.scale,_loc4_);
                     if(_loc11_ != null)
                     {
                        _loc2_ = UnknownVarFromRoomPlane_BitmapData_1.width * (1 - _loc7_.leftSideLoc / _leftSide.length);
                        _loc3_ = UnknownVarFromRoomPlane_BitmapData_1.height * (1 - _loc7_.rightSideLoc / _rightSide.length);
                        _loc9_ = new Point(_loc2_ + _loc11_.offsetX,_loc3_ + _loc11_.offsetY);
                        _loc6_.addMask(_loc5_,_loc9_,_loc11_.flipH,_loc11_.flipV);
                     }
                  }
               }
            }
            _loc8_++;
         }
         return _loc6_;
      }
      
      private function screenWidth(param1:IRoomGeometry) : int
      {
         var _loc2_:Point = param1.getScreenPoint(new Vector3d(0,0,0));
         var _loc3_:Point = param1.getScreenPoint(new Vector3d(0,1,0));
         return Math.round(_leftSide.length * Math.abs(_loc2_.x - _loc3_.x));
      }
      
      public function getDrawingDatas(param1:IRoomGeometry) : Array
      {
         var _loc5_:PlaneDrawingData = null;
         var _loc4_:PlaneDrawingData = null;
         var _loc11_:Array = null;
         var _loc10_:PlaneVisualizationLayer = null;
         var _loc7_:int = 0;
         var _loc2_:IVector3d = null;
         var _loc8_:PlaneMaterialCellMatrix = null;
         var _loc3_:Array = null;
         var _loc12_:String = null;
         var _loc13_:Array = [];
         if(UnknownVarFromRoomPlane_Boolean_1)
         {
            _loc5_ = null;
            try
            {
               _loc5_ = resolveMasks(param1);
               _loc11_ = UnknownVarFromRoomPlane_UnknownIHabboRoomObjectVisualizationRoomRasterizer1_1.getLayers(UnknownVarFromRoomPlane_String_1);
               _loc7_ = 0;
               while(_loc7_ < _loc11_.length)
               {
                  _loc10_ = _loc11_[_loc7_] as PlaneVisualizationLayer;
                  if(_loc10_ != null)
                  {
                     if(_hasTexture && _loc10_.getMaterial() != null)
                     {
                        _loc2_ = param1.getCoordinatePosition(_normal);
                        _loc8_ = _loc10_.getMaterial().getMaterialCellMatrix(_loc2_);
                        _loc4_ = new PlaneDrawingData(_loc5_,blend(_color,_loc10_.getColor()),_loc8_.isBottomAligned());
                        Randomizer.setSeed(UnknownVarFromRoomPlane_Int_2);
                        for each(var _loc6_ in _loc8_.getColumns(screenWidth(param1)))
                        {
                           _loc3_ = [];
                           for each(var _loc9_ in _loc6_.getCells())
                           {
                              _loc12_ = _loc9_.getAssetName(_loc2_);
                              if(_loc12_ != null)
                              {
                                 _loc3_.push(_loc12_);
                              }
                           }
                           if(_loc3_.length > 0)
                           {
                              if(!_loc6_.isRepeated())
                              {
                                 _loc3_.push("");
                              }
                              _loc4_.addAssetColumn(_loc3_);
                           }
                        }
                        if(_loc4_.assetNameColumns.length > 0)
                        {
                           _loc13_.push(_loc4_);
                        }
                     }
                     else
                     {
                        _loc4_ = new PlaneDrawingData(_loc5_,blend(_color,_loc10_.getColor()));
                        _loc13_.push(_loc4_);
                     }
                  }
                  _loc7_++;
               }
            }
            catch(e:Error)
            {
               Logger.log("Error in getting RoomPlane drawing data.",e);
            }
            if(_loc13_.length == 0)
            {
               _loc13_.push(new PlaneDrawingData(_loc5_,_color));
            }
         }
         return _loc13_;
      }
      
      private function addOutlines(param1:PlaneBitmapData) : void
      {
      }
      
      public function update(param1:IRoomGeometry, param2:int) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc8_:int = 0;
         var _loc4_:IVector3d = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:BitmapData = null;
         if(param1 == null || _disposed)
         {
            return false;
         }
         var _loc9_:Boolean = false;
         if(UnknownVarFromRoomPlane_Int_3 != param1.updateId)
         {
            _loc9_ = true;
         }
         if(!_loc9_ || !_canBeVisible)
         {
            if(!visible)
            {
               return false;
            }
         }
         if(_loc9_)
         {
            UnknownVarFromRoomPlane_PlaneBitmapData_1 = null;
            _loc3_ = 0;
            _loc3_ = Vector3d.cosAngle(param1.directionAxis,normal);
            if(_loc3_ > -0.001)
            {
               if(UnknownVarFromRoomPlane_Boolean_1)
               {
                  UnknownVarFromRoomPlane_Boolean_1 = false;
                  return true;
               }
               return false;
            }
            _loc8_ = 0;
            while(_loc8_ < _secondaryNormals.length)
            {
               _loc3_ = Vector3d.cosAngle(param1.directionAxis,_secondaryNormals[_loc8_]);
               if(_loc3_ > -0.001)
               {
                  if(UnknownVarFromRoomPlane_Boolean_1)
                  {
                     UnknownVarFromRoomPlane_Boolean_1 = false;
                     return true;
                  }
                  return false;
               }
               _loc8_++;
            }
            updateCorners(param1);
            _loc4_ = param1.getScreenPosition(_origin);
            _loc5_ = _loc4_.z;
            _loc6_ = Math.max(UnknownVarFromRoomPlane_Vector3d_1.z,UnknownVarFromRoomPlane_Vector3d_2.z,UnknownVarFromRoomPlane_Vector3d_3.z,UnknownVarFromRoomPlane_Vector3d_4.z) - _loc5_;
            if(_type == 2)
            {
               _loc6_ -= (_location.z + Math.min(0,_leftSide.z,_rightSide.z)) * 8;
            }
            if(_type == 3)
            {
               _loc6_ += 0.02;
            }
            _relativeDepth = _loc6_;
            UnknownVarFromRoomPlane_Boolean_1 = true;
            UnknownVarFromRoomPlane_Int_3 = param1.updateId;
         }
         if(_loc9_ || needsNewTexture(param1,param2))
         {
            if(_bitmapData == null || _width != _bitmapData.width || UnknownVarFromRoomPlane_Number_5 != _bitmapData.height)
            {
               if(_bitmapData != null)
               {
                  _bitmapData.dispose();
                  _bitmapData = null;
                  if(_width < 1 || UnknownVarFromRoomPlane_Number_5 < 1)
                  {
                     return true;
                  }
               }
               else if(_width < 1 || UnknownVarFromRoomPlane_Number_5 < 1)
               {
                  return false;
               }
               try
               {
                  _bitmapData = new SharedBitmapData(_width,UnknownVarFromRoomPlane_Number_5,true,16777215,false);
               }
               catch(e:Error)
               {
                  _bitmapData = null;
                  dispose();
               }
               if(_bitmapData == null)
               {
                  return false;
               }
               _bitmapData.lock();
            }
            else
            {
               _bitmapData.lock();
               _bitmapData.fillRect(_bitmapData.rect,16777215);
            }
            Randomizer.setSeed(UnknownVarFromRoomPlane_Int_2);
            _loc7_ = getTexture(param1,param2);
            if(_loc7_ != null)
            {
               renderTexture(param1,_loc7_);
               _bitmapData.unlock();
               return _loc7_ || _loc9_;
            }
            dispose();
            return false;
         }
         return false;
      }
      
      private function updateCorners(param1:IRoomGeometry) : void
      {
         UnknownVarFromRoomPlane_Vector3d_1.assign(param1.getScreenPosition(_location));
         UnknownVarFromRoomPlane_Vector3d_2.assign(param1.getScreenPosition(Vector3d.sum(_location,_rightSide)));
         UnknownVarFromRoomPlane_Vector3d_3.assign(param1.getScreenPosition(Vector3d.sum(Vector3d.sum(_location,_leftSide),_rightSide)));
         UnknownVarFromRoomPlane_Vector3d_4.assign(param1.getScreenPosition(Vector3d.sum(_location,_leftSide)));
         _offset = param1.getScreenPoint(_origin);
         UnknownVarFromRoomPlane_Vector3d_1.x = Math.round(UnknownVarFromRoomPlane_Vector3d_1.x);
         UnknownVarFromRoomPlane_Vector3d_1.y = Math.round(UnknownVarFromRoomPlane_Vector3d_1.y);
         UnknownVarFromRoomPlane_Vector3d_2.x = Math.round(UnknownVarFromRoomPlane_Vector3d_2.x);
         UnknownVarFromRoomPlane_Vector3d_2.y = Math.round(UnknownVarFromRoomPlane_Vector3d_2.y);
         UnknownVarFromRoomPlane_Vector3d_3.x = Math.round(UnknownVarFromRoomPlane_Vector3d_3.x);
         UnknownVarFromRoomPlane_Vector3d_3.y = Math.round(UnknownVarFromRoomPlane_Vector3d_3.y);
         UnknownVarFromRoomPlane_Vector3d_4.x = Math.round(UnknownVarFromRoomPlane_Vector3d_4.x);
         UnknownVarFromRoomPlane_Vector3d_4.y = Math.round(UnknownVarFromRoomPlane_Vector3d_4.y);
         _offset.x = Math.round(_offset.x);
         _offset.y = Math.round(_offset.y);
         var _loc3_:Number = Math.min(UnknownVarFromRoomPlane_Vector3d_1.x,UnknownVarFromRoomPlane_Vector3d_2.x,UnknownVarFromRoomPlane_Vector3d_3.x,UnknownVarFromRoomPlane_Vector3d_4.x);
         var _loc5_:Number = Math.max(UnknownVarFromRoomPlane_Vector3d_1.x,UnknownVarFromRoomPlane_Vector3d_2.x,UnknownVarFromRoomPlane_Vector3d_3.x,UnknownVarFromRoomPlane_Vector3d_4.x);
         var _loc2_:Number = Math.min(UnknownVarFromRoomPlane_Vector3d_1.y,UnknownVarFromRoomPlane_Vector3d_2.y,UnknownVarFromRoomPlane_Vector3d_3.y,UnknownVarFromRoomPlane_Vector3d_4.y);
         var _loc4_:Number = Math.max(UnknownVarFromRoomPlane_Vector3d_1.y,UnknownVarFromRoomPlane_Vector3d_2.y,UnknownVarFromRoomPlane_Vector3d_3.y,UnknownVarFromRoomPlane_Vector3d_4.y);
         _loc5_ -= _loc3_;
         _offset.x -= _loc3_;
         UnknownVarFromRoomPlane_Vector3d_1.x -= _loc3_;
         UnknownVarFromRoomPlane_Vector3d_2.x -= _loc3_;
         UnknownVarFromRoomPlane_Vector3d_3.x -= _loc3_;
         UnknownVarFromRoomPlane_Vector3d_4.x -= _loc3_;
         _loc4_ -= _loc2_;
         _offset.y -= _loc2_;
         UnknownVarFromRoomPlane_Vector3d_1.y -= _loc2_;
         UnknownVarFromRoomPlane_Vector3d_2.y -= _loc2_;
         UnknownVarFromRoomPlane_Vector3d_3.y -= _loc2_;
         UnknownVarFromRoomPlane_Vector3d_4.y -= _loc2_;
         _width = _loc5_;
         UnknownVarFromRoomPlane_Number_5 = _loc4_;
      }
      
      private function renderTexture(param1:IRoomGeometry, param2:BitmapData) : void
      {
         if(UnknownVarFromRoomPlane_Vector3d_1 == null || UnknownVarFromRoomPlane_Vector3d_2 == null || UnknownVarFromRoomPlane_Vector3d_3 == null || UnknownVarFromRoomPlane_Vector3d_4 == null || param2 == null || _bitmapData == null)
         {
            return;
         }
         var _loc8_:Number = UnknownVarFromRoomPlane_Vector3d_4.x - UnknownVarFromRoomPlane_Vector3d_3.x;
         var _loc10_:Number = UnknownVarFromRoomPlane_Vector3d_4.y - UnknownVarFromRoomPlane_Vector3d_3.y;
         var _loc4_:Number = UnknownVarFromRoomPlane_Vector3d_2.x - UnknownVarFromRoomPlane_Vector3d_3.x;
         var _loc3_:Number = UnknownVarFromRoomPlane_Vector3d_2.y - UnknownVarFromRoomPlane_Vector3d_3.y;
         if(_type == 1 || _type == 3)
         {
            if(Math.abs(_loc4_ - param2.width) <= 1)
            {
               _loc4_ = param2.width;
            }
            if(Math.abs(_loc3_ - param2.width) <= 1)
            {
               _loc3_ = param2.width;
            }
            if(Math.abs(_loc8_ - param2.height) <= 1)
            {
               _loc8_ = param2.height;
            }
            if(Math.abs(_loc10_ - param2.height) <= 1)
            {
               _loc10_ = param2.height;
            }
         }
         var _loc5_:Number = _loc4_ / param2.width;
         var _loc6_:Number = _loc3_ / param2.width;
         var _loc7_:Number = _loc8_ / param2.height;
         var _loc9_:Number = _loc10_ / param2.height;
         var _loc11_:Matrix = new Matrix();
         _loc11_.a = _loc5_;
         _loc11_.b = _loc6_;
         _loc11_.c = _loc7_;
         _loc11_.d = _loc9_;
         _loc11_.translate(UnknownVarFromRoomPlane_Vector3d_3.x,UnknownVarFromRoomPlane_Vector3d_3.y);
         draw(param2,_loc11_);
      }
      
      private function draw(param1:BitmapData, param2:Matrix) : void
      {
         var _loc4_:int = 0;
         var _loc7_:* = 0;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(_bitmapData != null)
         {
            if(param2.a == 1 && param2.d == 1 && param2.c == 0 && param2.b != 0 && Math.abs(param2.b) <= 1 && (_type == 1 || _type == 3))
            {
               _loc4_ = 0;
               _loc7_ = 0;
               _loc3_ = 0;
               _loc6_ = 0;
               if(param2.b > 0)
               {
                  param2.ty++;
               }
               _loc5_ = 0;
               while(_loc4_ < param1.width)
               {
                  _loc4_++;
                  _loc3_ += Math.abs(param2.b);
                  if(_loc3_ >= 1)
                  {
                     _bitmapData.copyPixels(param1,new Rectangle(_loc7_ + _loc6_,0,_loc4_ - _loc7_,param1.height),new Point(param2.tx + _loc7_,param2.ty + _loc5_),null,null,true);
                     _loc7_ = _loc4_;
                     if(param2.b > 0)
                     {
                        _loc5_++;
                     }
                     else
                     {
                        _loc5_--;
                     }
                     _loc3_ = 0;
                  }
               }
               if(_loc3_ > 0)
               {
                  _bitmapData.copyPixels(param1,new Rectangle(_loc7_,0,_loc4_ - _loc7_,param1.height),new Point(param2.tx + _loc7_,param2.ty + _loc5_),null,null,true);
               }
               return;
            }
            _bitmapData.draw(param1,param2,null,null,null,false);
         }
      }
      
      public function resetBitmapMasks() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromRoomPlane_Boolean_2)
         {
            if(UnknownVarFromRoomPlane_Array_1.length == 0)
            {
               return;
            }
            UnknownVarFromRoomPlane_Boolean_3 = true;
            UnknownVarFromRoomPlane_Array_1 = [];
         }
      }
      
      public function addBitmapMask(param1:String, param2:Number, param3:Number) : Boolean
      {
         var _loc5_:RoomPlaneBitmapMask = null;
         var _loc4_:int = 0;
         if(UnknownVarFromRoomPlane_Boolean_2)
         {
            _loc5_ = null;
            _loc4_ = 0;
            while(_loc4_ < UnknownVarFromRoomPlane_Array_1.length)
            {
               _loc5_ = UnknownVarFromRoomPlane_Array_1[_loc4_] as RoomPlaneBitmapMask;
               if(_loc5_ != null)
               {
                  if(_loc5_.type == param1 && _loc5_.leftSideLoc == param2 && _loc5_.rightSideLoc == param3)
                  {
                     return false;
                  }
               }
               _loc4_++;
            }
            _loc5_ = new RoomPlaneBitmapMask(param1,param2,param3);
            UnknownVarFromRoomPlane_Array_1.push(_loc5_);
            UnknownVarFromRoomPlane_Boolean_3 = true;
            return true;
         }
         return false;
      }
      
      public function resetRectangleMasks() : void
      {
         if(UnknownVarFromRoomPlane_Boolean_2)
         {
            if(UnknownVarFromRoomPlane_Array_2.length == 0)
            {
               return;
            }
            UnknownVarFromRoomPlane_Boolean_3 = true;
            UnknownVarFromRoomPlane_Array_2 = [];
         }
      }
      
      public function addRectangleMask(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean
      {
         var _loc6_:RoomPlaneRectangleMask = null;
         var _loc5_:int = 0;
         if(UnknownVarFromRoomPlane_Boolean_2)
         {
            _loc6_ = null;
            _loc5_ = 0;
            while(_loc5_ < UnknownVarFromRoomPlane_Array_2.length)
            {
               _loc6_ = UnknownVarFromRoomPlane_Array_2[_loc5_] as RoomPlaneRectangleMask;
               if(_loc6_ != null)
               {
                  if(_loc6_.leftSideLoc == param1 && _loc6_.rightSideLoc == param2 && _loc6_.leftSideLength == param3 && _loc6_.rightSideLength == param4)
                  {
                     return false;
                  }
               }
               _loc5_++;
            }
            _loc6_ = new RoomPlaneRectangleMask(param1,param2,param3,param4);
            UnknownVarFromRoomPlane_Array_2.push(_loc6_);
            UnknownVarFromRoomPlane_Boolean_3 = true;
            return true;
         }
         return false;
      }
      
      private function updateMaskChangeStatus() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:RoomPlaneBitmapMask = null;
         if(!UnknownVarFromRoomPlane_Boolean_3)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:Boolean = true;
         var _loc7_:RoomPlaneBitmapMask = null;
         var _loc1_:RoomPlaneRectangleMask = null;
         if(UnknownVarFromRoomPlane_Array_1.length == UnknownVarFromRoomPlane_Array_3.length)
         {
            _loc4_;
            while(_loc4_ < UnknownVarFromRoomPlane_Array_1.length)
            {
               _loc7_ = UnknownVarFromRoomPlane_Array_1[_loc4_] as RoomPlaneBitmapMask;
               if(_loc7_ != null)
               {
                  _loc2_ = false;
                  _loc6_;
                  while(_loc6_ < UnknownVarFromRoomPlane_Array_3.length)
                  {
                     _loc3_ = UnknownVarFromRoomPlane_Array_3[_loc6_] as RoomPlaneBitmapMask;
                     if(_loc3_ != null)
                     {
                        if(_loc3_.type == _loc7_.type && _loc3_.leftSideLoc == _loc7_.leftSideLoc && _loc3_.rightSideLoc == _loc7_.rightSideLoc)
                        {
                           _loc2_ = true;
                           break;
                        }
                     }
                     _loc6_++;
                  }
                  if(!_loc2_)
                  {
                     _loc5_ = false;
                     break;
                  }
               }
               _loc4_++;
            }
         }
         else
         {
            _loc5_ = false;
         }
         if(UnknownVarFromRoomPlane_Array_2.length > UnknownVarFromRoomPlane_Array_4.length)
         {
            _loc5_ = false;
         }
         if(_loc5_)
         {
            UnknownVarFromRoomPlane_Boolean_3 = false;
         }
      }
      
      private function updateMask(param1:BitmapData, param2:IRoomGeometry) : void
      {
         var _loc3_:IVector3d = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:String = null;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         if(!UnknownVarFromRoomPlane_Boolean_2 || UnknownVarFromRoomPlane_Array_1.length == 0 && UnknownVarFromRoomPlane_Array_2.length == 0 && !UnknownVarFromRoomPlane_Boolean_3 || UnknownVarFromRoomPlane_PlaneMaskManager_1 == null)
         {
            return;
         }
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc13_:RoomPlaneBitmapMask = null;
         var _loc4_:RoomPlaneRectangleMask = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         updateMaskChangeStatus();
         var _loc12_:Number = param1.width;
         var _loc14_:Number = param1.height;
         if(UnknownVarFromRoomPlane_BitmapData_1 == null || UnknownVarFromRoomPlane_BitmapData_1.width != _loc12_ || UnknownVarFromRoomPlane_BitmapData_1.height != _loc14_)
         {
            if(UnknownVarFromRoomPlane_BitmapData_1 != null)
            {
               UnknownVarFromRoomPlane_BitmapData_1.dispose();
               UnknownVarFromRoomPlane_BitmapData_1 = null;
            }
            try
            {
               UnknownVarFromRoomPlane_BitmapData_1 = new BitmapData(_loc12_,_loc14_,true,16777215);
            }
            catch(e:Error)
            {
               UnknownVarFromRoomPlane_BitmapData_1 = null;
               return;
            }
            UnknownVarFromRoomPlane_Boolean_3 = true;
         }
         if(UnknownVarFromRoomPlane_Boolean_3)
         {
            UnknownVarFromRoomPlane_Array_3 = [];
            UnknownVarFromRoomPlane_Array_4 = [];
            if(UnknownVarFromRoomPlane_BitmapData_1 != null)
            {
               UnknownVarFromRoomPlane_BitmapData_1.fillRect(UnknownVarFromRoomPlane_BitmapData_1.rect,16777215);
            }
            resetTextureCache(param1);
            _loc3_ = param2.getCoordinatePosition(_normal);
            _loc10_ = 0;
            _loc11_ = 0;
            _loc5_ = 0;
            while(_loc5_ < UnknownVarFromRoomPlane_Array_1.length)
            {
               _loc13_ = UnknownVarFromRoomPlane_Array_1[_loc5_] as RoomPlaneBitmapMask;
               if(_loc13_ != null)
               {
                  _loc10_ = UnknownVarFromRoomPlane_BitmapData_1.width - UnknownVarFromRoomPlane_BitmapData_1.width * _loc13_.leftSideLoc / _leftSide.length;
                  _loc11_ = UnknownVarFromRoomPlane_BitmapData_1.height - UnknownVarFromRoomPlane_BitmapData_1.height * _loc13_.rightSideLoc / _rightSide.length;
                  _loc7_ = _loc13_.type;
                  UnknownVarFromRoomPlane_PlaneMaskManager_1.updateMask(UnknownVarFromRoomPlane_BitmapData_1,_loc7_,param2.scale,_loc3_,_loc10_,_loc11_);
                  UnknownVarFromRoomPlane_Array_3.push(new RoomPlaneBitmapMask(_loc7_,_loc13_.leftSideLoc,_loc13_.rightSideLoc));
               }
               _loc5_++;
            }
            _loc6_ = 0;
            while(_loc6_ < UnknownVarFromRoomPlane_Array_2.length)
            {
               _loc4_ = UnknownVarFromRoomPlane_Array_2[_loc6_] as RoomPlaneRectangleMask;
               if(_loc4_ != null)
               {
                  _loc10_ = UnknownVarFromRoomPlane_BitmapData_1.width - UnknownVarFromRoomPlane_BitmapData_1.width * _loc4_.leftSideLoc / _leftSide.length;
                  _loc11_ = UnknownVarFromRoomPlane_BitmapData_1.height - UnknownVarFromRoomPlane_BitmapData_1.height * _loc4_.rightSideLoc / _rightSide.length;
                  _loc9_ = UnknownVarFromRoomPlane_BitmapData_1.width * _loc4_.leftSideLength / _leftSide.length;
                  _loc8_ = UnknownVarFromRoomPlane_BitmapData_1.height * _loc4_.rightSideLength / _rightSide.length;
                  UnknownVarFromRoomPlane_BitmapData_1.fillRect(new Rectangle(_loc10_ - _loc9_,_loc11_ - _loc8_,_loc9_,_loc8_),4278190080);
                  UnknownVarFromRoomPlane_Array_4.push(new RoomPlaneRectangleMask(_loc4_.leftSideLength,_loc4_.rightSideLoc,_loc4_.leftSideLength,_loc4_.rightSideLength));
               }
               _loc6_++;
            }
            UnknownVarFromRoomPlane_Boolean_3 = false;
         }
         combineTextureMask(param1,UnknownVarFromRoomPlane_BitmapData_1);
      }
      
      private function combineTextureMask(param1:BitmapData, param2:BitmapData) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(UnknownVarFromRoomPlane_BitmapData_2 != null && (UnknownVarFromRoomPlane_BitmapData_2.width != param1.width || UnknownVarFromRoomPlane_BitmapData_2.height != param1.height))
         {
            UnknownVarFromRoomPlane_BitmapData_2.dispose();
            UnknownVarFromRoomPlane_BitmapData_2 = null;
         }
         if(UnknownVarFromRoomPlane_BitmapData_2 == null)
         {
            try
            {
               UnknownVarFromRoomPlane_BitmapData_2 = new BitmapData(param1.width,param1.height,true,4294967295);
            }
            catch(e:Error)
            {
               if(UnknownVarFromRoomPlane_BitmapData_2)
               {
                  UnknownVarFromRoomPlane_BitmapData_2.dispose();
               }
               UnknownVarFromRoomPlane_BitmapData_2 = null;
               return;
            }
         }
         UnknownVarFromRoomPlane_BitmapData_2.copyChannel(param1,param1.rect,ZERO_POINT,8,1);
         UnknownVarFromRoomPlane_BitmapData_2.draw(param2,null,null,"darken");
         param1.copyChannel(UnknownVarFromRoomPlane_BitmapData_2,UnknownVarFromRoomPlane_BitmapData_2.rect,ZERO_POINT,1,8);
      }
      
      public function get isHighlighter() : Boolean
      {
         return _isHighlighter;
      }
      
      public function set isHighlighter(param1:Boolean) : void
      {
         _isHighlighter = param1;
      }
   }
}


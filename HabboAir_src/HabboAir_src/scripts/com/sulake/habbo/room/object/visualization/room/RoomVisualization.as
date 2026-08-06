package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.habbo.room.object.RoomPlaneBitmapMaskParser;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.enum.RoomObjectSpriteType;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.IRoomPlane;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.object.visualization.UnknownIRoomObjectVisualization1;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class RoomVisualization extends RoomObjectSpriteVisualization implements UnknownIRoomObjectVisualization1
   {
      public static const UnknownConstFromRoomVisualization_Int_1:int = 16777215;
      
      public static const UnknownConstFromRoomVisualization_Int_2:int = 14540253;
      
      public static const FLOOR_COLOR_RIGHT:int = 12303291;
      
      private static const UnknownConstFromRoomVisualization_Int_3:int = 16777215;
      
      private static const WALL_COLOR_SIDE:int = 13421772;
      
      private static const WALL_COLOR_BOTTOM:int = 10066329;
      
      private static const WALL_COLOR_BORDER:int = 10066329;
      
      public static const LANDSCAPE_COLOR_TOP:int = 16777215;
      
      public static const LANDSCAPE_COLOR_SIDE:int = 13421772;
      
      public static const LANDSCAPE_COLOR_BOTTOM:int = 10066329;
      
      private static const ROOM_DEPTH_OFFSET:Number = 1000;
      
      protected var UnknownVarFromRoomVisualization_RoomVisualizationData_1:RoomVisualizationData = null;
      
      private var UnknownVarFromRoomVisualization_AssetLibrary_1:AssetLibrary = null;
      
      private var UnknownVarFromRoomVisualization_RoomPlaneParser_1:RoomPlaneParser = null;
      
      private var _planes:Array = [];
      
      private var UnknownVarFromRoomVisualization_Dictionary_1:Dictionary = new Dictionary();
      
      private var UnknownVarFromRoomVisualization_Boolean_1:Boolean = false;
      
      private var _visiblePlanes:Array = [];
      
      private var _visiblePlaneSpriteNumbers:Array = [];
      
      private var _boundingRectangle:Rectangle = null;
      
      private var UnknownVarFromRoomVisualization_RoomPlaneBitmapMaskParser_1:RoomPlaneBitmapMaskParser = null;
      
      private var UnknownVarFromRoomVisualization_String_1:String = null;
      
      private var UnknownVarFromRoomVisualization_String_2:String = null;
      
      private var UnknownVarFromRoomVisualization_String_3:String = null;
      
      private var UnknownVarFromRoomVisualization_Number_1:Number = NaN;
      
      private var UnknownVarFromRoomVisualization_Number_2:Number = NaN;
      
      private var _floorHoleUpdateTime:Number = NaN;
      
      private var UnknownVarFromRoomVisualization_String_4:String = null;
      
      private var _backgroundColor:uint = 16777215;
      
      private var _backgroundRed:int = 255;
      
      private var _backgroundGreen:int = 255;
      
      private var _backgroundBlue:int = 255;
      
      private var UnknownVarFromRoomVisualization_Int_1:int = 0;
      
      private var _lastUpdateTime:int = -1000;
      
      private const UnknownConstFromRoomVisualization_Int_4:int = 250;
      
      private var UnknownVarFromRoomVisualization_Int_2:int = -1;
      
      private var UnknownVarFromRoomVisualization_Number_3:Number = 0;
      
      private var UnknownVarFromRoomVisualization_Number_4:Number = 0;
      
      private var UnknownVarFromRoomVisualization_Number_5:Number = 0;
      
      private var UnknownVarFromRoomVisualization_Number_6:Number = 0;
      
      private var _planeTypeVisibilities:Array = [];
      
      private var _highlightAreaX:int = 0;
      
      private var _highlightAreaY:int = 0;
      
      private var _highlightAreaWidth:int = 0;
      
      private var _highlightAreaHeight:int = 0;
      
      private var _highlightFilter:Array;
      
      public function RoomVisualization()
      {
         super();
         UnknownVarFromRoomVisualization_AssetLibrary_1 = new AssetLibrary("room visualization");
         UnknownVarFromRoomVisualization_RoomPlaneParser_1 = new RoomPlaneParser();
         UnknownVarFromRoomVisualization_RoomPlaneBitmapMaskParser_1 = new RoomPlaneBitmapMaskParser();
         _planeTypeVisibilities[0] = false;
         _planeTypeVisibilities[2] = true;
         _planeTypeVisibilities[1] = true;
         _planeTypeVisibilities[3] = true;
      }
      
      public function get floorRelativeDepth() : Number
      {
         return 1000 + 0.1;
      }
      
      public function get wallRelativeDepth() : Number
      {
         return 1000 + 0.5;
      }
      
      public function get wallAdRelativeDepth() : Number
      {
         return 1000 + 0.49;
      }
      
      public function get planeCount() : int
      {
         return _planes.length;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ISoundAsset = null;
         super.dispose();
         if(UnknownVarFromRoomVisualization_AssetLibrary_1 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < UnknownVarFromRoomVisualization_AssetLibrary_1.numAssets)
            {
               _loc2_ = UnknownVarFromRoomVisualization_AssetLibrary_1.getAssetByIndex(_loc1_);
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            UnknownVarFromRoomVisualization_AssetLibrary_1.dispose();
            UnknownVarFromRoomVisualization_AssetLibrary_1 = null;
         }
         resetRoomPlanes();
         _planes = null;
         UnknownVarFromRoomVisualization_Dictionary_1 = null;
         _visiblePlanes = null;
         _visiblePlaneSpriteNumbers = null;
         if(UnknownVarFromRoomVisualization_RoomPlaneParser_1 != null)
         {
            UnknownVarFromRoomVisualization_RoomPlaneParser_1.dispose();
            UnknownVarFromRoomVisualization_RoomPlaneParser_1 = null;
         }
         if(UnknownVarFromRoomVisualization_RoomPlaneBitmapMaskParser_1 != null)
         {
            UnknownVarFromRoomVisualization_RoomPlaneBitmapMaskParser_1.dispose();
            UnknownVarFromRoomVisualization_RoomPlaneBitmapMaskParser_1 = null;
         }
         if(UnknownVarFromRoomVisualization_RoomVisualizationData_1 != null)
         {
            UnknownVarFromRoomVisualization_RoomVisualizationData_1.clearCache();
            UnknownVarFromRoomVisualization_RoomVisualizationData_1 = null;
         }
      }
      
      private function resetRoomPlanes() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RoomPlane = null;
         if(_planes != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _planes.length)
            {
               _loc1_ = _planes[_loc2_] as RoomPlane;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            _planes = [];
            UnknownVarFromRoomVisualization_Dictionary_1 = new Dictionary();
         }
         UnknownVarFromRoomVisualization_Boolean_1 = false;
         UnknownVarFromRoomVisualization_Int_1 += 1;
         reset();
      }
      
      override protected function reset() : void
      {
         super.reset();
         UnknownVarFromRoomVisualization_String_1 = null;
         UnknownVarFromRoomVisualization_String_2 = null;
         UnknownVarFromRoomVisualization_String_3 = null;
         UnknownVarFromRoomVisualization_String_4 = null;
         UnknownVarFromRoomVisualization_Int_2 = -1;
         UnknownVarFromRoomVisualization_Number_6 = 0;
      }
      
      override public function get boundingRectangle() : Rectangle
      {
         if(_boundingRectangle == null)
         {
            _boundingRectangle = super.boundingRectangle;
         }
         return new Rectangle(_boundingRectangle.x,_boundingRectangle.y,_boundingRectangle.width,_boundingRectangle.height);
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         reset();
         if(param1 == null || !(param1 is RoomVisualizationData))
         {
            return false;
         }
         UnknownVarFromRoomVisualization_RoomVisualizationData_1 = param1 as RoomVisualizationData;
         UnknownVarFromRoomVisualization_RoomVisualizationData_1.initializeAssetCollection(assetCollection);
         return true;
      }
      
      protected function defineSprites(param1:int = 0) : void
      {
         var _loc4_:* = 0;
         var _loc2_:RoomPlane = null;
         var _loc3_:IRoomObjectSprite = null;
         var _loc5_:int = int(_planes.length);
         createSprites(_loc5_);
         _loc4_ = param1;
         while(_loc4_ < _loc5_)
         {
            _loc2_ = _planes[_loc4_] as RoomPlane;
            _loc3_ = getSprite(_loc4_);
            if(_loc3_ != null && _loc2_ != null && _loc2_.leftSide != null && _loc2_.rightSide != null)
            {
               if(_loc2_.type == 1 && (_loc2_.leftSide.length < 1 || _loc2_.rightSide.length < 1))
               {
                  _loc3_.alphaTolerance = 256;
               }
               else
               {
                  _loc3_.alphaTolerance = 128;
               }
               if(_loc2_.type == 1)
               {
                  _loc3_.tag = "plane.wall@" + (_loc4_ + 1);
               }
               else if(_loc2_.type == 2)
               {
                  _loc3_.tag = "plane.floor@" + (_loc4_ + 1);
               }
               else
               {
                  _loc3_.tag = "plane@" + (_loc4_ + 1);
               }
               _loc3_.spriteType = RoomObjectSpriteType.ROOM_PLANE;
               if(UnknownVarFromRoomVisualization_RoomPlaneParser_1.isPlaneTemporaryHighlighter(_loc4_))
               {
                  _loc3_.filters = _highlightFilter;
                  _loc3_.skipMouseHandling = true;
                  _loc2_.extraDepth = -100;
                  _loc2_.isHighlighter = true;
               }
               else
               {
                  _loc3_.filters = [];
                  _loc3_.skipMouseHandling = false;
                  _loc2_.extraDepth = 0;
                  _loc2_.isHighlighter = false;
               }
            }
            _loc4_++;
         }
      }
      
      protected function initializeRoomPlanes() : void
      {
         if(UnknownVarFromRoomVisualization_Boolean_1)
         {
            return;
         }
         var _loc1_:IRoomObject = object;
         if(_loc1_ == null)
         {
            return;
         }
         if(!isNaN(UnknownVarFromRoomVisualization_Number_1))
         {
            UnknownVarFromRoomVisualization_RoomPlaneParser_1.floorThicknessMultiplier = UnknownVarFromRoomVisualization_Number_1;
         }
         if(!isNaN(UnknownVarFromRoomVisualization_Number_2))
         {
            UnknownVarFromRoomVisualization_RoomPlaneParser_1.wallThicknessMultiplier = UnknownVarFromRoomVisualization_Number_2;
         }
         var _loc2_:String = _loc1_.getModel().getString("room_plane_xml");
         UnknownVarFromRoomVisualization_RoomPlaneParser_1.clearHighlightArea();
         if(!UnknownVarFromRoomVisualization_RoomPlaneParser_1.initializeFromXML(new XML(_loc2_)))
         {
            return;
         }
         UnknownVarFromRoomVisualization_RoomPlaneParser_1.initializeHighlightArea(_highlightAreaX,_highlightAreaY,_highlightAreaWidth,_highlightAreaHeight);
         createPlanesAndSprites();
      }
      
      private function createPlanesAndSprites(param1:int = 0) : void
      {
         var _loc8_:* = 0;
         var _loc4_:IVector3d = null;
         var _loc18_:IVector3d = null;
         var _loc11_:IVector3d = null;
         var _loc7_:Array = null;
         var _loc12_:int = 0;
         var _loc2_:RoomPlane = null;
         var _loc5_:IVector3d = null;
         var _loc19_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc10_:int = 0;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc23_:Number = getLandscapeWidth();
         var _loc17_:Number = getLandscapeHeight();
         var _loc22_:Number = 0;
         var _loc20_:IRoomObject = object;
         var _loc16_:int = _loc20_.getModel().getNumber("room_random_seed");
         _loc8_ = param1;
         while(_loc8_ < UnknownVarFromRoomVisualization_RoomPlaneParser_1.planeCount)
         {
            UnknownVarFromRoomVisualization_Dictionary_1[_loc8_] = -1;
            _loc4_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneLocation(_loc8_);
            _loc18_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneLeftSide(_loc8_);
            _loc11_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneRightSide(_loc8_);
            _loc7_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneSecondaryNormals(_loc8_);
            _loc12_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneType(_loc8_);
            _loc2_ = null;
            if(!(_loc4_ != null && _loc18_ != null && _loc11_ != null))
            {
               return;
            }
            _loc5_ = Vector3d.crossProduct(_loc18_,_loc11_);
            _loc16_ = _loc16_ * 7613 + 517;
            _loc2_ = null;
            if(_loc12_ == 1)
            {
               _loc19_ = _loc4_.x + _loc18_.x + 0.5;
               _loc21_ = _loc4_.y + _loc11_.y + 0.5;
               _loc13_ = int(_loc19_) - _loc19_;
               _loc14_ = int(_loc21_) - _loc21_;
               _loc2_ = new RoomPlane(_loc20_.getLocation(),_loc4_,_loc18_,_loc11_,2,true,_loc7_,_loc16_,-_loc13_,-_loc14_);
               if(_loc5_.z != 0)
               {
                  _loc2_.color = 16777215;
               }
               else
               {
                  _loc2_.color = _loc5_.x != 0 ? 12303291 : 14540253;
               }
               if(UnknownVarFromRoomVisualization_RoomVisualizationData_1 != null)
               {
                  _loc2_.rasterizer = UnknownVarFromRoomVisualization_RoomVisualizationData_1.floorRasterizer;
               }
            }
            else if(_loc12_ == 2)
            {
               _loc2_ = new RoomPlane(_loc20_.getLocation(),_loc4_,_loc18_,_loc11_,1,true,_loc7_,_loc16_);
               if(_loc18_.length < 1 || _loc11_.length < 1)
               {
                  _loc2_.hasTexture = false;
               }
               if(_loc5_.x == 0 && _loc5_.y == 0)
               {
                  _loc2_.color = 10066329;
               }
               else if(_loc5_.y > 0)
               {
                  _loc2_.color = 16777215;
               }
               else if(_loc5_.y == 0)
               {
                  _loc2_.color = 13421772;
               }
               else
               {
                  _loc2_.color = 10066329;
               }
               if(UnknownVarFromRoomVisualization_RoomVisualizationData_1 != null)
               {
                  _loc2_.rasterizer = UnknownVarFromRoomVisualization_RoomVisualizationData_1.wallRasterizer;
               }
            }
            else if(_loc12_ == 3)
            {
               _loc2_ = new RoomPlane(_loc20_.getLocation(),_loc4_,_loc18_,_loc11_,3,true,_loc7_,_loc16_,_loc22_,0,_loc23_,_loc17_);
               if(_loc5_.y > 0)
               {
                  _loc2_.color = 16777215;
               }
               else if(_loc5_.y == 0)
               {
                  _loc2_.color = 13421772;
               }
               else
               {
                  _loc2_.color = 10066329;
               }
               if(UnknownVarFromRoomVisualization_RoomVisualizationData_1 != null)
               {
                  _loc2_.rasterizer = UnknownVarFromRoomVisualization_RoomVisualizationData_1.landscapeRasterizer;
               }
               _loc22_ += _loc18_.length;
            }
            else if(_loc12_ == 4)
            {
               _loc2_ = new RoomPlane(_loc20_.getLocation(),_loc4_,_loc18_,_loc11_,1,true,_loc7_,_loc16_);
               if(_loc18_.length < 1 || _loc11_.length < 1)
               {
                  _loc2_.hasTexture = false;
               }
               if(_loc5_.x == 0 && _loc5_.y == 0)
               {
                  _loc2_.color = 10066329;
               }
               else if(_loc5_.y > 0)
               {
                  _loc2_.color = 16777215;
               }
               else if(_loc5_.y == 0)
               {
                  _loc2_.color = 13421772;
               }
               else
               {
                  _loc2_.color = 10066329;
               }
               if(UnknownVarFromRoomVisualization_RoomVisualizationData_1 != null)
               {
                  _loc2_.rasterizer = UnknownVarFromRoomVisualization_RoomVisualizationData_1.wallAdRasterizr;
               }
            }
            if(_loc2_ != null)
            {
               _loc2_.maskManager = UnknownVarFromRoomVisualization_RoomVisualizationData_1.maskManager;
               _loc10_ = 0;
               while(_loc10_ < UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneMaskCount(_loc8_))
               {
                  _loc6_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneMaskLeftSideLoc(_loc8_,_loc10_);
                  _loc3_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneMaskRightSideLoc(_loc8_,_loc10_);
                  _loc15_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneMaskLeftSideLength(_loc8_,_loc10_);
                  _loc9_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneMaskRightSideLength(_loc8_,_loc10_);
                  _loc2_.addRectangleMask(_loc6_,_loc3_,_loc15_,_loc9_);
                  _loc10_++;
               }
               UnknownVarFromRoomVisualization_Dictionary_1[_loc8_] = _planes.length;
               _planes.push(_loc2_);
            }
            _loc8_++;
         }
         UnknownVarFromRoomVisualization_Boolean_1 = true;
         defineSprites(param1);
      }
      
      public function initializeHighlightArea(param1:int, param2:int, param3:int, param4:int, param5:Array) : void
      {
         clearHighlightArea();
         _highlightAreaX = param1;
         _highlightAreaY = param2;
         _highlightAreaWidth = param3;
         _highlightAreaHeight = param4;
         _highlightFilter = param5;
         UnknownVarFromRoomVisualization_RoomPlaneParser_1.initializeHighlightArea(param1,param2,param3,param4);
         createPlanesAndSprites(_planes.length);
         reset();
      }
      
      public function clearHighlightArea() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _highlightAreaX = 0;
         _highlightAreaY = 0;
         _highlightAreaWidth = 0;
         _highlightAreaHeight = 0;
         var _loc3_:int = UnknownVarFromRoomVisualization_RoomPlaneParser_1.clearHighlightArea();
         var _loc4_:int = 0;
         _loc1_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.planeCount;
         while(_loc1_ < UnknownVarFromRoomVisualization_RoomPlaneParser_1.planeCount + _loc3_)
         {
            _loc2_ = int(UnknownVarFromRoomVisualization_Dictionary_1[_loc1_]);
            if(_loc2_ != -1)
            {
               _loc4_ += 1;
               UnknownVarFromRoomVisualization_Dictionary_1[_loc1_] = -1;
            }
            _loc1_ += 1;
         }
         _planes = _planes.slice(0,_planes.length - _loc4_);
         createSprites(_planes.length);
         reset();
      }
      
      private function getLandscapeWidth() : Number
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:IVector3d = null;
         var _loc4_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromRoomVisualization_RoomPlaneParser_1.planeCount)
         {
            _loc3_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneType(_loc2_);
            if(_loc3_ == 3)
            {
               _loc1_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneLeftSide(_loc2_);
               _loc4_ += _loc1_.length;
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      private function getLandscapeHeight() : Number
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:IVector3d = null;
         var _loc1_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromRoomVisualization_RoomPlaneParser_1.planeCount)
         {
            _loc4_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneType(_loc2_);
            if(_loc4_ == 3)
            {
               _loc3_ = UnknownVarFromRoomVisualization_RoomPlaneParser_1.getPlaneRightSide(_loc2_);
               if(_loc3_.length > _loc1_)
               {
                  _loc1_ = _loc3_.length;
               }
            }
            _loc2_++;
         }
         if(_loc1_ > 5)
         {
            _loc1_ = 5;
         }
         return _loc1_;
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc8_:int = 0;
         var _loc16_:int = 0;
         var _loc14_:IRoomObjectSprite = null;
         var _loc5_:RoomPlane = null;
         var _loc7_:* = 0;
         var _loc11_:* = 0;
         var _loc6_:* = 0;
         var _loc10_:* = 0;
         var _loc13_:* = 0;
         var _loc12_:IRoomObject = object;
         if(_loc12_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc9_:Boolean = updateGeometry(param1);
         var _loc15_:IRoomObjectModel = _loc12_.getModel();
         var _loc18_:Boolean = false;
         if(updatePlaneThicknesses(_loc15_))
         {
            _loc18_ = true;
         }
         if(updateFloorHoles(_loc15_))
         {
            _loc18_ = true;
         }
         initializeRoomPlanes();
         _loc18_ = updateMasksAndColors(_loc15_);
         var _loc17_:* = param2;
         if(_loc17_ < _lastUpdateTime + 250 && !_loc9_ && !_loc18_)
         {
            return;
         }
         if(updatePlaneTexturesAndVisibilities(_loc15_))
         {
            if(!_loc18_)
            {
               _loc18_ = true;
            }
         }
         if(updatePlanes(param1,_loc9_,param2))
         {
            if(!_loc18_)
            {
               _loc18_ = true;
            }
         }
         if(_loc18_)
         {
            _loc8_ = 0;
            while(_loc8_ < _visiblePlanes.length)
            {
               _loc16_ = int(_visiblePlaneSpriteNumbers[_loc8_]);
               _loc14_ = getSprite(_loc16_);
               _loc5_ = _visiblePlanes[_loc8_] as RoomPlane;
               if(_loc14_ != null && _loc5_ != null && _loc5_.type != 3)
               {
                  _loc7_ = _loc5_.color;
                  _loc11_ = (_loc7_ & 0xFF) * _backgroundBlue / 255;
                  _loc6_ = (_loc7_ >> 8 & 0xFF) * _backgroundGreen / 255;
                  _loc10_ = (_loc7_ >> 16 & 0xFF) * _backgroundRed / 255;
                  _loc13_ = uint(_loc7_ >> 24);
                  _loc7_ = uint((_loc13_ << 24) + (_loc10_ << 16) + (_loc6_ << 8) + _loc11_);
                  _loc14_.color = _loc7_;
               }
               _loc8_++;
            }
            increaseUpdateId();
         }
         UnknownVarFromRoomObjectSpriteVisualization_Int_3 = _loc15_.getUpdateID();
         _lastUpdateTime = _loc17_;
      }
      
      private function updateGeometry(param1:IRoomGeometry) : Boolean
      {
         var _loc2_:IVector3d = null;
         var _loc3_:Boolean = false;
         if(param1.updateId != UnknownVarFromRoomVisualization_Int_2)
         {
            UnknownVarFromRoomVisualization_Int_2 = param1.updateId;
            _boundingRectangle = null;
            _loc2_ = param1.direction;
            if(_loc2_ != null && (_loc2_.x != UnknownVarFromRoomVisualization_Number_3 || _loc2_.y != UnknownVarFromRoomVisualization_Number_4 || _loc2_.z != UnknownVarFromRoomVisualization_Number_5 || param1.scale != UnknownVarFromRoomVisualization_Number_6))
            {
               UnknownVarFromRoomVisualization_Number_3 = _loc2_.x;
               UnknownVarFromRoomVisualization_Number_4 = _loc2_.y;
               UnknownVarFromRoomVisualization_Number_5 = _loc2_.z;
               UnknownVarFromRoomVisualization_Number_6 = param1.scale;
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      private function updateMasksAndColors(param1:IRoomObjectModel) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc4_:Boolean = false;
         if(UnknownVarFromRoomObjectSpriteVisualization_Int_3 != param1.getUpdateID())
         {
            _loc2_ = param1.getString("room_plane_mask_xml");
            if(_loc2_ != UnknownVarFromRoomVisualization_String_4)
            {
               updatePlaneMasks(_loc2_);
               UnknownVarFromRoomVisualization_String_4 = _loc2_;
               _loc4_ = true;
            }
            _loc3_ = param1.getNumber("room_background_color");
            if(_loc3_ != _backgroundColor)
            {
               _backgroundColor = _loc3_;
               _backgroundBlue = _backgroundColor & 0xFF;
               _backgroundGreen = _backgroundColor >> 8 & 0xFF;
               _backgroundRed = _backgroundColor >> 16 & 0xFF;
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      private function updatePlaneTexturesAndVisibilities(param1:IRoomObjectModel) : Boolean
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc4_:Boolean = false;
         if(UnknownVarFromRoomObjectSpriteVisualization_Int_3 != param1.getUpdateID())
         {
            _loc5_ = param1.getString("room_wall_type");
            _loc6_ = param1.getString("room_floor_type");
            _loc2_ = param1.getString("room_landscape_type");
            updatePlaneTextureTypes(_loc6_,_loc5_,_loc2_);
            _loc3_ = Boolean(param1.getNumber("room_floor_visibility"));
            _loc7_ = Boolean(param1.getNumber("room_wall_visibility"));
            _loc4_ = Boolean(param1.getNumber("room_landscape_visibility"));
            updatePlaneTypeVisibilities(_loc3_,_loc7_,_loc4_);
            return true;
         }
         return false;
      }
      
      private function updatePlaneThicknesses(param1:IRoomObjectModel) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         if(UnknownVarFromRoomObjectSpriteVisualization_Int_3 != param1.getUpdateID())
         {
            _loc3_ = param1.getNumber("room_floor_thickness");
            _loc2_ = param1.getNumber("room_wall_thickness");
            if(!isNaN(_loc3_) && !isNaN(_loc2_) && (_loc3_ != UnknownVarFromRoomVisualization_Number_1 || _loc2_ != UnknownVarFromRoomVisualization_Number_2))
            {
               UnknownVarFromRoomVisualization_Number_1 = _loc3_;
               UnknownVarFromRoomVisualization_Number_2 = _loc2_;
               resetRoomPlanes();
               return true;
            }
         }
         return false;
      }
      
      private function updateFloorHoles(param1:IRoomObjectModel) : Boolean
      {
         var _loc2_:Number = NaN;
         if(UnknownVarFromRoomObjectSpriteVisualization_Int_3 != param1.getUpdateID())
         {
            _loc2_ = param1.getNumber("room_floor_hole_update_time");
            if(!isNaN(_loc2_) && _loc2_ != _floorHoleUpdateTime)
            {
               _floorHoleUpdateTime = _loc2_;
               resetRoomPlanes();
               return true;
            }
         }
         return false;
      }
      
      protected function updatePlaneTextureTypes(param1:String, param2:String, param3:String) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:RoomPlane = null;
         if(param1 != UnknownVarFromRoomVisualization_String_2)
         {
            UnknownVarFromRoomVisualization_String_2 = param1;
         }
         else
         {
            param1 = null;
         }
         if(param2 != UnknownVarFromRoomVisualization_String_1)
         {
            UnknownVarFromRoomVisualization_String_1 = param2;
         }
         else
         {
            param2 = null;
         }
         if(param3 != UnknownVarFromRoomVisualization_String_3)
         {
            UnknownVarFromRoomVisualization_String_3 = param3;
         }
         else
         {
            param3 = null;
         }
         if(param1 == null && param2 == null && param3 == null)
         {
            return false;
         }
         _loc5_ = 0;
         while(_loc5_ < _planes.length)
         {
            _loc4_ = _planes[_loc5_] as RoomPlane;
            if(_loc4_ != null)
            {
               if(_loc4_.type == 2 && param1 != null)
               {
                  _loc4_.id = param1;
               }
               else if(_loc4_.type == 1 && param2 != null)
               {
                  _loc4_.id = param2;
               }
               else if(_loc4_.type == 3 && param3 != null)
               {
                  _loc4_.id = param3;
               }
            }
            _loc5_++;
         }
         return true;
      }
      
      private function updatePlaneTypeVisibilities(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         if(param1 != _planeTypeVisibilities[2] || param2 != _planeTypeVisibilities[1] || param3 != _planeTypeVisibilities[3])
         {
            _planeTypeVisibilities[2] = param1;
            _planeTypeVisibilities[1] = param2;
            _planeTypeVisibilities[3] = param3;
            _visiblePlanes = [];
            _visiblePlaneSpriteNumbers = [];
         }
      }
      
      protected function updatePlanes(param1:IRoomGeometry, param2:Boolean, param3:int) : Boolean
      {
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc12_:IRoomObjectSprite = null;
         var _loc4_:RoomPlane = null;
         var _loc10_:Number = NaN;
         var _loc13_:String = null;
         var _loc11_:IRoomObject = object;
         if(_loc11_ == null)
         {
            return false;
         }
         if(param1 == null)
         {
            return false;
         }
         UnknownVarFromRoomVisualization_Int_1++;
         if(param2)
         {
            _visiblePlanes = [];
            _visiblePlaneSpriteNumbers = [];
         }
         var _loc5_:* = param3;
         var _loc6_:Array = _visiblePlanes;
         if(_visiblePlanes.length == 0)
         {
            _loc6_ = _planes;
         }
         var _loc14_:Boolean = false;
         var _loc7_:* = _visiblePlanes.length > 0;
         _loc8_ = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc9_ = _loc8_;
            if(_loc7_)
            {
               _loc9_ = int(_visiblePlaneSpriteNumbers[_loc8_]);
            }
            _loc12_ = getSprite(_loc9_);
            if(_loc12_ != null)
            {
               _loc4_ = _loc6_[_loc8_] as RoomPlane;
               if(_loc4_ != null)
               {
                  _loc12_.planeId = _loc4_.uniqueId;
                  if(_loc4_.update(param1,_loc5_))
                  {
                     if(_loc4_.visible)
                     {
                        _loc10_ = _loc4_.relativeDepth + floorRelativeDepth + _loc9_ / 1000;
                        if(_loc4_.type != 2)
                        {
                           _loc10_ = _loc4_.relativeDepth + wallRelativeDepth + _loc9_ / 1000;
                           if(_loc4_.leftSide.length < 1 || _loc4_.rightSide.length < 1)
                           {
                              _loc10_ += 1000 * 0.5;
                           }
                        }
                        _loc13_ = "plane " + _loc9_ + " " + param1.scale;
                        updateSprite(_loc12_,_loc4_,_loc13_,_loc10_);
                     }
                     _loc14_ = true;
                  }
                  if(_loc12_.visible != (_loc4_.visible && _planeTypeVisibilities[_loc4_.type]))
                  {
                     _loc12_.visible = !_loc12_.visible;
                     _loc14_ = true;
                  }
                  if(_loc12_.visible)
                  {
                     if(!_loc7_)
                     {
                        _visiblePlanes.push(_loc4_);
                        _visiblePlaneSpriteNumbers.push(_loc8_);
                     }
                  }
               }
               else
               {
                  _loc12_.planeId = 0;
                  if(_loc12_.visible)
                  {
                     _loc12_.visible = false;
                     _loc14_ = true;
                  }
               }
            }
            _loc8_++;
         }
         return _loc14_;
      }
      
      private function updateSprite(param1:IRoomObjectSprite, param2:RoomPlane, param3:String, param4:Number) : void
      {
         var _loc5_:Point = param2.offset;
         param1.offsetX = -_loc5_.x;
         param1.offsetY = -_loc5_.y;
         param1.relativeDepth = param4;
         param1.color = param2.color;
         param1.asset = getPlaneBitmap(param2,param3);
         param1.assetName = param3 + "_" + UnknownVarFromRoomVisualization_Int_1;
      }
      
      private function getPlaneBitmap(param1:RoomPlane, param2:String) : BitmapData
      {
         var _loc5_:BitmapData = null;
         var _loc4_:BitmapDataAsset = UnknownVarFromRoomVisualization_AssetLibrary_1.getAssetByName(param2) as BitmapDataAsset;
         if(_loc4_ == null)
         {
            _loc4_ = new BitmapDataAsset(UnknownVarFromRoomVisualization_AssetLibrary_1.getAssetTypeDeclarationByClass(BitmapDataAsset));
            UnknownVarFromRoomVisualization_AssetLibrary_1.setAsset(param2,_loc4_);
         }
         var _loc3_:BitmapData = param1.cloneBitmapData();
         if(_loc3_ != null)
         {
            _loc5_ = _loc4_.content as BitmapData;
            if(_loc5_ != null)
            {
               _loc5_.dispose();
            }
            _loc4_.setUnknownContent(_loc3_);
         }
         return _loc3_;
      }
      
      protected function updatePlaneMasks(param1:String) : void
      {
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:String = null;
         var _loc9_:IVector3d = null;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         var _loc18_:IVector3d = null;
         var _loc8_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc15_:int = 0;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc17_:XML = XML(param1);
         UnknownVarFromRoomVisualization_RoomPlaneBitmapMaskParser_1.initialize(_loc17_);
         var _loc2_:RoomPlane = null;
         var _loc14_:Array = [];
         var _loc16_:Array = [];
         var _loc6_:Boolean = false;
         _loc10_ = 0;
         while(_loc10_ < _planes.length)
         {
            _loc2_ = _planes[_loc10_] as RoomPlane;
            if(_loc2_ != null)
            {
               _loc2_.resetBitmapMasks();
               if(_loc2_.type == 3)
               {
                  _loc14_.push(_loc10_);
               }
            }
            _loc10_++;
         }
         _loc11_ = 0;
         while(_loc11_ < UnknownVarFromRoomVisualization_RoomPlaneBitmapMaskParser_1.maskCount)
         {
            _loc7_ = UnknownVarFromRoomVisualization_RoomPlaneBitmapMaskParser_1.getMaskType(_loc11_);
            _loc9_ = UnknownVarFromRoomVisualization_RoomPlaneBitmapMaskParser_1.getMaskLocation(_loc11_);
            _loc12_ = UnknownVarFromRoomVisualization_RoomPlaneBitmapMaskParser_1.getMaskCategory(_loc11_);
            if(_loc9_ != null)
            {
               _loc13_ = 0;
               while(_loc13_ < _planes.length)
               {
                  _loc2_ = _planes[_loc13_] as RoomPlane;
                  if(_loc2_.type == 1 || _loc2_.type == 3)
                  {
                     if(_loc2_ != null && _loc2_.location != null && _loc2_.normal != null)
                     {
                        _loc18_ = Vector3d.dif(_loc9_,_loc2_.location);
                        _loc8_ = Math.abs(Vector3d.scalarProjection(_loc18_,_loc2_.normal));
                        if(_loc8_ < 0.01)
                        {
                           if(_loc2_.leftSide != null && _loc2_.rightSide != null)
                           {
                              _loc5_ = Vector3d.scalarProjection(_loc18_,_loc2_.leftSide);
                              _loc3_ = Vector3d.scalarProjection(_loc18_,_loc2_.rightSide);
                              if(_loc2_.type == 1 || _loc2_.type == 3 && _loc12_ == "hole")
                              {
                                 _loc2_.addBitmapMask(_loc7_,_loc5_,_loc3_);
                              }
                              else if(_loc2_.type == 3)
                              {
                                 if(!_loc2_.canBeVisible)
                                 {
                                    _loc6_ = true;
                                 }
                                 _loc2_.canBeVisible = true;
                                 _loc16_.push(_loc13_);
                              }
                           }
                        }
                     }
                  }
                  _loc13_++;
               }
            }
            _loc11_++;
         }
         _loc15_ = 0;
         while(_loc15_ < _loc14_.length)
         {
            _loc4_ = int(_loc14_[_loc15_]);
            if(_loc16_.indexOf(_loc4_) < 0)
            {
               _loc2_ = _planes[_loc4_] as RoomPlane;
               _loc2_.canBeVisible = false;
               _loc6_ = true;
            }
            _loc15_++;
         }
         if(_loc6_)
         {
            _visiblePlanes = [];
            _visiblePlaneSpriteNumbers = [];
         }
      }
      
      public function get planes() : Vector.<IRoomPlane>
      {
         var _loc2_:Vector.<IRoomPlane> = new Vector.<IRoomPlane>(0);
         for each(var _loc1_ in _visiblePlanes)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
   }
}


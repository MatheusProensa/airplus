package com.sulake.room.renderer
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.data.RoomObjectSpriteData;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.enum.RoomObjectSpriteType;
   import com.sulake.room.object.logic.IRoomObjectMouseHandler;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.renderer.cache.BitmapDataCache;
   import com.sulake.room.renderer.cache.RoomObjectCache;
   import com.sulake.room.renderer.cache.RoomObjectCacheItem;
   import com.sulake.room.renderer.cache.RoomObjectLocationCacheItem;
   import com.sulake.room.renderer.cache.RoomObjectSortableSpriteCacheItem;
   import com.sulake.room.renderer.utils.ExtendedBitmapData;
   import com.sulake.room.renderer.utils.ExtendedSprite;
   import com.sulake.room.renderer.utils.ObjectMouseData;
   import com.sulake.room.renderer.utils.SortableSprite;
   import com.sulake.room.utils.*;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class RoomSpriteCanvas implements IRoomRenderingCanvas
   {
      private static const SKIP_FRAME_COUNT_FOR_UPDATE_INTERVAL:int = 50;
      
      private static const FRAME_COUNT_FOR_UPDATE_INTERVAL:int = 50;
      
      private static const SLOW_FRAME_UPDATE_INTERVAL:Number = 60;
      
      private static const FAST_FRAME_UPDATE_INTERVAL:Number = 50;
      
      private static const ZERO_POINT:Point = new Point(0,0);
      
      private var _container:IRoomRenderer_1;
      
      private var _geometry:RoomGeometry;
      
      private var _bgColor:int = 0;
      
      private var _displayObject:Sprite;
      
      private var UnknownVarFromRoomSpriteCanvas_Sprite_1:Sprite;
      
      private var _display:Sprite;
      
      private var UnknownVarFromRoomSpriteCanvas_Map_1:Map = new Map();
      
      private var UnknownVarFromRoomSpriteCanvas_Point_1:Point = new Point();
      
      private var _bitmapDataCache:BitmapDataCache;
      
      private var _roomObjectCache:RoomObjectCache;
      
      private var UnknownVarFromRoomSpriteCanvas_Array_1:Array = [];
      
      private var UnknownVarFromRoomSpriteCanvas_Array_2:Array = [];
      
      private var UnknownVarFromRoomSpriteCanvas_IRoomRenderingCanvasMouseListener_1:IRoomRenderingCanvasMouseListener = null;
      
      private var _id:int;
      
      private var _eventCache:Map = null;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_1:int = 0;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_2:int;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_3:int;
      
      private var _screenOffsetX:Number = 0;
      
      private var _screenOffsetY:Number = 0;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_4:int;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_5:int;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_6:int = -1;
      
      private var UnknownVarFromRoomSpriteCanvas_Number_1:Number = -10000000;
      
      private var UnknownVarFromRoomSpriteCanvas_Number_2:Number = -10000000;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_7:int = 0;
      
      private var _mouseSpriteWasHit:Boolean = false;
      
      private var UnknownVarFromRoomSpriteCanvas_Boolean_1:Boolean = false;
      
      private var UnknownVarFromRoomSpriteCanvas_ColorTransform_1:ColorTransform;
      
      private var UnknownVarFromRoomSpriteCanvas_Matrix_1:Matrix;
      
      private var UnknownVarFromRoomSpriteCanvas_Number_3:Number = 0;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_8:int = 0;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_9:int = 0;
      
      private var UnknownVarFromRoomSpriteCanvas_Number_4:Number = 0;
      
      private var UnknownVarFromRoomSpriteCanvas_Number_5:Number = 0;
      
      private var _runningSlow:Boolean = false;
      
      private var _skipObjectUpdate:Boolean = false;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_10:int = 0;
      
      private var _usesExclusionRectangles:Boolean = false;
      
      private var _excludedRectangles:Array = [];
      
      private var _activeSpriteCount:int = 0;
      
      private var UnknownVarFromRoomSpriteCanvas_Number_6:Number = 0;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_11:int = 0;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_12:int = 0;
      
      private var UnknownVarFromRoomSpriteCanvas_Int_13:int = -1;
      
      private var _scale:Number = 1;
      
      private var UnknownVarFromRoomSpriteCanvas_Boolean_2:Boolean;
      
      private var UnknownVarFromRoomSpriteCanvas_Boolean_3:Boolean;
      
      private var UnknownVarFromRoomSpriteCanvas_TextField_1:TextField = new TextField();
      
      public function RoomSpriteCanvas(param1:IRoomRenderer_1, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         _container = param1;
         _id = param2;
         _displayObject = new Sprite();
         _displayObject.mouseEnabled = false;
         _display = new Sprite();
         _display.name = "canvas";
         _display.mouseEnabled = false;
         _displayObject.addChild(_display);
         _display.mouseEnabled = true;
         _display.doubleClickEnabled = true;
         _display.addEventListener("click",clickHandler);
         _display.addEventListener("doubleClick",clickHandler);
         var _loc7_:TextFormat = new TextFormat();
         _loc7_.color = 16733440;
         _loc7_.font = "Verdana";
         _loc7_.size = 9;
         _loc7_.align = "right";
         UnknownVarFromRoomSpriteCanvas_TextField_1.defaultTextFormat = _loc7_;
         UnknownVarFromRoomSpriteCanvas_TextField_1.background = false;
         UnknownVarFromRoomSpriteCanvas_TextField_1.backgroundColor = 0;
         UnknownVarFromRoomSpriteCanvas_TextField_1.multiline = true;
         UnknownVarFromRoomSpriteCanvas_TextField_1.width = 100;
         UnknownVarFromRoomSpriteCanvas_TextField_1.height = 60;
         if(!UnknownVarFromRoomSpriteCanvas_Boolean_1)
         {
            _displayObject.addChild(UnknownVarFromRoomSpriteCanvas_TextField_1);
         }
         _geometry = new RoomGeometry(param5,new Vector3d(-135,30,0),new Vector3d(11,11,5),new Vector3d(-135,0.5,0));
         _bitmapDataCache = new BitmapDataCache(16,32,1);
         var _loc6_:String = null;
         if(_container != null)
         {
            _loc6_ = _container.roomObjectVariableAccurateZ;
         }
         _eventCache = new Map();
         _roomObjectCache = new RoomObjectCache(_loc6_);
         UnknownVarFromRoomSpriteCanvas_ColorTransform_1 = new ColorTransform();
         UnknownVarFromRoomSpriteCanvas_Matrix_1 = new Matrix();
         initialize(param3,param4);
      }
      
      protected function get container() : IRoomRenderer_1
      {
         return _container;
      }
      
      protected function get activeSpriteCount() : int
      {
         return _activeSpriteCount;
      }
      
      public function get width() : int
      {
         return UnknownVarFromRoomSpriteCanvas_Int_2 * _scale;
      }
      
      public function get height() : int
      {
         return UnknownVarFromRoomSpriteCanvas_Int_3 * _scale;
      }
      
      public function set screenOffsetX(param1:Number) : void
      {
         _screenOffsetX = param1;
      }
      
      public function set screenOffsetY(param1:Number) : void
      {
         _screenOffsetY = param1;
      }
      
      public function get screenOffsetX() : Number
      {
         return _screenOffsetX;
      }
      
      public function get screenOffsetY() : Number
      {
         return _screenOffsetY;
      }
      
      public function get displayObject() : DisplayObject
      {
         return _displayObject;
      }
      
      public function get geometry() : IRoomGeometry
      {
         return _geometry;
      }
      
      public function set mouseListener(param1:IRoomRenderingCanvasMouseListener) : void
      {
         UnknownVarFromRoomSpriteCanvas_IRoomRenderingCanvasMouseListener_1 = param1;
      }
      
      public function set useMask(param1:Boolean) : void
      {
         if(param1 && !UnknownVarFromRoomSpriteCanvas_Boolean_1)
         {
            UnknownVarFromRoomSpriteCanvas_Boolean_1 = true;
            if(UnknownVarFromRoomSpriteCanvas_Sprite_1 != null && !_displayObject.contains(UnknownVarFromRoomSpriteCanvas_Sprite_1))
            {
               _displayObject.addChild(UnknownVarFromRoomSpriteCanvas_Sprite_1);
               _display.mask = UnknownVarFromRoomSpriteCanvas_Sprite_1;
            }
            if(_displayObject.contains(UnknownVarFromRoomSpriteCanvas_TextField_1))
            {
               _displayObject.removeChild(UnknownVarFromRoomSpriteCanvas_TextField_1);
            }
         }
         else if(!param1 && UnknownVarFromRoomSpriteCanvas_Boolean_1)
         {
            UnknownVarFromRoomSpriteCanvas_Boolean_1 = false;
            if(UnknownVarFromRoomSpriteCanvas_Sprite_1 != null && _displayObject.contains(UnknownVarFromRoomSpriteCanvas_Sprite_1))
            {
               _displayObject.removeChild(UnknownVarFromRoomSpriteCanvas_Sprite_1);
               _display.mask = null;
            }
         }
      }
      
      public function getSortableSpriteList() : Vector.<RoomObjectSpriteData>
      {
         return _roomObjectCache.getSortableSpriteList();
      }
      
      public function getPlaneSortableSprites() : Array
      {
         return _roomObjectCache.getPlaneSortableSprites();
      }
      
      public function setScale(param1:Number, param2:Point = null, param3:Point = null, param4:Boolean = false) : void
      {
         if(!_displayObject || !_display)
         {
            return;
         }
         if(param2 == null)
         {
            param2 = new Point(UnknownVarFromRoomSpriteCanvas_Int_2 / 2,UnknownVarFromRoomSpriteCanvas_Int_3 / 2);
         }
         if(param3 == null)
         {
            param3 = param2;
         }
         var _loc5_:Point = new Point((param2.x - _screenOffsetX) / _scale,(param2.y - _screenOffsetY) / _scale);
         _scale = param1;
         screenOffsetX = param3.x - _loc5_.x * param1;
         screenOffsetY = param3.y - _loc5_.y * param1;
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function takeScreenShot() : BitmapData
      {
         UnknownVarFromRoomSpriteCanvas_Boolean_2 = true;
         var _loc5_:Number = _scale;
         var _loc2_:Number = _screenOffsetX;
         var _loc1_:Number = _screenOffsetY;
         var _loc6_:String = _display.stage.quality;
         setScale(1);
         _screenOffsetX = 0;
         _screenOffsetY = 0;
         _display.stage.quality = "low";
         render(-1,true);
         var _loc3_:BitmapData = new BitmapData(_display.width,_display.height,true,0);
         var _loc4_:Rectangle = _display.getBounds(_display);
         _loc3_.draw(_display,new Matrix(1,0,0,1,-_loc4_.x,-_loc4_.y));
         UnknownVarFromRoomSpriteCanvas_Boolean_2 = false;
         setScale(_loc5_);
         _screenOffsetX = _loc2_;
         _screenOffsetY = _loc1_;
         _display.stage.quality = _loc6_;
         return _loc3_;
      }
      
      public function skipSpriteVisibilityChecking() : void
      {
         UnknownVarFromRoomSpriteCanvas_Boolean_2 = true;
         render(-1,true);
      }
      
      public function set fpsCounterEnabled(param1:Boolean) : void
      {
         UnknownVarFromRoomSpriteCanvas_Boolean_3 = param1;
         if(!param1)
         {
            UnknownVarFromRoomSpriteCanvas_TextField_1.text = "";
         }
      }
      
      public function set pingMs(param1:int) : void
      {
         UnknownVarFromRoomSpriteCanvas_Int_13 = param1;
      }
      
      public function resumeSpriteVisibilityChecking() : void
      {
         UnknownVarFromRoomSpriteCanvas_Boolean_2 = false;
      }
      
      public function dispose() : void
      {
         cleanSprites(0,true);
         if(_geometry != null)
         {
            _geometry.dispose();
            _geometry = null;
         }
         if(UnknownVarFromRoomSpriteCanvas_Sprite_1 != null)
         {
            UnknownVarFromRoomSpriteCanvas_Sprite_1 = null;
         }
         if(_bitmapDataCache != null)
         {
            _bitmapDataCache.dispose();
            _bitmapDataCache = null;
         }
         if(_roomObjectCache != null)
         {
            _roomObjectCache.dispose();
            _roomObjectCache = null;
         }
         _container = null;
         if(_displayObject != null)
         {
            while(_displayObject.numChildren > 0)
            {
               _displayObject.removeChildAt(0);
            }
            _displayObject = null;
         }
         _display = null;
         UnknownVarFromRoomSpriteCanvas_Sprite_1 = null;
         UnknownVarFromRoomSpriteCanvas_Array_1 = [];
         if(UnknownVarFromRoomSpriteCanvas_Map_1 != null)
         {
            UnknownVarFromRoomSpriteCanvas_Map_1.dispose();
            UnknownVarFromRoomSpriteCanvas_Map_1 = null;
         }
         var _loc1_:int = 0;
         if(UnknownVarFromRoomSpriteCanvas_Array_2 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < UnknownVarFromRoomSpriteCanvas_Array_2.length)
            {
               cleanSprite(UnknownVarFromRoomSpriteCanvas_Array_2[_loc1_] as ExtendedSprite,true);
               _loc1_++;
            }
            UnknownVarFromRoomSpriteCanvas_Array_2 = [];
         }
         if(_eventCache != null)
         {
            _eventCache.dispose();
            _eventCache = null;
         }
         UnknownVarFromRoomSpriteCanvas_IRoomRenderingCanvasMouseListener_1 = null;
         UnknownVarFromRoomSpriteCanvas_ColorTransform_1 = null;
         UnknownVarFromRoomSpriteCanvas_Matrix_1 = null;
      }
      
      public function initialize(param1:int, param2:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         if(UnknownVarFromRoomSpriteCanvas_Sprite_1 != null)
         {
            UnknownVarFromRoomSpriteCanvas_Sprite_1.graphics.clear();
         }
         else
         {
            UnknownVarFromRoomSpriteCanvas_Sprite_1 = new Sprite();
            UnknownVarFromRoomSpriteCanvas_Sprite_1.name = "mask";
            if(UnknownVarFromRoomSpriteCanvas_Boolean_1)
            {
               _displayObject.addChild(UnknownVarFromRoomSpriteCanvas_Sprite_1);
               _display.mask = UnknownVarFromRoomSpriteCanvas_Sprite_1;
            }
         }
         UnknownVarFromRoomSpriteCanvas_Sprite_1.graphics.beginFill(0);
         UnknownVarFromRoomSpriteCanvas_Sprite_1.graphics.drawRect(0,0,param1,param2);
         UnknownVarFromRoomSpriteCanvas_Int_2 = param1;
         UnknownVarFromRoomSpriteCanvas_Int_3 = param2;
         UnknownVarFromRoomSpriteCanvas_TextField_1.x = param1 - (UnknownVarFromRoomSpriteCanvas_TextField_1.width + 20);
         UnknownVarFromRoomSpriteCanvas_TextField_1.y = param2 - (UnknownVarFromRoomSpriteCanvas_TextField_1.height + 60);
      }
      
      public function roomObjectRemoved(param1:String) : void
      {
         _roomObjectCache.removeObjectCache(param1);
      }
      
      public function render(param1:int, param2:Boolean = false) : void
      {
         if(param1 == -1)
         {
            param1 = UnknownVarFromRoomSpriteCanvas_Int_6 + 1;
         }
         _skipObjectUpdate = !_skipObjectUpdate;
         var _loc6_:int = getTimer();
         if(_container == null || _geometry == null)
         {
            return;
         }
         if(param1 == UnknownVarFromRoomSpriteCanvas_Int_6)
         {
            return;
         }
         if(_bitmapDataCache.memUsage > _bitmapDataCache.memLimit)
         {
            _bitmapDataCache.compress();
         }
         var _loc7_:int = _container.getRoomObjectCount();
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:String = "";
         var _loc10_:IRoomObject = null;
         if(UnknownVarFromRoomSpriteCanvas_Int_2 != UnknownVarFromRoomSpriteCanvas_Int_4 || UnknownVarFromRoomSpriteCanvas_Int_3 != UnknownVarFromRoomSpriteCanvas_Int_5)
         {
            param2 = true;
         }
         if(_display.x != _screenOffsetX || _display.y != _screenOffsetY || _display.scaleX != _scale)
         {
            _display.x = _screenOffsetX;
            _display.y = _screenOffsetY;
            _display.scaleX = _scale;
            _display.scaleY = _scale;
            param2 = true;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc10_ = _container.getRoomObjectWithIndex(_loc4_);
            if(_loc10_ != null)
            {
               _loc9_ = _container.getRoomObjectIdWithIndex(_loc4_);
               _loc5_ += renderObject(_loc10_,_loc9_,param1,param2,_loc5_);
            }
            _loc4_++;
         }
         if(UnknownVarFromRoomSpriteCanvas_Array_1.length > 1)
         {
            UnknownVarFromRoomSpriteCanvas_Array_1.sortOn("z",16);
            UnknownVarFromRoomSpriteCanvas_Array_1.reverse();
         }
         if(_loc5_ < UnknownVarFromRoomSpriteCanvas_Array_1.length)
         {
            UnknownVarFromRoomSpriteCanvas_Array_1.splice(_loc5_);
         }
         var _loc3_:SortableSprite = null;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = UnknownVarFromRoomSpriteCanvas_Array_1[_loc4_] as SortableSprite;
            if(_loc3_ != null)
            {
               updateSprite(_loc4_,_loc3_);
            }
            _loc4_++;
         }
         cleanSprites(_loc5_);
         var _loc8_:int = getTimer();
         UnknownVarFromRoomSpriteCanvas_Int_11 = _loc8_ - _loc6_;
         calculateUpdateInterval(param1);
         UnknownVarFromRoomSpriteCanvas_Int_6 = param1;
         UnknownVarFromRoomSpriteCanvas_Int_4 = UnknownVarFromRoomSpriteCanvas_Int_2;
         UnknownVarFromRoomSpriteCanvas_Int_5 = UnknownVarFromRoomSpriteCanvas_Int_3;
      }
      
      private function calculateUpdateInterval(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         if(UnknownVarFromRoomSpriteCanvas_Int_6 <= 0)
         {
            return;
         }
         var _loc3_:int = param1 - UnknownVarFromRoomSpriteCanvas_Int_6;
         if(_loc3_ <= 0)
         {
            return;
         }
         if(_loc3_ > 60 * 3)
         {
            Logger.log("Really slow frame update " + _loc3_ + "ms");
            UnknownVarFromRoomSpriteCanvas_Int_12 = _loc3_;
         }
         UnknownVarFromRoomSpriteCanvas_Int_8++;
         if(UnknownVarFromRoomSpriteCanvas_Int_8 <= 50)
         {
            return;
         }
         UnknownVarFromRoomSpriteCanvas_Int_9++;
         UnknownVarFromRoomSpriteCanvas_Number_4 += _loc3_;
         UnknownVarFromRoomSpriteCanvas_Number_5 += UnknownVarFromRoomSpriteCanvas_Int_11;
         if(UnknownVarFromRoomSpriteCanvas_Int_9 < 50)
         {
            return;
         }
         UnknownVarFromRoomSpriteCanvas_Number_3 = UnknownVarFromRoomSpriteCanvas_Number_4 / UnknownVarFromRoomSpriteCanvas_Int_9;
         UnknownVarFromRoomSpriteCanvas_Number_6 = UnknownVarFromRoomSpriteCanvas_Number_5 / UnknownVarFromRoomSpriteCanvas_Int_9;
         UnknownVarFromRoomSpriteCanvas_Int_9 = 0;
         UnknownVarFromRoomSpriteCanvas_Number_4 = 0;
         UnknownVarFromRoomSpriteCanvas_Number_5 = 0;
         if(!_runningSlow && UnknownVarFromRoomSpriteCanvas_Number_3 > 60)
         {
            _runningSlow = true;
            Logger.log("Room canvas updating really slow - now entering frame skipping mode...");
         }
         else if(_runningSlow && UnknownVarFromRoomSpriteCanvas_Number_3 < 50)
         {
            _runningSlow = false;
            Logger.log("Room canvas updating fast again - now entering normal frame mode...");
         }
         if(UnknownVarFromRoomSpriteCanvas_Boolean_3)
         {
            _loc2_ = (1000 / UnknownVarFromRoomSpriteCanvas_Number_3).toFixed(1);
            _loc5_ = UnknownVarFromRoomSpriteCanvas_Number_6 < 1 ? "<1.0" : UnknownVarFromRoomSpriteCanvas_Number_6.toFixed(1);
            _loc4_ = "";
            if(UnknownVarFromRoomSpriteCanvas_Int_13 >= 0)
            {
               _loc4_ += "ping: " + UnknownVarFromRoomSpriteCanvas_Int_13 + "ms\n";
            }
            _loc4_ += "fps: " + _loc2_ + "\n" + "frame time: " + _loc5_ + "ms";
            if(UnknownVarFromRoomSpriteCanvas_Int_12 > 0)
            {
               _loc4_ += "\nhalted " + UnknownVarFromRoomSpriteCanvas_Int_12 + "ms";
            }
            UnknownVarFromRoomSpriteCanvas_TextField_1.text = _loc4_;
         }
         UnknownVarFromRoomSpriteCanvas_Int_12 = 0;
      }
      
      protected function getRoomObjectCacheItem(param1:String) : RoomObjectCacheItem
      {
         return _roomObjectCache.getObjectCache(param1);
      }
      
      private function renderObject(param1:IRoomObject, param2:String, param3:int, param4:Boolean, param5:int) : int
      {
         var _loc16_:int = 0;
         var _loc13_:BitmapData = null;
         var _loc8_:IRoomObjectSpriteVisualization = param1.getVisualization() as IRoomObjectSpriteVisualization;
         if(_loc8_ == null)
         {
            _roomObjectCache.removeObjectCache(param2);
            return 0;
         }
         var _loc9_:RoomObjectCacheItem = getRoomObjectCacheItem(param2);
         _loc9_.objectId = param1.getId();
         var _loc22_:RoomObjectLocationCacheItem = _loc9_.location;
         var _loc7_:RoomObjectSortableSpriteCacheItem = _loc9_.sprites;
         var _loc11_:IVector3d = _loc22_.getScreenLocation(param1,_geometry);
         if(_loc11_ == null)
         {
            _roomObjectCache.removeObjectCache(param2);
            return 0;
         }
         _loc8_.update(_geometry,param3,!_loc7_.isEmpty || param4,_skipObjectUpdate && _runningSlow);
         var _loc19_:Boolean = _loc22_.locationChanged;
         if(_loc19_)
         {
            param4 = true;
         }
         if(!_loc7_.needsUpdate(_loc8_.getInstanceId(),_loc8_.getUpdateID()) && !param4)
         {
            return _loc7_.spriteCount;
         }
         var _loc14_:int = _loc8_.spriteCount;
         var _loc18_:Number = _loc11_.x;
         var _loc17_:Number = _loc11_.y;
         var _loc15_:Number = _loc11_.z;
         if(_loc18_ > 0)
         {
            _loc15_ += _loc18_ * 1.2e-7;
         }
         else
         {
            _loc15_ += -_loc18_ * 1.2e-7;
         }
         _loc18_ += int(UnknownVarFromRoomSpriteCanvas_Int_2 / 2);
         _loc17_ += int(UnknownVarFromRoomSpriteCanvas_Int_3 / 2);
         var _loc21_:int = 0;
         var _loc20_:SortableSprite = null;
         var _loc6_:IRoomObjectSprite = null;
         var _loc23_:Number = 0;
         var _loc24_:Number = 0;
         var _loc10_:Number = 0;
         var _loc12_:Number = 0;
         _loc16_ = 0;
         while(_loc16_ < _loc14_)
         {
            _loc6_ = _loc8_.getSprite(_loc16_);
            if(_loc6_ != null && _loc6_.visible)
            {
               _loc13_ = _loc6_.asset;
               if(_loc13_ != null)
               {
                  _loc10_ = snapSpriteCoordinate(_loc18_ + _loc6_.offsetX,_screenOffsetX);
                  _loc12_ = snapSpriteCoordinate(_loc17_ + _loc6_.offsetY,_screenOffsetY);
                  _loc23_ = _loc10_ + _screenOffsetX;
                  _loc24_ = _loc12_ + _screenOffsetY;
                  if(rectangleVisible(_loc23_,_loc24_,_loc13_.width,_loc13_.height))
                  {
                     _loc20_ = _loc7_.getSprite(_loc21_);
                     if(_loc20_ == null)
                     {
                        _loc20_ = new SortableSprite();
                        _loc7_.addSprite(_loc20_);
                        UnknownVarFromRoomSpriteCanvas_Array_1.push(_loc20_);
                        _loc20_.name = param2;
                     }
                     _loc20_.sprite = _loc6_;
                     if(_loc6_.spriteType == RoomObjectSpriteType.AVATAR || _loc6_.spriteType == RoomObjectSpriteType.UnknownVarFromRoomObjectSpriteType_Int_1)
                     {
                        _loc20_.sprite.libraryAssetName = param1.getAvatarLibraryAssetName();
                     }
                     _loc20_.x = _loc10_;
                     _loc20_.y = _loc12_;
                     _loc20_.z = _loc15_ + _loc6_.relativeDepth + 3.7e-11 * param5;
                     _loc21_++;
                     param5++;
                  }
               }
            }
            _loc16_++;
         }
         _loc7_.setSpriteCount(_loc21_);
         return _loc21_;
      }
      
      private function snapSpriteCoordinate(param1:Number, param2:Number) : Number
      {
         if(_scale == 0.5)
         {
            return param1;
         }
         return (Math.round(param2 + param1 * _scale) - param2) / _scale;
      }
      
      private function rectangleVisible(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean
      {
         if(UnknownVarFromRoomSpriteCanvas_Boolean_2)
         {
            return true;
         }
         if(_scale != 1)
         {
            param1 = (param1 - _screenOffsetX) * _scale + _screenOffsetX;
            param2 = (param2 - _screenOffsetY) * _scale + _screenOffsetY;
            param3 *= _scale;
            param4 *= _scale;
         }
         if(param1 < UnknownVarFromRoomSpriteCanvas_Int_2 && param1 + param3 >= 0 && (param2 < UnknownVarFromRoomSpriteCanvas_Int_3 && param2 + param4 >= 0))
         {
            if(!_usesExclusionRectangles)
            {
               return true;
            }
            return rectangleVisibleWithExclusion(param1,param2,param3,param4);
         }
         return false;
      }
      
      private function rectangleVisibleWithExclusion(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean
      {
         if(param1 < 0)
         {
            param3 += param1;
            param1 = 0;
         }
         if(param2 < 0)
         {
            param4 += param2;
            param2 = 0;
         }
         if(param1 + param3 >= UnknownVarFromRoomSpriteCanvas_Int_2)
         {
            param3 -= UnknownVarFromRoomSpriteCanvas_Int_2 + 1 - (param1 + param3);
         }
         if(param2 + param4 >= UnknownVarFromRoomSpriteCanvas_Int_3)
         {
            param4 -= UnknownVarFromRoomSpriteCanvas_Int_3 + 1 - (param2 + param4);
         }
         for each(var _loc5_ in _excludedRectangles)
         {
            if(param1 >= _loc5_.left && param1 + param3 < _loc5_.right && param2 >= _loc5_.top && param2 + param4 < _loc5_.bottom)
            {
               return false;
            }
         }
         return true;
      }
      
      protected function getSprite(param1:int) : ExtendedSprite
      {
         if(param1 < 0 || param1 >= UnknownVarFromRoomSpriteCanvas_Int_10)
         {
            return null;
         }
         return _display.getChildAt(param1) as ExtendedSprite;
      }
      
      private function createSprite(param1:SortableSprite, param2:int = -1) : void
      {
         var _loc4_:ExtendedSprite = null;
         var _loc3_:IRoomObjectSprite = param1.sprite;
         if(UnknownVarFromRoomSpriteCanvas_Array_2.length > 0)
         {
            _loc4_ = UnknownVarFromRoomSpriteCanvas_Array_2.pop() as ExtendedSprite;
         }
         if(_loc4_ == null)
         {
            _loc4_ = new ExtendedSprite();
         }
         _loc4_.x = param1.x;
         _loc4_.y = param1.y;
         _loc4_.offsetRefX = _loc3_.offsetX;
         _loc4_.offsetRefY = _loc3_.offsetY;
         _loc4_.identifier = param1.name;
         _loc4_.alpha = _loc3_.alpha / 255;
         _loc4_.tag = _loc3_.tag;
         _loc4_.blendMode = _loc3_.blendMode;
         _loc4_.filters = _loc3_.filters;
         _loc4_.varyingDepth = _loc3_.varyingDepth;
         _loc4_.clickHandling = _loc3_.clickHandling;
         _loc4_.skipMouseHandling = _loc3_.skipMouseHandling;
         _loc4_.smoothing = false;
         _loc4_.pixelSnapping = "always";
         _loc4_.bitmapData = getBitmapData(_loc3_.asset,_loc3_.assetName,_loc3_.flipH,_loc3_.flipV,_loc3_.color);
         updateEnterRoomEffect(_loc4_,_loc3_,RoomEnterEffect.isVisualizationOn());
         _loc4_.alphaTolerance = _loc3_.alphaTolerance;
         if(param2 < 0 || param2 >= UnknownVarFromRoomSpriteCanvas_Int_10)
         {
            _display.addChild(_loc4_);
            UnknownVarFromRoomSpriteCanvas_Int_10++;
         }
         else
         {
            _display.addChildAt(_loc4_,param2);
         }
         _activeSpriteCount++;
      }
      
      private function updateSprite(param1:int, param2:SortableSprite) : Boolean
      {
         var _loc7_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc4_:BitmapData = null;
         if(param1 >= UnknownVarFromRoomSpriteCanvas_Int_10)
         {
            createSprite(param2);
            return true;
         }
         var _loc3_:IRoomObjectSprite = param2.sprite;
         var _loc6_:ExtendedSprite = getSprite(param1);
         if(_loc6_ != null)
         {
            if(_loc6_.varyingDepth != _loc3_.varyingDepth)
            {
               if(_loc6_.varyingDepth && !_loc3_.varyingDepth)
               {
                  _display.removeChildAt(param1);
                  UnknownVarFromRoomSpriteCanvas_Array_2.push(_loc6_);
                  return updateSprite(param1,param2);
               }
               createSprite(param2,param1);
               return true;
            }
            _loc7_ = RoomEnterEffect.isVisualizationOn();
            if(_loc6_.needsUpdate(_loc3_.instanceId,_loc3_.updateId) || _loc7_)
            {
               if(_loc6_.alphaTolerance != _loc3_.alphaTolerance)
               {
                  _loc6_.alphaTolerance = _loc3_.alphaTolerance;
               }
               _loc5_ = _loc3_.alpha / 255;
               if(_loc6_.alpha != _loc5_)
               {
                  _loc6_.alpha = _loc5_;
               }
               if(_loc6_.identifier != param2.name)
               {
                  _loc6_.identifier = param2.name;
               }
               if(_loc6_.tag != _loc3_.tag)
               {
                  _loc6_.tag = _loc3_.tag;
               }
               if(_loc6_.varyingDepth != _loc3_.varyingDepth)
               {
                  _loc6_.varyingDepth = _loc3_.varyingDepth;
               }
               if(_loc6_.blendMode != _loc3_.blendMode)
               {
                  _loc6_.blendMode = _loc3_.blendMode;
               }
               if(_loc6_.clickHandling != _loc3_.clickHandling)
               {
                  _loc6_.clickHandling = _loc3_.clickHandling;
               }
               if(_loc6_.skipMouseHandling != _loc3_.skipMouseHandling)
               {
                  _loc6_.skipMouseHandling = _loc3_.skipMouseHandling;
               }
               _loc6_.filters = _loc3_.filters;
               _loc4_ = getBitmapData(_loc3_.asset,_loc3_.assetName,_loc3_.flipH,_loc3_.flipV,_loc3_.color);
               if(_loc6_.bitmapData != _loc4_)
               {
                  _loc6_.bitmapData = _loc4_;
               }
               updateEnterRoomEffect(_loc6_,_loc3_,_loc7_);
            }
            if(_loc6_.x != param2.x)
            {
               _loc6_.x = param2.x;
            }
            if(_loc6_.y != param2.y)
            {
               _loc6_.y = param2.y;
            }
            if(_loc6_.offsetRefX != _loc3_.offsetX)
            {
               _loc6_.offsetRefX = _loc3_.offsetX;
            }
            if(_loc6_.offsetRefY != _loc3_.offsetY)
            {
               _loc6_.offsetRefY = _loc3_.offsetY;
            }
            return true;
         }
         return false;
      }
      
      private function updateEnterRoomEffect(param1:ExtendedSprite, param2:IRoomObjectSprite, param3:Boolean) : void
      {
         if(!param3 || param1.bitmapData == null || param2 == null)
         {
            return;
         }
         switch(param2.spriteType)
         {
            case RoomObjectSpriteType.UnknownVarFromRoomObjectSpriteType_Int_1:
               break;
            case RoomObjectSpriteType.ROOM_PLANE:
               param1.alpha = RoomEnterEffect.getDelta(0.9);
               break;
            case RoomObjectSpriteType.AVATAR:
               param1.alpha = RoomEnterEffect.getDelta(0.5);
               break;
            default:
               param1.alpha = RoomEnterEffect.getDelta(0.1);
         }
      }
      
      private function cleanSprites(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:int = 0;
         if(_display == null)
         {
            return;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         var _loc3_:ExtendedSprite = null;
         if(param1 < _activeSpriteCount || _activeSpriteCount == 0)
         {
            _loc4_ = UnknownVarFromRoomSpriteCanvas_Int_10 - 1;
            while(_loc4_ >= param1)
            {
               _loc3_ = getSprite(_loc4_);
               cleanSprite(_loc3_,param2);
               _loc4_--;
            }
         }
         _activeSpriteCount = param1;
      }
      
      private function cleanSprite(param1:ExtendedSprite, param2:Boolean) : void
      {
         if(param1 != null)
         {
            if(!param2)
            {
               param1.bitmapData = null;
            }
            else
            {
               param1.dispose();
            }
         }
      }
      
      private function getSortableSprite(param1:int) : SortableSprite
      {
         if(param1 < 0 || param1 >= UnknownVarFromRoomSpriteCanvas_Array_1.length)
         {
            return null;
         }
         return UnknownVarFromRoomSpriteCanvas_Array_1[param1] as SortableSprite;
      }
      
      private function getBitmapData(param1:BitmapData, param2:String, param3:Boolean, param4:Boolean, param5:int) : BitmapData
      {
         param5 &= 16777215;
         if(!param3 && !param4 && param5 == 16777215)
         {
            return param1;
         }
         var _loc7_:ExtendedBitmapData = null;
         var _loc6_:String = "";
         if((param3 || param4) && param5 != 16777215)
         {
            _loc6_ = param2 + " " + param5 + (param3 ? " FH" : "") + (param4 ? " FV" : "");
            if(param2.length > 0)
            {
               _loc7_ = _bitmapDataCache.getBitmapData(_loc6_);
            }
            if(_loc7_ == null)
            {
               _loc7_ = getColoredBitmapData(param1,param2,param5);
               if(_loc7_ != null)
               {
                  _loc7_ = getFlippedBitmapData(_loc7_,param2,true,param3,param4);
                  if(param2.length > 0)
                  {
                     _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
                  }
                  return _loc7_;
               }
               _loc7_ = getFlippedBitmapData(param1,param2,true,param3,param4);
               if(_loc7_ != null)
               {
                  _loc7_ = getColoredBitmapData(_loc7_,"",param5,true);
                  if(param2.length > 0)
                  {
                     _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
                  }
                  return _loc7_;
               }
               _loc7_ = getColoredBitmapData(param1,param2,param5,true);
               _loc7_ = getFlippedBitmapData(_loc7_,param2,true,param3,param4);
               if(param2.length > 0)
               {
                  _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
               }
            }
         }
         else if(param3 || param4)
         {
            _loc7_ = getFlippedBitmapData(param1,param2,true,param3,param4);
         }
         else
         {
            if(param5 == 16777215)
            {
               return param1;
            }
            _loc7_ = getColoredBitmapData(param1,param2,param5,true);
         }
         return _loc7_;
      }
      
      private function getFlippedBitmapData(param1:BitmapData, param2:String, param3:Boolean = false, param4:Boolean = true, param5:Boolean = false) : ExtendedBitmapData
      {
         var _loc6_:String = param2 + (param4 ? " FH" : "") + (param5 ? " FV" : "");
         var _loc7_:ExtendedBitmapData = null;
         if(param2.length > 0)
         {
            _loc7_ = _bitmapDataCache.getBitmapData(_loc6_);
            if(!param3)
            {
               return _loc7_;
            }
         }
         if(_loc7_ == null)
         {
            try
            {
               _loc7_ = new ExtendedBitmapData(param1.width,param1.height,true,16777215);
            }
            catch(e:Error)
            {
               _loc7_ = new ExtendedBitmapData(1,1,true,16777215);
            }
            UnknownVarFromRoomSpriteCanvas_Matrix_1.identity();
            if(param4)
            {
               UnknownVarFromRoomSpriteCanvas_Matrix_1.scale(-1,1);
               UnknownVarFromRoomSpriteCanvas_Matrix_1.translate(param1.width,0);
            }
            if(param5)
            {
               UnknownVarFromRoomSpriteCanvas_Matrix_1.scale(1,-1);
               UnknownVarFromRoomSpriteCanvas_Matrix_1.translate(0,param1.height);
            }
            _loc7_.draw(param1,UnknownVarFromRoomSpriteCanvas_Matrix_1);
            if(param2.length > 0)
            {
               _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
            }
         }
         return _loc7_;
      }
      
      private function getColoredBitmapData(param1:BitmapData, param2:String, param3:int, param4:Boolean = false) : ExtendedBitmapData
      {
         var _loc5_:* = 0;
         var _loc10_:* = 0;
         var _loc6_:* = 0;
         var _loc11_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc7_:String = param2 + " " + param3;
         var _loc9_:ExtendedBitmapData = null;
         if(param2.length > 0)
         {
            _loc9_ = _bitmapDataCache.getBitmapData(_loc7_);
            if(!param4)
            {
               return _loc9_;
            }
         }
         if(_loc9_ == null)
         {
            _loc5_ = param3 >> 16 & 0xFF;
            _loc10_ = param3 >> 8 & 0xFF;
            _loc6_ = param3 & 0xFF;
            _loc11_ = _loc5_ / 255;
            _loc8_ = _loc10_ / 255;
            _loc12_ = _loc6_ / 255;
            try
            {
               _loc9_ = new ExtendedBitmapData(param1.width,param1.height,true,16777215);
               _loc9_.copyPixels(param1,param1.rect,ZERO_POINT);
            }
            catch(e:Error)
            {
               _loc9_ = new ExtendedBitmapData(1,1,true,16777215);
            }
            UnknownVarFromRoomSpriteCanvas_ColorTransform_1.redMultiplier = _loc11_;
            UnknownVarFromRoomSpriteCanvas_ColorTransform_1.greenMultiplier = _loc8_;
            UnknownVarFromRoomSpriteCanvas_ColorTransform_1.blueMultiplier = _loc12_;
            _loc9_.colorTransform(_loc9_.rect,UnknownVarFromRoomSpriteCanvas_ColorTransform_1);
            if(param2.length > 0)
            {
               _bitmapDataCache.addBitmapData(_loc7_,_loc9_);
            }
         }
         return _loc9_;
      }
      
      protected function getObjectId(param1:ExtendedSprite) : String
      {
         var _loc2_:* = null;
         if(param1 != null)
         {
            return param1.identifier;
         }
         return "";
      }
      
      public function handleMouseEvent(param1:int, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : Boolean
      {
         var _loc9_:Number = param1 - _screenOffsetX;
         var _loc8_:Number = param2 - _screenOffsetY;
         UnknownVarFromRoomSpriteCanvas_Point_1.x = param1;
         UnknownVarFromRoomSpriteCanvas_Point_1.y = param2;
         if(UnknownVarFromRoomSpriteCanvas_Int_7 > 0 && param3 == "mouseMove")
         {
            return _mouseSpriteWasHit;
         }
         _mouseSpriteWasHit = checkMouseHits(_loc9_ / _scale,_loc8_ / _scale,param3,param4,param5,param6,param7);
         UnknownVarFromRoomSpriteCanvas_Int_7++;
         return _mouseSpriteWasHit;
      }
      
      protected function createMouseEvent(param1:Number, param2:Number, param3:Number, param4:Number, param5:String, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean) : RoomSpriteMouseEvent
      {
         var _loc13_:Number = param1 - UnknownVarFromRoomSpriteCanvas_Int_2 / 2;
         var _loc14_:Number = param2 - UnknownVarFromRoomSpriteCanvas_Int_3 / 2;
         var _loc11_:String = "canvas_" + _id;
         var _loc12_:RoomSpriteMouseEvent = null;
         return new RoomSpriteMouseEvent(param5,_loc11_ + "_" + UnknownVarFromRoomSpriteCanvas_Int_1,_loc11_,param6,_loc13_,_loc14_,param3,param4,param8,param7,param9,param10);
      }
      
      private function checkMouseClickHits(param1:Number, param2:Number, param3:Boolean, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false) : Boolean
      {
         var _loc10_:String = null;
         var _loc11_:Boolean = false;
         var _loc15_:String = "";
         var _loc12_:ExtendedSprite = null;
         var _loc14_:RoomSpriteMouseEvent = null;
         var _loc9_:String = "click";
         if(param3)
         {
            _loc9_ = "doubleClick";
         }
         var _loc13_:Array = [];
         var _loc8_:int = 0;
         _loc8_ = activeSpriteCount - 1;
         while(_loc8_ >= 0)
         {
            _loc12_ = getSprite(_loc8_);
            if(_loc12_ != null && _loc12_.clickHandling)
            {
               if(_loc12_.hitTest(param1 - _loc12_.x,param2 - _loc12_.y))
               {
                  _loc15_ = getObjectId(_loc12_);
                  if(_loc13_.indexOf(_loc15_) < 0)
                  {
                     _loc10_ = _loc12_.tag;
                     _loc14_ = createMouseEvent(param1,param2,param1 - _loc12_.x,param2 - _loc12_.y,_loc9_,_loc10_,param4,param5,param6,param7);
                     bufferMouseEvent(_loc14_,_loc15_);
                     _loc13_.push(_loc15_);
                  }
               }
               _loc11_ = true;
            }
            _loc8_--;
         }
         processMouseEvents();
         return _loc11_;
      }
      
      private function checkMouseHits(param1:Number, param2:Number, param3:String, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false) : Boolean
      {
         var _loc12_:String = null;
         var _loc16_:String = null;
         var _loc11_:int = 0;
         var _loc13_:Boolean = false;
         var _loc18_:String = "";
         var _loc14_:ExtendedSprite = null;
         var _loc17_:RoomSpriteMouseEvent = null;
         var _loc15_:Array = [];
         var _loc8_:ObjectMouseData = null;
         var _loc10_:int = 0;
         _loc10_ = activeSpriteCount - 1;
         while(_loc10_ >= 0)
         {
            _loc14_ = getSprite(_loc10_) as ExtendedSprite;
            if(_loc14_ != null && _loc14_.hitTestPoint(param1 - _loc14_.x,param2 - _loc14_.y))
            {
               if(!_loc14_.skipMouseHandling)
               {
                  if(!(_loc14_.clickHandling && (param3 == "click" || param3 == "doubleClick")))
                  {
                     _loc18_ = getObjectId(_loc14_);
                     if(_loc15_.indexOf(_loc18_) < 0)
                     {
                        _loc12_ = _loc14_.tag;
                        _loc8_ = UnknownVarFromRoomSpriteCanvas_Map_1.getValue(_loc18_) as ObjectMouseData;
                        if(_loc8_ != null)
                        {
                           if(_loc8_.spriteTag != _loc12_)
                           {
                              _loc17_ = createMouseEvent(0,0,0,0,"rollOut",_loc8_.spriteTag,param4,param5,param6,param7);
                              bufferMouseEvent(_loc17_,_loc18_);
                           }
                        }
                        if(param3 == "mouseMove" && (_loc8_ == null || _loc8_.spriteTag != _loc12_))
                        {
                           _loc17_ = createMouseEvent(param1,param2,param1 - _loc14_.x,param2 - _loc14_.y,"rollOver",_loc12_,param4,param5,param6,param7);
                        }
                        else
                        {
                           _loc17_ = createMouseEvent(param1,param2,param1 - _loc14_.x,param2 - _loc14_.y,param3,_loc12_,param4,param5,param6,param7);
                           _loc17_.spriteOffsetX = _loc14_.offsetRefX;
                           _loc17_.spriteOffsetY = _loc14_.offsetRefY;
                        }
                        if(_loc8_ == null)
                        {
                           _loc8_ = new ObjectMouseData();
                           _loc8_.objectId = _loc18_;
                           UnknownVarFromRoomSpriteCanvas_Map_1.add(_loc18_,_loc8_);
                        }
                        _loc8_.spriteTag = _loc12_;
                        if(param3 != "mouseMove" || param1 != UnknownVarFromRoomSpriteCanvas_Number_1 || param2 != UnknownVarFromRoomSpriteCanvas_Number_2)
                        {
                           bufferMouseEvent(_loc17_,_loc18_);
                        }
                        _loc15_.push(_loc18_);
                     }
                     _loc13_ = true;
                  }
               }
            }
            _loc10_--;
         }
         var _loc9_:Array = UnknownVarFromRoomSpriteCanvas_Map_1.getKeys();
         _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            _loc16_ = _loc9_[_loc10_] as String;
            _loc11_ = int(_loc15_.indexOf(_loc16_));
            if(_loc11_ >= 0)
            {
               _loc9_[_loc10_] = null;
            }
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            _loc18_ = _loc9_[_loc10_] as String;
            if(_loc18_ != null)
            {
               _loc8_ = UnknownVarFromRoomSpriteCanvas_Map_1.remove(_loc18_) as ObjectMouseData;
               if(_loc8_ != null)
               {
                  _loc17_ = createMouseEvent(0,0,0,0,"rollOut",_loc8_.spriteTag,param4,param5,param6,param7);
                  bufferMouseEvent(_loc17_,_loc18_);
               }
            }
            _loc10_++;
         }
         processMouseEvents();
         UnknownVarFromRoomSpriteCanvas_Number_1 = param1;
         UnknownVarFromRoomSpriteCanvas_Number_2 = param2;
         return _loc13_;
      }
      
      protected function bufferMouseEvent(param1:RoomSpriteMouseEvent, param2:String) : void
      {
         if(_eventCache != null && param1 != null)
         {
            _eventCache.remove(param2);
            _eventCache.add(param2,param1);
         }
      }
      
      protected function processMouseEvents() : void
      {
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc4_:RoomSpriteMouseEvent = null;
         var _loc6_:IRoomObject = null;
         var _loc1_:IRoomObjectMouseHandler = null;
         if(_container == null || _eventCache == null)
         {
            return;
         }
         var _loc2_:int = int(_eventCache.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_eventCache == null)
            {
               return;
            }
            _loc5_ = _eventCache.getKey(_loc3_);
            _loc4_ = _eventCache.getWithIndex(_loc3_);
            if(_loc5_ != null && _loc4_ != null)
            {
               _loc6_ = _container.getRoomObject(_loc5_);
               if(_loc6_ != null)
               {
                  if(UnknownVarFromRoomSpriteCanvas_IRoomRenderingCanvasMouseListener_1 != null)
                  {
                     UnknownVarFromRoomSpriteCanvas_IRoomRenderingCanvasMouseListener_1.processRoomCanvasMouseEvent(_loc4_,_loc6_,geometry);
                  }
                  else
                  {
                     _loc1_ = _loc6_.getMouseHandler();
                     if(_loc1_ != null)
                     {
                        _loc1_.mouseEvent(_loc4_,_geometry);
                     }
                  }
               }
            }
            _loc3_++;
         }
         if(_eventCache)
         {
            _eventCache.reset();
         }
      }
      
      public function update() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(UnknownVarFromRoomSpriteCanvas_Int_7 == 0)
         {
            _loc2_ = UnknownVarFromRoomSpriteCanvas_Point_1.x - _screenOffsetX;
            _loc1_ = UnknownVarFromRoomSpriteCanvas_Point_1.y - _screenOffsetY;
            checkMouseHits(_loc2_ / _scale,_loc1_ / _scale,"mouseMove");
         }
         UnknownVarFromRoomSpriteCanvas_Int_7 = 0;
         UnknownVarFromRoomSpriteCanvas_Int_1++;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = false;
         if(param1.type == "click" || param1.type == "doubleClick")
         {
            _loc2_ = param1.type == "doubleClick";
            checkMouseClickHits(param1.localX,param1.localY,_loc2_,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
         }
      }
      
      public function getId() : int
      {
         return _id;
      }
   }
}


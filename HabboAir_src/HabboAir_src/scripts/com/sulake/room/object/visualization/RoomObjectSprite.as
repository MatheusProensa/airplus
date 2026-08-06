package com.sulake.room.object.visualization
{
   import com.sulake.room.object.enum.RoomObjectSpriteType;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public final class RoomObjectSprite implements IRoomObjectSprite
   {
      private static var UnknownVarFromRoomObjectSprite_Int_1:int = 0;
      
      private var _asset:BitmapData = null;
      
      private var _assetName:String = "";
      
      private var _libraryAssetName:String = "";
      
      private var _assetPosture:String = null;
      
      private var _assetGesture:String = null;
      
      private var _visible:Boolean = true;
      
      private var _tag:String = "";
      
      private var _alpha:int = 255;
      
      private var _color:int = 16777215;
      
      private var _blendMode:String = "normal";
      
      private var _flipH:Boolean = false;
      
      private var _flipV:Boolean = false;
      
      private var _direction:int = 0;
      
      private var _offset:Point = new Point(0,0);
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _depth:Number = 0;
      
      private var _planeId:int = 0;
      
      private var _varyingDepth:Boolean = false;
      
      private var _alphaTolerance:int = 128;
      
      private var _clickHandling:Boolean = false;
      
      private var _skipMouseHandling:Boolean = false;
      
      private var _updateId:int = 0;
      
      private var _instanceId:int = 0;
      
      private var _filters:Array = null;
      
      protected var _spriteType:int = RoomObjectSpriteType.DEFAULT;
      
      private var _objectType:String;
      
      public function RoomObjectSprite()
      {
         super();
         _instanceId = UnknownVarFromRoomObjectSprite_Int_1++;
      }
      
      public function dispose() : void
      {
         _asset = null;
         _width = 0;
         _height = 0;
      }
      
      public function get asset() : BitmapData
      {
         return _asset;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function get assetPosture() : String
      {
         return _assetPosture;
      }
      
      public function set assetPosture(param1:String) : void
      {
         _assetPosture = param1;
      }
      
      public function get assetGesture() : String
      {
         return _assetGesture;
      }
      
      public function set assetGesture(param1:String) : void
      {
         _assetGesture = param1;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function get tag() : String
      {
         return _tag;
      }
      
      public function get alpha() : int
      {
         return _alpha;
      }
      
      public function get color() : int
      {
         return _color;
      }
      
      public function get blendMode() : String
      {
         return _blendMode;
      }
      
      public function get flipV() : Boolean
      {
         return _flipV;
      }
      
      public function get flipH() : Boolean
      {
         return _flipH;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function get offsetX() : int
      {
         return _offset.x;
      }
      
      public function get offsetY() : int
      {
         return _offset.y;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function get relativeDepth() : Number
      {
         return _depth;
      }
      
      public function get varyingDepth() : Boolean
      {
         return _varyingDepth;
      }
      
      public function get clickHandling() : Boolean
      {
         return _clickHandling;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get updateId() : int
      {
         return _updateId;
      }
      
      public function get filters() : Array
      {
         return _filters;
      }
      
      public function get spriteType() : int
      {
         return _spriteType;
      }
      
      public function get objectType() : String
      {
         return _objectType;
      }
      
      public function set objectType(param1:String) : void
      {
         _objectType = param1;
      }
      
      public function get planeId() : int
      {
         return _planeId;
      }
      
      public function set planeId(param1:int) : void
      {
         _planeId = param1;
      }
      
      public function set spriteType(param1:int) : void
      {
         _spriteType = param1;
      }
      
      public function set asset(param1:BitmapData) : void
      {
         if(param1 == _asset)
         {
            return;
         }
         if(param1 != null)
         {
            _width = param1.width;
            _height = param1.height;
         }
         _asset = param1;
         _updateId++;
      }
      
      public function set assetName(param1:String) : void
      {
         if(param1 == _assetName)
         {
            return;
         }
         _assetName = param1;
         _updateId++;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(param1 == _visible)
         {
            return;
         }
         _visible = param1;
         _updateId++;
      }
      
      public function set tag(param1:String) : void
      {
         if(param1 == _tag)
         {
            return;
         }
         _tag = param1;
         _updateId++;
      }
      
      public function set alpha(param1:int) : void
      {
         param1 &= 255;
         if(param1 == _alpha)
         {
            return;
         }
         _alpha = param1;
         _updateId++;
      }
      
      public function set color(param1:int) : void
      {
         param1 &= 16777215;
         if(param1 == _color)
         {
            return;
         }
         _color = param1;
         _updateId++;
      }
      
      public function set blendMode(param1:String) : void
      {
         if(param1 == _blendMode)
         {
            return;
         }
         _blendMode = param1;
         _updateId++;
      }
      
      public function set filters(param1:Array) : void
      {
         if(param1 == _filters)
         {
            return;
         }
         _filters = param1;
         _updateId++;
      }
      
      public function set flipH(param1:Boolean) : void
      {
         if(param1 == _flipH)
         {
            return;
         }
         _flipH = param1;
         _updateId++;
      }
      
      public function set flipV(param1:Boolean) : void
      {
         if(param1 == _flipV)
         {
            return;
         }
         _flipV = param1;
         _updateId++;
      }
      
      public function set direction(param1:int) : void
      {
         _direction = param1;
      }
      
      public function set offsetX(param1:int) : void
      {
         if(param1 == _offset.x)
         {
            return;
         }
         _offset.x = param1;
         _updateId++;
      }
      
      public function set offsetY(param1:int) : void
      {
         if(param1 == _offset.y)
         {
            return;
         }
         _offset.y = param1;
         _updateId++;
      }
      
      public function set relativeDepth(param1:Number) : void
      {
         if(param1 == _depth)
         {
            return;
         }
         _depth = param1;
         _updateId++;
      }
      
      public function set varyingDepth(param1:Boolean) : void
      {
         if(param1 == _varyingDepth)
         {
            return;
         }
         _varyingDepth = param1;
         _updateId++;
      }
      
      public function set clickHandling(param1:Boolean) : void
      {
         if(_clickHandling == param1)
         {
            return;
         }
         _clickHandling = param1;
         _updateId++;
      }
      
      public function get alphaTolerance() : int
      {
         return _alphaTolerance;
      }
      
      public function set alphaTolerance(param1:int) : void
      {
         if(_alphaTolerance == param1)
         {
            return;
         }
         _alphaTolerance = param1;
         _updateId++;
      }
      
      public function get libraryAssetName() : String
      {
         return _libraryAssetName;
      }
      
      public function set libraryAssetName(param1:String) : void
      {
         _libraryAssetName = param1;
      }
      
      public function get skipMouseHandling() : Boolean
      {
         return _skipMouseHandling;
      }
      
      public function set skipMouseHandling(param1:Boolean) : void
      {
         _skipMouseHandling = param1;
      }
   }
}


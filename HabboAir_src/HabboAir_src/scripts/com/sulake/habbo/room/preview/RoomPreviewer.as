package com.sulake.habbo.room.preview
{
   import com.sulake.core.runtime.Component;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.habbo.room.object.data.LegacyStuffData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.object.visualization.IRoomObjectVisualization;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.RoomId;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class RoomPreviewer
   {
      private static const PREVIEW_CANVAS_ID:int = 1;
      
      private static const PREVIEW_OBJECT_ID:int = 1;
      
      private static const PREVIEW_WALL_ITEM_DEFAULT_DIRECTION:int = 90;
      
      private static const PREVIEW_WALL_ITEM_MIRRORED_DIRECTION:int = 180;
      
      private static const ALLOWED_IMAGE_CUT:Number = 0.25;
      
      public static const SCALE_NORMAL:int = 64;
      
      public static const SCALE_SMALL:int = 32;
      
      private static const AUTOMATIC_STATE_CHANGE_INTERVAL:int = 2500;
      
      private static const PREVIEW_OBJECT_LOCATION:Vector3d = new Vector3d(2,2,0);
      
      private static const PREVIEW_WALL_ITEM_LOCATION:Vector3d = new Vector3d(0.5,2.3,1.8);
      
      private var _roomEngine:IRoomEngine;
      
      private var _previewRoomId:int = 1;
      
      private var UnknownVarFromRoomPreviewer_Int_1:int = 0;
      
      private var UnknownVarFromRoomPreviewer_Int_2:int = 0;
      
      private var UnknownVarFromRoomPreviewer_String_1:String = "";
      
      private var _currentPreviewRectangle:Rectangle = null;
      
      private var _currentPreviewCanvasWidth:int = 0;
      
      private var UnknownVarFromRoomPreviewer_Int_3:int = 0;
      
      private var UnknownVarFromRoomPreviewer_Int_4:int = 64;
      
      private var UnknownVarFromRoomPreviewer_Boolean_1:Boolean;
      
      private var UnknownVarFromRoomPreviewer_Boolean_2:Boolean;
      
      private var _previousAutomaticStateChangeTime:int;
      
      private var _addViewOffset:Point = new Point(0,0);
      
      private var _centerWallItems:Boolean = false;
      
      private var _disableUpdate:Boolean = false;
      
      public function RoomPreviewer(param1:IRoomEngine, param2:int = 1)
      {
         super();
         _roomEngine = param1;
         _previewRoomId = RoomId.makeRoomPreviewerId(param2);
         if(_roomEngine)
         {
            _roomEngine.events.addEventListener("REOE_ADDED",onRoomObjectAdded);
            _roomEngine.events.addEventListener("REOE_CONTENT_UPDATED",onRoomObjectAdded);
            _roomEngine.events.addEventListener("REE_INITIALIZED",onRoomInitialized);
         }
      }
      
      public function dispose() : void
      {
         reset(true);
         if(_roomEngine && _roomEngine.events != null)
         {
            _roomEngine.events.removeEventListener("REOE_ADDED",onRoomObjectAdded);
            _roomEngine.events.removeEventListener("REOE_CONTENT_UPDATED",onRoomObjectAdded);
            _roomEngine.events.removeEventListener("REE_INITIALIZED",onRoomInitialized);
         }
      }
      
      public function createRoomForPreviews() : void
      {
         var _loc1_:int = 0;
         var _loc2_:RoomPlaneParser = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(_roomEngine)
         {
            _loc1_ = 7;
            _loc2_ = new RoomPlaneParser();
            _loc2_.initializeTileMap(_loc1_ + 2,_loc1_ + 2);
            _loc4_ = 1;
            while(_loc4_ < 1 + _loc1_)
            {
               _loc3_ = 1;
               while(_loc3_ < 1 + _loc1_)
               {
                  _loc2_.setTileHeight(_loc3_,_loc4_,0);
                  _loc3_++;
               }
               _loc4_++;
            }
            _loc2_.initializeFromTileData();
            _roomEngine.initializeRoom(_previewRoomId,_loc2_.getXML());
            _loc2_.dispose();
         }
      }
      
      public function reset(param1:Boolean) : void
      {
         if(_roomEngine)
         {
            _roomEngine.disposeObjectFurniture(_previewRoomId,1);
            _roomEngine.disposeObjectWallItem(_previewRoomId,1);
            _roomEngine.disposeObjectUser(_previewRoomId,1);
            if(!param1)
            {
               updatePreviewRoomView();
            }
         }
         UnknownVarFromRoomPreviewer_Int_2 = -2;
      }
      
      public function addFurnitureIntoRoom(param1:int, param2:IVector3d, param3:IStuffData = null, param4:String = null) : int
      {
         var _loc6_:IRoomObject = null;
         var _loc5_:int = -1;
         if(param3 == null)
         {
            param3 = new LegacyStuffData();
         }
         if(isRoomEngineReady)
         {
            if(UnknownVarFromRoomPreviewer_Int_2 == 10 && UnknownVarFromRoomPreviewer_Int_1 == param1)
            {
               return 1;
            }
            reset(false);
            UnknownVarFromRoomPreviewer_Int_1 = param1;
            UnknownVarFromRoomPreviewer_Int_2 = 10;
            UnknownVarFromRoomPreviewer_String_1 = "";
            if(_roomEngine.addObjectFurniture(_previewRoomId,1,param1,PREVIEW_OBJECT_LOCATION,param2,0,param3,NaN,-1,0,0,"",true,false))
            {
               _previousAutomaticStateChangeTime = getTimer();
               UnknownVarFromRoomPreviewer_Boolean_2 = true;
               _loc5_ = 1;
               _loc6_ = _roomEngine.getRoomObject(_previewRoomId,1,UnknownVarFromRoomPreviewer_Int_2);
               if(_loc6_)
               {
                  if(param4 != null)
                  {
                     (_loc6_.getModel() as IRoomObjectModelController).setString("furniture_extras",param4);
                  }
                  applyInvisibleLayerState(_loc6_);
               }
               updatePreviewRoomView();
            }
         }
         return _loc5_;
      }
      
      public function canRotatePreviewFurniture() : Boolean
      {
         var _loc1_:Array = getPreviewFurnitureAllowedDirections();
         return _loc1_ != null && _loc1_.length > 1;
      }
      
      public function rotatePreviewFurniture(param1:Boolean) : Boolean
      {
         var _loc2_:IRoomObjectController = getPreviewFurnitureObject();
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:int = getValidPreviewFurnitureDirection(_loc2_,param1);
         if(_loc3_ == _loc2_.getDirection().x)
         {
            return false;
         }
         _loc2_.setDirection(new Vector3d(_loc3_));
         updatePreviewRoomView(true);
         updateRoomEngine();
         return true;
      }
      
      public function canRotatePreviewWallItem() : Boolean
      {
         return getPreviewWallItemObject() != null;
      }
      
      public function rotatePreviewWallItem() : Boolean
      {
         var _loc1_:IRoomObjectController = getPreviewWallItemObject();
         if(_loc1_ == null)
         {
            return false;
         }
         var _loc2_:int = isPreviewWallItemMirrored(_loc1_.getDirection().x) ? 90 : 180;
         _loc1_.setDirection(new Vector3d(_loc2_));
         updatePreviewWallItemLocation(_loc1_);
         _currentPreviewRectangle = null;
         updatePreviewRoomView(true);
         updateRoomEngine();
         return true;
      }
      
      public function addWallItemIntoRoom(param1:int, param2:IVector3d, param3:String) : int
      {
         var _loc5_:IRoomObject = null;
         var _loc4_:int = -1;
         if(isRoomEngineReady)
         {
            if(UnknownVarFromRoomPreviewer_Int_2 == 20 && UnknownVarFromRoomPreviewer_Int_1 == param1 && UnknownVarFromRoomPreviewer_String_1 == param3)
            {
               return 1;
            }
            reset(false);
            UnknownVarFromRoomPreviewer_Int_1 = param1;
            UnknownVarFromRoomPreviewer_Int_2 = 20;
            UnknownVarFromRoomPreviewer_String_1 = param3;
            if(_roomEngine.addObjectWallItem(_previewRoomId,1,param1,PREVIEW_WALL_ITEM_LOCATION,param2,0,param3,0,0,"",-1,false))
            {
               _previousAutomaticStateChangeTime = getTimer();
               UnknownVarFromRoomPreviewer_Boolean_2 = true;
               _loc5_ = _roomEngine.getRoomObject(_previewRoomId,1,UnknownVarFromRoomPreviewer_Int_2);
               if(_loc5_ != null)
               {
                  applyInvisibleLayerState(_loc5_);
               }
               return 1;
            }
         }
         return _loc4_;
      }
      
      public function addAvatarIntoRoom(param1:String, param2:int = 0) : int
      {
         if(isRoomEngineReady)
         {
            reset(false);
            UnknownVarFromRoomPreviewer_Int_1 = 1;
            UnknownVarFromRoomPreviewer_Int_2 = 100;
            UnknownVarFromRoomPreviewer_String_1 = param1;
            if(_roomEngine.addObjectUser(_previewRoomId,1,PREVIEW_OBJECT_LOCATION,new Vector3d(90,0,0),135,1,param1))
            {
               _previousAutomaticStateChangeTime = getTimer();
               UnknownVarFromRoomPreviewer_Boolean_2 = true;
               updateUserGesture(1);
               updateUserEffect(param2);
               updateUserPosture("std");
            }
            updatePreviewRoomView();
            return 1;
         }
         return -1;
      }
      
      public function updateUserPosture(param1:String, param2:String = "") : void
      {
         if(isRoomEngineReady)
         {
            _roomEngine.updateObjectUserPosture(_previewRoomId,1,param1,param2);
         }
      }
      
      public function updateUserGesture(param1:int) : void
      {
         if(isRoomEngineReady)
         {
            _roomEngine.updateObjectUserGesture(_previewRoomId,1,param1);
         }
      }
      
      public function updateUserEffect(param1:int) : void
      {
         if(isRoomEngineReady)
         {
            _roomEngine.updateObjectUserEffect(_previewRoomId,1,param1);
         }
      }
      
      public function updateObjectUserFigure(param1:String, param2:String = null, param3:String = null, param4:Boolean = false) : Boolean
      {
         if(isRoomEngineReady)
         {
            return _roomEngine.updateObjectUserFigure(_previewRoomId,1,param1,param2,param3,param4);
         }
         return false;
      }
      
      public function updateObjectUserAction(param1:String, param2:int, param3:String = null) : void
      {
         if(isRoomEngineReady)
         {
            _roomEngine.updateObjectUserAction(_previewRoomId,1,param1,param2,param3);
         }
      }
      
      public function changeRoomObjectState() : void
      {
         if(isRoomEngineReady)
         {
            UnknownVarFromRoomPreviewer_Boolean_2 = false;
            if(UnknownVarFromRoomPreviewer_Int_2 != 100)
            {
               _roomEngine.changeObjectState(_previewRoomId,1,UnknownVarFromRoomPreviewer_Int_2);
            }
         }
      }
      
      private function checkAutomaticRoomObjectStateChange() : void
      {
         var _loc1_:int = 0;
         if(UnknownVarFromRoomPreviewer_Boolean_2)
         {
            _loc1_ = getTimer();
            if(_loc1_ > _previousAutomaticStateChangeTime + 2500)
            {
               _previousAutomaticStateChangeTime = _loc1_;
               if(isRoomEngineReady)
               {
                  _roomEngine.changeObjectState(_previewRoomId,1,UnknownVarFromRoomPreviewer_Int_2);
               }
            }
         }
      }
      
      public function getRoomCanvas(param1:int, param2:int) : DisplayObject
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:IRoomGeometry = null;
         if(_roomEngine)
         {
            _loc3_ = _roomEngine.createRoomCanvas(_previewRoomId,1,param1,param2,UnknownVarFromRoomPreviewer_Int_4);
            _roomEngine.setRoomCanvasMask(_previewRoomId,1,true);
            _loc4_ = _roomEngine.getRoomCanvasGeometry(_previewRoomId,1);
            if(_loc4_ != null)
            {
               _loc4_.adjustLocation(PREVIEW_OBJECT_LOCATION,30);
            }
            _currentPreviewCanvasWidth = param1;
            UnknownVarFromRoomPreviewer_Int_3 = param2;
            return _loc3_;
         }
         return null;
      }
      
      public function modifyRoomCanvas(param1:int, param2:int) : void
      {
         if(_roomEngine)
         {
            _currentPreviewCanvasWidth = param1;
            UnknownVarFromRoomPreviewer_Int_3 = param2;
            _roomEngine.modifyRoomCanvas(_previewRoomId,1,param1,param2);
         }
      }
      
      public function set addViewOffset(param1:Point) : void
      {
         _addViewOffset = param1;
      }
      
      public function get addViewOffset() : Point
      {
         return _addViewOffset;
      }
      
      public function set centerWallItems(param1:Boolean) : void
      {
         _centerWallItems = param1;
      }
      
      private function updatePreviewObjectBoundingRectangle(param1:Point) : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:Rectangle = _roomEngine.getRoomObjectBoundingRectangle(_previewRoomId,1,UnknownVarFromRoomPreviewer_Int_2,1);
         if(_loc3_ != null && param1 != null)
         {
            _loc3_.offset(-(_currentPreviewCanvasWidth >> 1),-(UnknownVarFromRoomPreviewer_Int_3 >> 1));
            _loc3_.offset(-param1.x,-param1.y);
            if(_currentPreviewRectangle == null)
            {
               _currentPreviewRectangle = _loc3_;
            }
            else
            {
               _loc2_ = _currentPreviewRectangle.union(_loc3_);
               if(_loc2_.width - _currentPreviewRectangle.width > _currentPreviewCanvasWidth - _currentPreviewRectangle.width >> 1 || _loc2_.height - _currentPreviewRectangle.height > UnknownVarFromRoomPreviewer_Int_3 - _currentPreviewRectangle.height >> 1 || _currentPreviewRectangle.width < 1 || _currentPreviewRectangle.height < 1)
               {
                  _currentPreviewRectangle = _loc2_;
               }
            }
         }
      }
      
      private function validatePreviewSize(param1:Point) : Point
      {
         var _loc2_:IRoomGeometry = null;
         if(_currentPreviewRectangle.width < 1 || _currentPreviewRectangle.height < 1)
         {
            return param1;
         }
         if(isRoomEngineReady)
         {
            _loc2_ = _roomEngine.getRoomCanvasGeometry(_previewRoomId,1);
            if(_currentPreviewRectangle.width > _currentPreviewCanvasWidth * (1 + 0.25) || _currentPreviewRectangle.height > UnknownVarFromRoomPreviewer_Int_3 * (1 + 0.25))
            {
               if((_roomEngine as Component).getBoolean("zoom.enabled"))
               {
                  if(_roomEngine.getRoomCanvasScale(_previewRoomId,1) != 0.5)
                  {
                     _roomEngine.setRoomCanvasScale(_previewRoomId,1,0.5,null,null,false,false,true);
                     UnknownVarFromRoomPreviewer_Int_4 = 32;
                     UnknownVarFromRoomPreviewer_Boolean_1 = true;
                     param1.x >>= 1;
                     param1.y >>= 1;
                     _currentPreviewRectangle.left >>= 2;
                     _currentPreviewRectangle.right >>= 2;
                     _currentPreviewRectangle.top >>= 2;
                     _currentPreviewRectangle.bottom >>= 2;
                  }
               }
               else if(_loc2_.isZoomedIn())
               {
                  _loc2_.performZoomOut();
                  UnknownVarFromRoomPreviewer_Int_4 = 32;
                  UnknownVarFromRoomPreviewer_Boolean_1 = true;
                  param1.x >>= 1;
                  param1.y >>= 1;
                  _currentPreviewRectangle.left >>= 2;
                  _currentPreviewRectangle.right >>= 2;
                  _currentPreviewRectangle.top >>= 2;
                  _currentPreviewRectangle.bottom >>= 2;
               }
            }
            else if(_currentPreviewRectangle.width << 1 < _currentPreviewCanvasWidth * (1 + 0.25) - 5 && _currentPreviewRectangle.height << 1 < UnknownVarFromRoomPreviewer_Int_3 * (1 + 0.25) - 5)
            {
               if((_roomEngine as Component).getBoolean("zoom.enabled"))
               {
                  if(_roomEngine.getRoomCanvasScale(_previewRoomId,1) != 1 && !UnknownVarFromRoomPreviewer_Boolean_1)
                  {
                     _roomEngine.setRoomCanvasScale(_previewRoomId,1,1,null,null,false,false,true);
                     UnknownVarFromRoomPreviewer_Int_4 = 64;
                     param1.x <<= 1;
                     param1.y <<= 1;
                  }
               }
               else if(!_loc2_.isZoomedIn() && !UnknownVarFromRoomPreviewer_Boolean_1)
               {
                  _loc2_.performZoomIn();
                  UnknownVarFromRoomPreviewer_Int_4 = 64;
                  param1.x <<= 1;
                  param1.y <<= 1;
               }
            }
         }
         return param1;
      }
      
      public function zoomIn() : void
      {
         var _loc1_:IRoomGeometry = null;
         if(isRoomEngineReady)
         {
            if((_roomEngine as Component).getBoolean("zoom.enabled"))
            {
               _roomEngine.setRoomCanvasScale(_previewRoomId,1,1);
            }
            _loc1_ = _roomEngine.getRoomCanvasGeometry(_previewRoomId,1);
            if(!_loc1_)
            {
               return;
            }
            _loc1_.performZoomIn();
         }
         UnknownVarFromRoomPreviewer_Int_4 = 64;
      }
      
      public function zoomOut() : void
      {
         var _loc1_:IRoomGeometry = null;
         if(isRoomEngineReady)
         {
            if((_roomEngine as Component).getBoolean("zoom.enabled"))
            {
               _roomEngine.setRoomCanvasScale(_previewRoomId,1,0.5);
            }
            else
            {
               _loc1_ = _roomEngine.getRoomCanvasGeometry(_previewRoomId,1);
               if(!_loc1_)
               {
                  return;
               }
               _loc1_.performZoomOut();
            }
         }
         UnknownVarFromRoomPreviewer_Int_4 = 32;
      }
      
      public function updateAvatarDirectionAndLocation(param1:int, param2:int, param3:Vector3d = null) : void
      {
         if(isRoomEngineReady)
         {
            if(param3 == null)
            {
               param3 = PREVIEW_OBJECT_LOCATION;
            }
            _roomEngine.updateObjectUser(_previewRoomId,1,param3,param3,false,0,new Vector3d(param1 * 45,0,0),param2 * 45);
         }
      }
      
      public function updateObjectRoom(param1:String = null, param2:String = null, param3:String = null, param4:Boolean = false) : Boolean
      {
         if(isRoomEngineReady)
         {
            return _roomEngine.updateObjectRoom(_previewRoomId,param1,param2,param3,false);
         }
         return false;
      }
      
      public function updateRoomWallsAndFloorVisibility(param1:Boolean, param2:Boolean = true) : void
      {
         if(isRoomEngineReady)
         {
            _roomEngine.updateObjectRoomVisibilities(_previewRoomId,param1,param2);
         }
      }
      
      private function getCanvasOffset(param1:Point) : Point
      {
         var _loc7_:Number = NaN;
         if(_centerWallItems && UnknownVarFromRoomPreviewer_Int_2 == 20 && (_currentPreviewRectangle.width < 1 || _currentPreviewRectangle.height < 1))
         {
            if(_addViewOffset.x != param1.x)
            {
               return new Point(_addViewOffset.x,param1.y);
            }
            return null;
         }
         if(_currentPreviewRectangle.width < 1 || _currentPreviewRectangle.height < 1)
         {
            return param1;
         }
         var _loc4_:int = int(_centerWallItems && UnknownVarFromRoomPreviewer_Int_2 == 20 ? _addViewOffset.x : -(_currentPreviewRectangle.left + _currentPreviewRectangle.right) >> 1);
         var _loc2_:* = -(_currentPreviewRectangle.top + _currentPreviewRectangle.bottom) >> 1;
         var _loc3_:* = UnknownVarFromRoomPreviewer_Int_3 - _currentPreviewRectangle.height >> 1;
         if(_loc3_ > 10)
         {
            _loc2_ += Math.min(15,_loc3_ - 10);
         }
         else if(UnknownVarFromRoomPreviewer_Int_2 != 100)
         {
            _loc2_ += 5 - Math.max(0,_loc3_ / 2);
         }
         else
         {
            _loc2_ -= 5 - Math.min(0,_loc3_ / 2);
         }
         _loc2_ += _addViewOffset.y;
         if(!_centerWallItems || UnknownVarFromRoomPreviewer_Int_2 != 20)
         {
            _loc4_ += _addViewOffset.x;
         }
         var _loc5_:int = _loc4_ - param1.x;
         var _loc6_:int = _loc2_ - param1.y;
         if(_loc5_ != 0 || _loc6_ != 0)
         {
            _loc7_ = Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
            if(_loc7_ > 10)
            {
               _loc4_ = param1.x + _loc5_ * 10 / _loc7_;
               _loc2_ = param1.y + _loc6_ * 10 / _loc7_;
            }
            return new Point(_loc4_,_loc2_);
         }
         return null;
      }
      
      public function updatePreviewRoomView(param1:Boolean = false) : void
      {
         var _loc3_:Point = null;
         var _loc4_:int = 0;
         var _loc2_:Point = null;
         if(_disableUpdate && !param1)
         {
            return;
         }
         checkAutomaticRoomObjectStateChange();
         if(isRoomEngineReady)
         {
            _loc3_ = _roomEngine.getRoomCanvasScreenOffset(_previewRoomId,1);
            if(_loc3_ != null)
            {
               updatePreviewObjectBoundingRectangle(_loc3_);
               if(_currentPreviewRectangle != null)
               {
                  _loc4_ = UnknownVarFromRoomPreviewer_Int_4;
                  _loc3_ = validatePreviewSize(_loc3_);
                  _loc2_ = getCanvasOffset(_loc3_);
                  if(_loc2_ != null)
                  {
                     _roomEngine.setRoomCanvasScreenOffset(_previewRoomId,1,_loc2_);
                  }
                  if(UnknownVarFromRoomPreviewer_Int_4 != _loc4_)
                  {
                     _currentPreviewRectangle = null;
                  }
               }
            }
         }
      }
      
      public function set disableUpdate(param1:Boolean) : void
      {
         _disableUpdate = param1;
      }
      
      public function set disableRoomEngineUpdate(param1:Boolean) : void
      {
         if(isRoomEngineReady)
         {
            _roomEngine.disableUpdate = param1;
         }
      }
      
      public function get previewRoomId() : int
      {
         return _previewRoomId;
      }
      
      private function onRoomInitialized(param1:RoomEngineEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:* = param1.type;
         if("REE_INITIALIZED" === _loc2_)
         {
            if(param1.roomId == _previewRoomId)
            {
               if(_roomEngine)
               {
                  _roomEngine.updateObjectRoom(_previewRoomId,"110","99999");
               }
            }
         }
      }
      
      private function onRoomObjectAdded(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:IRoomObject = null;
         if(param1.roomId == _previewRoomId && param1.objectId == 1 && param1.category == UnknownVarFromRoomPreviewer_Int_2)
         {
            _currentPreviewRectangle = null;
            UnknownVarFromRoomPreviewer_Boolean_1 = false;
            _loc2_ = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
            if(_loc2_ != null)
            {
               applyInvisibleLayerState(_loc2_);
            }
            if(_loc2_ != null && _loc2_.getModel() != null && param1.category == 20)
            {
               updatePreviewWallItemLocation(_loc2_ as IRoomObjectController);
            }
         }
      }
      
      private function applyInvisibleLayerState(param1:IRoomObject) : void
      {
         if(param1 == null || _roomEngine == null)
         {
            return;
         }
         var _loc2_:IRoomObjectModelController = param1.getModel() as IRoomObjectModelController;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.setNumber("furniture_invisible_layer",1);
      }
      
      private function getPreviewFurnitureObject() : IRoomObjectController
      {
         if(!isRoomEngineReady || UnknownVarFromRoomPreviewer_Int_2 != 10)
         {
            return null;
         }
         return _roomEngine.getRoomObject(_previewRoomId,1,UnknownVarFromRoomPreviewer_Int_2) as IRoomObjectController;
      }
      
      private function getPreviewFurnitureAllowedDirections() : Array
      {
         var _loc1_:IRoomObjectController = getPreviewFurnitureObject();
         if(_loc1_ == null || _loc1_.getModel() == null)
         {
            return null;
         }
         return _loc1_.getModel().getNumberArray("furniture_allowed_directions");
      }
      
      private function getValidPreviewFurnitureDirection(param1:IRoomObjectController, param2:Boolean) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == null || param1.getModel() == null)
         {
            return 0;
         }
         var _loc3_:Array = param1.getModel().getNumberArray("furniture_allowed_directions");
         var _loc6_:int = int(param1.getDirection().x);
         if(_loc3_ != null && _loc3_.length > 0)
         {
            _loc4_ = int(_loc3_.indexOf(_loc6_));
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  if(_loc6_ <= _loc3_[_loc5_])
                  {
                     break;
                  }
                  _loc4_++;
                  _loc5_++;
               }
               _loc4_ %= _loc3_.length;
            }
            if(param2)
            {
               _loc4_ = (_loc4_ + 1) % _loc3_.length;
            }
            else
            {
               _loc4_ = (_loc4_ - 1 + _loc3_.length) % _loc3_.length;
            }
            _loc6_ = int(_loc3_[_loc4_]);
         }
         return _loc6_;
      }
      
      private function getPreviewWallItemObject() : IRoomObjectController
      {
         if(!isRoomEngineReady || UnknownVarFromRoomPreviewer_Int_2 != 20)
         {
            return null;
         }
         return _roomEngine.getRoomObject(_previewRoomId,1,UnknownVarFromRoomPreviewer_Int_2) as IRoomObjectController;
      }
      
      private function isPreviewWallItemMirrored(param1:Number) : Boolean
      {
         param1 = (param1 % 360 + 360) % 360;
         return param1 == 180;
      }
      
      private function updatePreviewWallItemLocation(param1:IRoomObjectController) : void
      {
         if(param1 == null || _roomEngine == null)
         {
            return;
         }
         var _loc2_:Boolean = isPreviewWallItemMirrored(param1.getDirection().x);
         var _loc3_:Number = _loc2_ ? PREVIEW_WALL_ITEM_LOCATION.y : PREVIEW_WALL_ITEM_LOCATION.x;
         var _loc4_:Number = _loc2_ ? PREVIEW_WALL_ITEM_LOCATION.x : PREVIEW_WALL_ITEM_LOCATION.y;
         _roomEngine.updateObjectWallItemLocation(_previewRoomId,1,new Vector3d(_loc3_,_loc4_,getPreviewWallItemZ(param1)));
      }
      
      private function getPreviewWallItemZ(param1:IRoomObjectController) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1 != null && param1.getModel() != null)
         {
            _loc2_ = Number(param1.getModel().getNumber("furniture_size_z"));
            _loc3_ = Number(param1.getModel().getNumber("furniture_center_z"));
            if(!isNaN(_loc2_) && !isNaN(_loc3_))
            {
               return (3.6 - _loc2_) / 2 + _loc3_;
            }
         }
         var _loc4_:IVector3d = param1 != null ? param1.getLocation() : null;
         if(_loc4_ != null && !isNaN(_loc4_.z))
         {
            return _loc4_.z;
         }
         return PREVIEW_WALL_ITEM_LOCATION.z;
      }
      
      public function updateRoomEngine() : void
      {
         if(isRoomEngineReady)
         {
            _roomEngine.runUpdate();
         }
      }
      
      public function getGenericRoomObjectImage(param1:String, param2:String, param3:IVector3d, param4:int, param5:UnknownIHabboRoom1, param6:uint = 0, param7:String = null, param8:IStuffData = null, param9:int = -1, param10:int = -1, param11:String = null) : UnknownHabboRoom1
      {
         if(isRoomEngineReady)
         {
            return _roomEngine.getGenericRoomObjectImage(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         }
         return null;
      }
      
      public function getRoomObjectImage(param1:int, param2:IVector3d, param3:int, param4:UnknownIHabboRoom1, param5:uint = 0) : UnknownHabboRoom1
      {
         if(isRoomEngineReady)
         {
            return _roomEngine.getRoomObjectImage(_previewRoomId,1,param1,param2,param3,param4,param5);
         }
         return null;
      }
      
      public function getRoomObjectCurrentImage() : BitmapData
      {
         var _loc2_:IRoomObject = null;
         var _loc1_:IRoomObjectVisualization = null;
         if(isRoomEngineReady)
         {
            _loc2_ = _roomEngine.getRoomObject(_previewRoomId,1,100);
            if(_loc2_)
            {
               _loc1_ = _loc2_.getVisualization();
               if(_loc1_)
               {
                  return _loc1_.getImage(16777215,-1);
               }
            }
         }
         return null;
      }
      
      public function get isRoomEngineReady() : Boolean
      {
         return _roomEngine != null && _roomEngine.isInitialized;
      }
   }
}


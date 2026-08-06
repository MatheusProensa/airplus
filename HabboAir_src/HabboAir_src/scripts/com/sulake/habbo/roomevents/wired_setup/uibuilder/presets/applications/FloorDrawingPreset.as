package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.NeighborhoodFloor;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.BitmapViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import com.sulake.room.utils.GridLineInterpolation;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class FloorDrawingPreset extends WiredUIPreset
   {
      public static var floor_editor_tile_base:Class = floor_editor_tile_base_1_png;
      
      public static var floor_editor_tile_entry:Class = floor_editor_tile_entry_1_png;
      
      public static var floor_editor_border_N:Class = fp_border_N_1_png;
      
      public static var floor_editor_border_NE:Class = fp_border_NE_1_png;
      
      public static var floor_editor_border_E:Class = fp_border_E_1_png;
      
      public static var floor_editor_border_SE:Class = fp_border_SE_1_png;
      
      public static var floor_editor_border_S:Class = fp_border_S_1_png;
      
      public static var floor_editor_border_SW:Class = fp_border_SW_1_png;
      
      public static var floor_editor_border_W:Class = fp_border_W_1_png;
      
      public static var floor_editor_border_NW:Class = fp_border_NW_1_png;
      
      private static var FLOOR_EDITOR_BORDERS:Array = [Bitmap(new floor_editor_border_N()).bitmapData,Bitmap(new floor_editor_border_NE()).bitmapData,Bitmap(new floor_editor_border_E()).bitmapData,Bitmap(new floor_editor_border_SE()).bitmapData,Bitmap(new floor_editor_border_S()).bitmapData,Bitmap(new floor_editor_border_SW()).bitmapData,Bitmap(new floor_editor_border_W()).bitmapData,Bitmap(new floor_editor_border_NW()).bitmapData];
      
      private static var TAKEN_TILE_RGB:Array = [0,0.4,0.8];
      
      private static var UNTAKEN_TILE_RGB:Array = [0.2,0.2,0.2];
      
      private static var DRAW_MODES:Array = ["add_tile","remove_tile","set_root_tile"];
      
      private var UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1:BitmapViewPreset;
      
      private var UnknownVarFromFloorDrawingPreset_Function_1:Function;
      
      private var _tileImageBase:BitmapData = Bitmap(new floor_editor_tile_base()).bitmapData;
      
      private var _tileImageEntry:BitmapData = Bitmap(new floor_editor_tile_entry()).bitmapData;
      
      private var _tileTaken:BitmapData;
      
      private var _tileUntaken:BitmapData;
      
      private var _drawing:Boolean = false;
      
      private var _lastDrawAddress:Point = new Point(-1000,-1000);
      
      private var _selectionStartPoint:Point = new Point(-1000,-1000);
      
      private var _isRectSelect:Boolean;
      
      private var _drawMode:String = DRAW_MODES[0];
      
      private var UnknownVarFromFloorDrawingPreset_Point_1:Point = new Point(0,0);
      
      private var _floor:NeighborhoodFloor;
      
      public function FloorDrawingPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Function)
      {
         super(param1,param2,param3);
         UnknownVarFromFloorDrawingPreset_Function_1 = param4;
         UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1 = param2.createBitmapViewPreset();
         UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1.bitmapWindow.procedure = editorWindowProcedure;
         _tileTaken = _tileImageBase.clone();
         _tileTaken.colorTransform(_tileImageBase.rect,new ColorTransform(TAKEN_TILE_RGB[0],TAKEN_TILE_RGB[1],TAKEN_TILE_RGB[2]));
         _tileUntaken = _tileImageBase.clone();
         _tileUntaken.colorTransform(_tileImageBase.rect,new ColorTransform(UNTAKEN_TILE_RGB[0],UNTAKEN_TILE_RGB[1],UNTAKEN_TILE_RGB[2]));
      }
      
      private static function transformFromScreenSpace(param1:int, param2:int) : Point
      {
         var _loc3_:Number = param1 / 16;
         var _loc5_:Number = param2 / 8;
         var _loc4_:int = _loc5_ + _loc3_ - 1;
         var _loc6_:int = _loc5_ - _loc3_ - 1;
         return new Point(_loc4_,_loc6_);
      }
      
      private static function transformToScreenSpace(param1:int, param2:int) : Point
      {
         return new Point(8 * (param1 - param2 + 1),4 * (param1 + param2 + 1));
      }
      
      public function setFloor(param1:NeighborhoodFloor) : void
      {
         _floor = param1;
         updateView();
      }
      
      public function setRootTile(param1:int, param2:int) : void
      {
         UnknownVarFromFloorDrawingPreset_Point_1.x = param1;
         UnknownVarFromFloorDrawingPreset_Point_1.y = param2;
         updateView();
      }
      
      public function setMode(param1:String) : void
      {
         _drawMode = param1;
      }
      
      private function editorWindowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc13_:int = 0;
         var _loc7_:int = 0;
         var _loc12_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc5_:Object = null;
         if(bitmapWindow == null || _floor == null)
         {
            return;
         }
         if(param1.type != "WME_UP" && param1.type != "WME_UP_OUTSIDE" && param1.type != "WME_DOWN" && !(_drawing && param1.type == "WME_MOVE"))
         {
            return;
         }
         var _loc4_:Boolean = false;
         var _loc9_:int = bitmapWindow.width / 2;
         var _loc8_:int = bitmapWindow.height / 2 - bitmapWindow.bitmap.height / 2;
         var _loc3_:Point = transformFromScreenSpace(WindowMouseEvent(param1).localX - _loc9_,WindowMouseEvent(param1).localY - _loc8_);
         if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            _drawing = false;
            if(_isRectSelect)
            {
               _isRectSelect = false;
               _floor.submitTemporaryCache();
            }
         }
         if(param1.type == "WME_DOWN")
         {
            _drawing = true;
            _lastDrawAddress = new Point(-1000,-1000);
            if(WindowMouseEvent(param1).shiftKey)
            {
               _isRectSelect = true;
               _selectionStartPoint = _loc3_;
               _floor.initTemporaryCache();
            }
            applyDraw(_loc3_.x,_loc3_.y);
            _loc4_ = true;
            updateView();
            _lastDrawAddress = _loc3_;
         }
         if(_drawing && param1.type == "WME_MOVE")
         {
            if(_isRectSelect && _drawMode != DRAW_MODES[2])
            {
               _loc13_ = Math.min(_selectionStartPoint.x,_loc3_.x);
               _loc7_ = Math.max(_selectionStartPoint.x,_loc3_.x);
               _loc12_ = Math.min(_selectionStartPoint.y,_loc3_.y);
               _loc6_ = Math.max(_selectionStartPoint.y,_loc3_.y);
               _floor.clearTemporaryCache();
               _loc10_ = _loc13_;
               while(_loc10_ <= _loc7_)
               {
                  _loc11_ = _loc12_;
                  while(_loc11_ <= _loc6_)
                  {
                     applyDraw(_loc10_,_loc11_);
                     _loc4_ = true;
                     _loc11_++;
                  }
                  _loc10_++;
               }
               updateView();
            }
            else if(param1.type == "WME_MOVE")
            {
               if(_lastDrawAddress.x != _loc3_.x || _lastDrawAddress.y != _loc3_.y)
               {
                  applyDraw(_loc3_.x,_loc3_.y);
                  _loc4_ = true;
               }
               _loc5_ = interpolateBetweenLastPointAndDrawPoint(_loc3_);
               if(Math.abs(_loc5_.x) > 0 || Math.abs(_loc5_.y) > 0)
               {
                  updateView();
               }
            }
            _lastDrawAddress = _loc3_;
         }
         if(_loc4_)
         {
            _floor.occupationHasChanged();
         }
      }
      
      private function interpolateBetweenLastPointAndDrawPoint(param1:Point) : Object
      {
         if(_lastDrawAddress.x == -1000 && _lastDrawAddress.y == -1000)
         {
            _lastDrawAddress.x = param1.x;
            _lastDrawAddress.y = param1.y;
         }
         var _loc3_:int = param1.x - _lastDrawAddress.x;
         var _loc4_:int = param1.y - _lastDrawAddress.y;
         var _loc2_:Array = GridLineInterpolation.interpolationPoints(_lastDrawAddress.x,_lastDrawAddress.y,param1.x,param1.y);
         for each(var _loc5_ in _loc2_)
         {
            if(!(_lastDrawAddress.x == _loc5_.x && _lastDrawAddress.y == _loc5_.y || param1.x == _loc5_.x && param1.y == _loc5_.y))
            {
               applyDraw(_loc5_.x,_loc5_.y);
            }
         }
         return {
            "x":_loc3_,
            "y":_loc4_
         };
      }
      
      private function applyDraw(param1:int, param2:int) : Boolean
      {
         if(!allowDraw(param1,param2))
         {
            return false;
         }
         var _loc3_:int = NeighborhoodFloor.RADIUS - _floor.visualizingRadius;
         switch(_drawMode)
         {
            case DRAW_MODES[0]:
               _floor.setOccupied(param1 + _loc3_,param2 + _loc3_,true);
               break;
            case DRAW_MODES[1]:
               _floor.setOccupied(param1 + _loc3_,param2 + _loc3_,false);
               break;
            case DRAW_MODES[2]:
               setRootTileInternal(param1 - _floor.visualizingRadius,param2 - _floor.visualizingRadius);
               if(UnknownVarFromFloorDrawingPreset_Function_1 != null)
               {
                  UnknownVarFromFloorDrawingPreset_Function_1(UnknownVarFromFloorDrawingPreset_Point_1.x,UnknownVarFromFloorDrawingPreset_Point_1.y);
               }
         }
         return true;
      }
      
      private function setRootTileInternal(param1:int, param2:int) : void
      {
         UnknownVarFromFloorDrawingPreset_Point_1.x = param1;
         UnknownVarFromFloorDrawingPreset_Point_1.y = param2;
      }
      
      private function allowDraw(param1:int, param2:int) : Boolean
      {
         return param1 >= 0 && param2 >= 0 && param1 < _floor.visualizingDimension && param2 < _floor.visualizingDimension;
      }
      
      private function updateView() : void
      {
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc7_:BitmapData = null;
         var _loc8_:Point = null;
         var _loc10_:Point = null;
         var _loc6_:Rectangle = null;
         if(bitmapWindow == null || _floor == null)
         {
            return;
         }
         var _loc9_:Array = [];
         var _loc1_:int = NeighborhoodFloor.RADIUS - _floor.visualizingRadius;
         _loc15_ = 0;
         while(_loc15_ < _floor.visualizingDimension)
         {
            _loc14_ = 0;
            while(_loc14_ < _floor.visualizingDimension)
            {
               _loc8_ = transformToScreenSpace(_loc14_,_loc15_);
               _loc7_ = _floor.isOccupied(_loc14_ + _loc1_,_loc15_ + _loc1_) ? _tileTaken : _tileUntaken;
               _loc9_.push({
                  "point":_loc8_,
                  "image":_loc7_
               });
               _loc14_++;
            }
            _loc15_++;
         }
         if(UnknownVarFromFloorDrawingPreset_Point_1.x >= -_floor.visualizingRadius && UnknownVarFromFloorDrawingPreset_Point_1.x <= _floor.visualizingRadius && UnknownVarFromFloorDrawingPreset_Point_1.y >= -_floor.visualizingRadius && UnknownVarFromFloorDrawingPreset_Point_1.y <= _floor.visualizingRadius)
         {
            _loc9_.push({
               "point":transformToScreenSpace(UnknownVarFromFloorDrawingPreset_Point_1.x + _floor.visualizingRadius,UnknownVarFromFloorDrawingPreset_Point_1.y + _floor.visualizingRadius),
               "image":_tileImageEntry
            });
         }
         _loc14_ = 0;
         while(_loc14_ < _floor.visualizingDimension)
         {
            _loc9_.push({
               "point":transformToScreenSpace(_loc14_,-1),
               "image":FLOOR_EDITOR_BORDERS[0]
            });
            _loc9_.push({
               "point":transformToScreenSpace(_loc14_,_floor.visualizingDimension),
               "image":FLOOR_EDITOR_BORDERS[4]
            });
            _loc14_++;
         }
         _loc15_ = 0;
         while(_loc15_ < _floor.visualizingDimension)
         {
            _loc9_.push({
               "point":transformToScreenSpace(-1,_loc15_),
               "image":FLOOR_EDITOR_BORDERS[6]
            });
            _loc9_.push({
               "point":transformToScreenSpace(_floor.visualizingDimension,_loc15_),
               "image":FLOOR_EDITOR_BORDERS[2]
            });
            _loc15_++;
         }
         _loc9_.push({
            "point":transformToScreenSpace(-1,-1),
            "image":FLOOR_EDITOR_BORDERS[7]
         });
         _loc9_.push({
            "point":transformToScreenSpace(_floor.visualizingDimension,-1),
            "image":FLOOR_EDITOR_BORDERS[1]
         });
         _loc9_.push({
            "point":transformToScreenSpace(_floor.visualizingDimension,_floor.visualizingDimension),
            "image":FLOOR_EDITOR_BORDERS[3]
         });
         _loc9_.push({
            "point":transformToScreenSpace(-1,_floor.visualizingDimension),
            "image":FLOOR_EDITOR_BORDERS[5]
         });
         var _loc12_:int = 2147483647;
         var _loc11_:int = 2147483647;
         var _loc3_:int = -2147483648;
         var _loc2_:int = -2147483648;
         for each(var _loc16_ in _loc9_)
         {
            _loc10_ = _loc16_.point as Point;
            _loc6_ = _loc16_.image.rect;
            _loc12_ = Math.min(_loc12_,_loc10_.x);
            _loc11_ = Math.min(_loc11_,_loc10_.y);
            _loc3_ = Math.max(_loc3_,_loc10_.x + _loc6_.width);
            _loc2_ = Math.max(_loc2_,_loc10_.y + _loc6_.height);
         }
         var _loc13_:BitmapData = new BitmapData(_loc3_ - _loc12_,_loc2_ - _loc11_,false,UnknownVarFromWiredUIPreset_WiredStyle_1.advancedBackgroundColor);
         var _loc4_:Point = new Point(-_loc12_,-_loc11_);
         for each(var _loc5_ in _loc9_)
         {
            _loc13_.copyPixels(_loc5_.image,_loc5_.image.rect,_loc5_.point.add(_loc4_));
         }
         bitmapWindow.bitmap = _loc13_;
         UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1.setBitmapSize(_loc13_.width,_loc13_.height);
         resize();
      }
      
      private function get bitmapWindow() : IBitmapWrapperController
      {
         return UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1 != null ? UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1.bitmapWindow : null;
      }
      
      override public function get window() : IWindowModel
      {
         return UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1.window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1.resizeToWidth(param1);
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1.hasStaticWidth();
      }
      
      override public function get staticWidth() : int
      {
         return UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1.staticWidth;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromFloorDrawingPreset_BitmapViewPreset_1 = null;
         UnknownVarFromFloorDrawingPreset_Function_1 = null;
         _floor = null;
      }
   }
}


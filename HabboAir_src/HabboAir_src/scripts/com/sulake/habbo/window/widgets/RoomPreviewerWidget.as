package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class RoomPreviewerWidget implements IRoomPreviewerWidget
   {
      public static const TYPE:String = "room_previewer";
      
      private static const SCALE_KEY:String = "room_previewer:scale";
      
      private static const UnknownConstFromRoomPreviewerWidget_String_1:String = "room_previewer:offsetx";
      
      private static const UnknownConstFromRoomPreviewerWidget_String_2:String = "room_previewer:offsety";
      
      private static const UnknownConstFromRoomPreviewerWidget_String_3:String = "room_previewer:zoom";
      
      private static var ROOM_ID_COUNTER:int = 2;
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:scale",64,"int",false,[32,64]);
      
      private static const OFFSET_X_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:offsetx",0,"int",false);
      
      private static const OFFSET_Y_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:offsety",0,"int",false);
      
      private static const ZOOM_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:zoom",1,"int",false);
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromRoomPreviewerWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromRoomPreviewerWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromRoomPreviewerWidget_IDisplayObjectWrapperController_1:IDisplayObjectWrapperController;
      
      private var _roomPreviewer:RoomPreviewer;
      
      private var _scale:int = int(SCALE_DEFAULT.value);
      
      private var _offsetX:int = 0;
      
      private var _offsetY:int = 0;
      
      private var _zoom:int = int(ZOOM_DEFAULT.value);
      
      public function RoomPreviewerWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromRoomPreviewerWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         if(param2.roomEngine)
         {
            param2.roomEngine.events.addEventListener("REE_INITIALIZED",onRoomInitialized);
         }
         UnknownVarFromRoomPreviewerWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("room_previewer_xml").content as XML) as IWindowController_1;
         UnknownVarFromRoomPreviewerWidget_IDisplayObjectWrapperController_1 = UnknownVarFromRoomPreviewerWidget_IWindowController_1_1.findChildByName("room_canvas") as IDisplayObjectWrapperController;
         _roomPreviewer = new RoomPreviewer(param2.roomEngine,ROOM_ID_COUNTER++);
         _roomPreviewer.createRoomForPreviews();
         UnknownVarFromRoomPreviewerWidget_IWindowController_1_1.addEventListener("WME_CLICK",onClickRoomView);
         UnknownVarFromRoomPreviewerWidget_IWindowController_1_1.addEventListener("WE_RESIZE",onResizeCanvas);
         UnknownVarFromRoomPreviewerWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromRoomPreviewerWidget_IWindowController_1_1;
         UnknownVarFromRoomPreviewerWidget_IWindowController_1_1.width = UnknownVarFromRoomPreviewerWidget_IWidgetWindowController_1.width;
         UnknownVarFromRoomPreviewerWidget_IWindowController_1_1.height = UnknownVarFromRoomPreviewerWidget_IWidgetWindowController_1.height;
         _roomPreviewer.modifyRoomCanvas(UnknownVarFromRoomPreviewerWidget_IWindowController_1_1.width,UnknownVarFromRoomPreviewerWidget_IWindowController_1_1.height);
      }
      
      public function get scale() : int
      {
         return _scale;
      }
      
      public function set scale(param1:int) : void
      {
         _scale = param1;
         refresh();
      }
      
      public function get offsetX() : int
      {
         return _offsetX;
      }
      
      public function set offsetX(param1:int) : void
      {
         _offsetX = param1;
         refresh();
      }
      
      public function get offsetY() : int
      {
         return _offsetY;
      }
      
      public function set offsetY(param1:int) : void
      {
         _offsetY = param1;
         refresh();
      }
      
      public function get zoom() : int
      {
         return _zoom;
      }
      
      public function set zoom(param1:int) : void
      {
         _zoom = param1;
         refresh();
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(SCALE_DEFAULT.withValue(_scale));
         _loc1_.push(OFFSET_X_DEFAULT.withValue(_offsetX));
         _loc1_.push(OFFSET_Y_DEFAULT.withValue(_offsetY));
         _loc1_.push(ZOOM_DEFAULT.withValue(_zoom));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "room_previewer:scale":
                  scale = int(_loc2_.value);
                  break;
               case "room_previewer:offsetx":
                  offsetX = int(_loc2_.value);
                  break;
               case "room_previewer:offsety":
                  offsetY = int(_loc2_.value);
                  break;
               case "room_previewer:zoom":
                  zoom = int(_loc2_.value);
                  break;
            }
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_roomPreviewer != null)
            {
               _roomPreviewer.dispose();
               _roomPreviewer = null;
            }
            if(UnknownVarFromRoomPreviewerWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromRoomPreviewerWidget_IWindowController_1_1.dispose();
               UnknownVarFromRoomPreviewerWidget_IWindowController_1_1 = null;
            }
            if(UnknownVarFromRoomPreviewerWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromRoomPreviewerWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromRoomPreviewerWidget_IWidgetWindowController_1 = null;
            }
            if(_windowManager && _windowManager.roomEngine && _windowManager.roomEngine.events)
            {
               _windowManager.roomEngine.events.removeEventListener("REE_INITIALIZED",onRoomInitialized);
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      private function onRoomInitialized(param1:RoomEngineEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:* = param1.type;
         if("REE_INITIALIZED" === _loc3_)
         {
            if(_roomPreviewer && param1.roomId == _roomPreviewer.previewRoomId)
            {
               _roomPreviewer.reset(false);
               _loc2_ = _roomPreviewer.getRoomCanvas(UnknownVarFromRoomPreviewerWidget_IDisplayObjectWrapperController_1.width,UnknownVarFromRoomPreviewerWidget_IDisplayObjectWrapperController_1.height);
               if(_loc2_ != null)
               {
                  UnknownVarFromRoomPreviewerWidget_IDisplayObjectWrapperController_1.setDisplayObject(_loc2_);
               }
            }
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:DisplayObject = null;
         if(_roomPreviewer && _roomPreviewer.isRoomEngineReady)
         {
            _scale == 64 ? _roomPreviewer.zoomIn() : _roomPreviewer.zoomOut();
            _roomPreviewer.addViewOffset = new Point(_offsetX,_offsetY);
            _loc1_ = UnknownVarFromRoomPreviewerWidget_IDisplayObjectWrapperController_1.getDisplayObject();
            _loc1_.scaleX = _loc1_.scaleY = zoom;
            _loc1_.x = offsetX;
            _loc1_.y = offsetY;
         }
      }
      
      public function toString() : String
      {
         return "RoomPreviewerWidget";
      }
      
      private function onResizeCanvas(param1:WindowEvent, param2:IWindowModel = null) : void
      {
         var _loc3_:int = param1.window.width;
         var _loc4_:int = param1.window.height;
         _roomPreviewer.modifyRoomCanvas(_loc3_,_loc4_);
      }
      
      private function onClickRoomView(param1:WindowMouseEvent) : void
      {
         _roomPreviewer.changeRoomObjectState();
      }
      
      public function get roomPreviewer() : RoomPreviewer
      {
         return _roomPreviewer;
      }
      
      public function showPreview(param1:BitmapData) : void
      {
         var _loc2_:Bitmap = new Bitmap(param1);
         _loc2_.scaleX = 2;
         _loc2_.scaleY = 2;
         UnknownVarFromRoomPreviewerWidget_IDisplayObjectWrapperController_1.setDisplayObject(_loc2_);
      }
   }
}


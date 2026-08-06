package com.sulake.habbo.window.widgets
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class FurnitureImageWidget implements IFurnitureImageWidget, UnknownIHabboRoom1
   {
      public static const TYPE:String = "furniture_image";
      
      private static const UnknownConstFromFurnitureImageWidget_String_1:String = "furniture_image:furnitureType";
      
      private static const SCALE_KEY:String = "furniture_image:scale";
      
      private static const UnknownConstFromFurnitureImageWidget_String_2:String = "furniture_image:direction";
      
      private static const ITEM_TYPE_FLOOR:int = 0;
      
      private static const ITEM_TYPE_WALL:int = 1;
      
      private static const UnknownConstFromFurnitureImageWidget_Array_1:Array = ["northeast","east","southeast","south","southwest","west","northwest","north"];
      
      private static const SCALES:Array = [32,64];
      
      private static const FURNITURE_TYPE_DEFAULT:PropertyStruct = new PropertyStruct("furniture_image:furnitureType","table_plasto_square","String",false);
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("furniture_image:scale",64,"int",false,SCALES);
      
      private static const DIRECTION_DEFAULT:PropertyStruct = new PropertyStruct("furniture_image:direction",UnknownConstFromFurnitureImageWidget_Array_1[2],"String",false,UnknownConstFromFurnitureImageWidget_Array_1);
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromFurnitureImageWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromFurnitureImageWidget_IWindowController_1_1:IWindowController_1;
      
      private var _bitmap:IBitmapWrapperController;
      
      private var UnknownVarFromFurnitureImageWidget_IRegionWindow_1:IRegionWindow;
      
      private var _furnitureType:String = "table_plasto_square";
      
      private var _scale:int = int(SCALE_DEFAULT.value);
      
      private var _direction:int = UnknownConstFromFurnitureImageWidget_Array_1.indexOf(String(DIRECTION_DEFAULT.value));
      
      private var UnknownVarFromFurnitureImageWidget_Map_1:Map;
      
      private var UnknownVarFromFurnitureImageWidget_String_1:String;
      
      private var UnknownVarFromFurnitureImageWidget_Int_1:int = 0;
      
      private var UnknownVarFromFurnitureImageWidget_IStuffData_1:IStuffData = null;
      
      public function FurnitureImageWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromFurnitureImageWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromFurnitureImageWidget_Map_1 = new Map();
         UnknownVarFromFurnitureImageWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("furniture_image_xml").content as XML) as IWindowController_1;
         _bitmap = UnknownVarFromFurnitureImageWidget_IWindowController_1_1.findChildByName("bitmap") as IBitmapWrapperController;
         UnknownVarFromFurnitureImageWidget_IRegionWindow_1 = UnknownVarFromFurnitureImageWidget_IWindowController_1_1.findChildByName("region") as IRegionWindow;
         UnknownVarFromFurnitureImageWidget_IRegionWindow_1.addEventListener("WME_CLICK",onClick);
         refresh();
         UnknownVarFromFurnitureImageWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromFurnitureImageWidget_IWindowController_1_1;
         UnknownVarFromFurnitureImageWidget_IWindowController_1_1.width = UnknownVarFromFurnitureImageWidget_IWidgetWindowController_1.width;
         UnknownVarFromFurnitureImageWidget_IWindowController_1_1.height = UnknownVarFromFurnitureImageWidget_IWidgetWindowController_1.height;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromFurnitureImageWidget_IRegionWindow_1 != null)
            {
               UnknownVarFromFurnitureImageWidget_IRegionWindow_1.removeEventListener("WME_CLICK",onClick);
               UnknownVarFromFurnitureImageWidget_IRegionWindow_1.dispose();
               UnknownVarFromFurnitureImageWidget_IRegionWindow_1 = null;
            }
            _bitmap = null;
            if(UnknownVarFromFurnitureImageWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromFurnitureImageWidget_IWindowController_1_1.dispose();
               UnknownVarFromFurnitureImageWidget_IWindowController_1_1 = null;
            }
            if(UnknownVarFromFurnitureImageWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromFurnitureImageWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromFurnitureImageWidget_IWidgetWindowController_1 = null;
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
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(FURNITURE_TYPE_DEFAULT.withValue(_furnitureType));
         _loc1_.push(SCALE_DEFAULT.withValue(_scale));
         _loc1_.push(DIRECTION_DEFAULT.withValue(UnknownConstFromFurnitureImageWidget_Array_1[_direction]));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "furniture_image:furnitureType":
                  furnitureType = String(_loc2_.value);
                  break;
               case "furniture_image:scale":
                  scale = int(_loc2_.value);
                  break;
               case "furniture_image:direction":
                  direction = UnknownConstFromFurnitureImageWidget_Array_1.indexOf(String(_loc2_.value));
                  break;
            }
         }
      }
      
      public function get furnitureType() : String
      {
         return _furnitureType;
      }
      
      public function set furnitureType(param1:String) : void
      {
         _furnitureType = param1;
         refresh();
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
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(param1:int) : void
      {
         _direction = param1;
         refresh();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:String = UnknownVarFromFurnitureImageWidget_Map_1.getValue(param1);
         if(_loc3_ == _furnitureType)
         {
            refresh();
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function refresh() : void
      {
         var _loc1_:UnknownHabboRoom1 = null;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         _bitmap.bitmap = null;
         if(_windowManager.roomEngine != null)
         {
            _loc2_ = "std";
            _loc5_ = _windowManager.roomEngine.getFurnitureTypeId(_furnitureType);
            if(UnknownVarFromFurnitureImageWidget_Int_1 == 0)
            {
               _loc1_ = _windowManager.roomEngine.getFurnitureImage(_loc5_,new Vector3d(_direction * 45,0,0),_scale,this,0,UnknownVarFromFurnitureImageWidget_String_1,-1,-1,UnknownVarFromFurnitureImageWidget_IStuffData_1);
            }
            else
            {
               _loc1_ = _windowManager.roomEngine.getWallItemImage(_loc5_,new Vector3d(_direction * 45,0,0),_scale,this,0,!!UnknownVarFromFurnitureImageWidget_IStuffData_1 ? UnknownVarFromFurnitureImageWidget_IStuffData_1.getLegacyString() : "");
            }
            if(_loc1_ != null)
            {
               _loc4_ = _loc1_.id;
               UnknownVarFromFurnitureImageWidget_Map_1.remove(_loc4_);
               if(_loc4_ > 0)
               {
                  UnknownVarFromFurnitureImageWidget_Map_1.add(_loc4_,_furnitureType);
               }
               _bitmap.bitmap = _loc1_.data;
               _bitmap.disposesBitmap = true;
            }
         }
         if(_bitmap.bitmap == null || _bitmap.bitmap.width < 2)
         {
            _loc3_ = "placeholder_furni" + (_scale == 32 ? "_small" : "") + "_png";
            _bitmap.bitmap = _windowManager.assets.getAssetByName(_loc3_).content as BitmapData;
            _bitmap.disposesBitmap = false;
         }
         _bitmap.invalidate();
         UnknownVarFromFurnitureImageWidget_IWidgetWindowController_1.width = _bitmap.bitmap.width;
         UnknownVarFromFurnitureImageWidget_IWidgetWindowController_1.height = _bitmap.bitmap.height;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
      }
   }
}


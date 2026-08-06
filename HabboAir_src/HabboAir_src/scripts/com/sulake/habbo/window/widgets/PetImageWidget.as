package com.sulake.habbo.window.widgets
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class PetImageWidget implements IPetImageWidget, UnknownIHabboRoom1
   {
      public static const TYPE:String = "pet_image";
      
      private static const FIGURE_KEY:String = "pet_image:figure";
      
      private static const SCALE_KEY:String = "pet_image:scale";
      
      private static const UnknownConstFromPetImageWidget_String_1:String = "pet_image:direction";
      
      private static const UnknownConstFromPetImageWidget_String_2:String = "pet_image:zoomX";
      
      private static const UnknownConstFromPetImageWidget_String_3:String = "pet_image:zoomY";
      
      private static const SHRINK_ON_OVERFLOW_KEY:String = "pet_image:shrink_on_overflow";
      
      private static const UnknownConstFromPetImageWidget_Array_1:Array = ["northeast","east","southeast","south","southwest","west","northwest","north"];
      
      private static const SCALES:Array = [32,64];
      
      private static const FIGURE_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:figure","1 0 ffffff","String");
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:scale",64,"int",false,SCALES);
      
      private static const DIRECTION_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:direction",UnknownConstFromPetImageWidget_Array_1[2],"String",false,UnknownConstFromPetImageWidget_Array_1);
      
      private static const ZOOM_X_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:zoomX",1,"Number");
      
      private static const ZOOM_Y_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:zoomY",1,"Number");
      
      private static const SHRINK_ON_OVERFLOW_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:shrink_on_overflow",false,"Boolean");
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromPetImageWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromPetImageWidget_IWindowController_1_1:IWindowController_1;
      
      private var _bitmap:IBitmapWrapperController;
      
      private var UnknownVarFromPetImageWidget_IRegionWindow_1:IRegionWindow;
      
      private var _figure:String = String(FIGURE_DEFAULT.value);
      
      private var _scale:int = int(SCALE_DEFAULT.value);
      
      private var _direction:int = UnknownConstFromPetImageWidget_Array_1.indexOf(String(DIRECTION_DEFAULT.value));
      
      private var _zoomX:Number = Number(ZOOM_X_DEFAULT.value);
      
      private var _zoomY:Number = Number(ZOOM_Y_DEFAULT.value);
      
      private var _shrinkOnOverflow:Boolean = Boolean(SHRINK_ON_OVERFLOW_DEFAULT.value);
      
      private var UnknownVarFromPetImageWidget_Map_1:Map;
      
      private var UnknownVarFromPetImageWidget_BitmapData_1:BitmapData;
      
      public function PetImageWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromPetImageWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromPetImageWidget_Map_1 = new Map();
         UnknownVarFromPetImageWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("pet_image_xml").content as XML) as IWindowController_1;
         _bitmap = UnknownVarFromPetImageWidget_IWindowController_1_1.findChildByName("bitmap") as IBitmapWrapperController;
         UnknownVarFromPetImageWidget_IRegionWindow_1 = UnknownVarFromPetImageWidget_IWindowController_1_1.findChildByName("region") as IRegionWindow;
         refresh();
         UnknownVarFromPetImageWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromPetImageWidget_IWindowController_1_1;
         UnknownVarFromPetImageWidget_IWindowController_1_1.width = UnknownVarFromPetImageWidget_IWidgetWindowController_1.width;
         UnknownVarFromPetImageWidget_IWindowController_1_1.height = UnknownVarFromPetImageWidget_IWidgetWindowController_1.height;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromPetImageWidget_IRegionWindow_1 != null)
            {
               UnknownVarFromPetImageWidget_IRegionWindow_1.dispose();
               UnknownVarFromPetImageWidget_IRegionWindow_1 = null;
            }
            _bitmap = null;
            if(UnknownVarFromPetImageWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromPetImageWidget_IWindowController_1_1.dispose();
               UnknownVarFromPetImageWidget_IWindowController_1_1 = null;
            }
            if(UnknownVarFromPetImageWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromPetImageWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromPetImageWidget_IWidgetWindowController_1 = null;
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
         _loc1_.push(FIGURE_DEFAULT.withValue(_figure));
         _loc1_.push(SCALE_DEFAULT.withValue(_scale));
         _loc1_.push(DIRECTION_DEFAULT.withValue(UnknownConstFromPetImageWidget_Array_1[_direction]));
         _loc1_.push(ZOOM_X_DEFAULT.withValue(_zoomX));
         _loc1_.push(ZOOM_Y_DEFAULT.withValue(_zoomY));
         _loc1_.push(SHRINK_ON_OVERFLOW_DEFAULT.withValue(_shrinkOnOverflow));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "pet_image:figure":
                  figure = String(_loc2_.value);
                  break;
               case "pet_image:scale":
                  scale = int(_loc2_.value);
                  break;
               case "pet_image:direction":
                  direction = UnknownConstFromPetImageWidget_Array_1.indexOf(String(_loc2_.value));
                  break;
               case "pet_image:zoomX":
                  zoomX = Number(_loc2_.value);
                  break;
               case "pet_image:zoomY":
                  zoomY = Number(_loc2_.value);
                  break;
               case "pet_image:shrink_on_overflow":
                  shrinkOnOverflow = Boolean(_loc2_.value);
                  break;
            }
         }
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function set figure(param1:String) : void
      {
         _figure = cleanupAvatarString(param1);
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
      
      public function get shrinkOnOverflow() : Boolean
      {
         return _shrinkOnOverflow;
      }
      
      public function set shrinkOnOverflow(param1:Boolean) : void
      {
         _shrinkOnOverflow = param1;
         refresh();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:String = UnknownVarFromPetImageWidget_Map_1.getValue(param1);
         if(_loc3_ != null)
         {
            if(cleanupAvatarString(_loc3_) == _figure)
            {
               refresh();
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function refresh() : void
      {
         var _loc4_:String = null;
         var _loc2_:UnknownHabboRoom1 = null;
         var _loc6_:int = 0;
         var _loc5_:String = null;
         if(_bitmap == null)
         {
            return;
         }
         _bitmap.bitmap = null;
         _bitmap.blend = UnknownVarFromPetImageWidget_IWidgetWindowController_1.blend;
         var _loc1_:PetFigureData = new PetFigureData(_figure);
         if(_windowManager.roomEngine != null)
         {
            _loc4_ = "std";
            _loc2_ = _windowManager.roomEngine.getPetImage(_loc1_.typeId,_loc1_.paletteId,_loc1_.color,new Vector3d(_direction * 45),scale,this,true,0,_loc1_.customParts,_loc4_);
            if(_loc2_ != null)
            {
               _loc6_ = _loc2_.id;
               UnknownVarFromPetImageWidget_Map_1.remove(_loc6_);
               if(_loc6_ > 0)
               {
                  UnknownVarFromPetImageWidget_Map_1.add(_loc6_,_figure);
               }
               _bitmap.bitmap = _loc2_.data;
               _bitmap.disposesBitmap = true;
            }
         }
         if(_bitmap.bitmap == null || _bitmap.bitmap.width < 2)
         {
            _loc5_ = "placeholder_pet" + (_scale == 32 ? "_small" : "") + "_png";
            _bitmap.bitmap = _windowManager.assets.getAssetByName(_loc5_).content as BitmapData;
            _bitmap.disposesBitmap = false;
         }
         var _loc7_:Number = zoomX;
         var _loc3_:Number = zoomY;
         UnknownVarFromPetImageWidget_BitmapData_1 = _bitmap.bitmap;
         if(_shrinkOnOverflow && (UnknownVarFromPetImageWidget_BitmapData_1.width * zoomX > UnknownVarFromPetImageWidget_IWidgetWindowController_1.width || UnknownVarFromPetImageWidget_BitmapData_1.height * zoomY > UnknownVarFromPetImageWidget_IWidgetWindowController_1.height))
         {
            _loc7_ *= 0.5;
            _loc3_ *= 0.5;
         }
         if(_loc7_ != 1 || _loc3_ != 1)
         {
            _bitmap.bitmap = zoomBitmapData(_bitmap.bitmap,_loc7_,_loc3_);
         }
         _bitmap.invalidate();
      }
      
      private function zoomBitmapData(param1:BitmapData, param2:Number, param3:Number) : BitmapData
      {
         var _loc5_:Number = param1.width * param2;
         var _loc6_:Number = param1.height * param3;
         var _loc4_:BitmapData = new BitmapData(_loc5_,_loc6_,true,0);
         var _loc7_:Matrix = new Matrix();
         _loc7_.scale(param2,param3);
         _loc4_.draw(param1,_loc7_);
         return _loc4_;
      }
      
      private function cleanupAvatarString(param1:String) : String
      {
         return param1 == null ? String(FIGURE_DEFAULT.value) : param1.replace(/NaN/g,"");
      }
      
      public function get zoomX() : Number
      {
         return _zoomX;
      }
      
      public function get zoomY() : Number
      {
         return _zoomY;
      }
      
      public function set zoomX(param1:Number) : void
      {
         _zoomX = param1;
         refresh();
      }
      
      public function set zoomY(param1:Number) : void
      {
         _zoomY = param1;
         refresh();
      }
      
      public function get petWidth() : int
      {
         if(UnknownVarFromPetImageWidget_BitmapData_1 == null)
         {
            return 0;
         }
         return UnknownVarFromPetImageWidget_BitmapData_1.width;
      }
      
      public function get petHeight() : int
      {
         if(UnknownVarFromPetImageWidget_BitmapData_1 == null)
         {
            return 0;
         }
         return UnknownVarFromPetImageWidget_BitmapData_1.height;
      }
   }
}


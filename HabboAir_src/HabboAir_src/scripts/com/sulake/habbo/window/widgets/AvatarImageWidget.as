package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class AvatarImageWidget implements IAvatarImageWidget, UnknownIHabboAvatar1
   {
      public static const TYPE:String = "avatar_image";
      
      private static const FIGURE_KEY:String = "avatar_image:figure";
      
      private static const SCALE_KEY:String = "avatar_image:scale";
      
      private static const UnknownConstFromAvatarImageWidget_String_1:String = "avatar_image:only_head";
      
      private static const CROPPED_KEY:String = "avatar_image:cropped";
      
      private static const UnknownConstFromAvatarImageWidget_String_2:String = "avatar_image:direction";
      
      private static const UnknownConstFromAvatarImageWidget_String_3:String = "avatar_image:zoomX";
      
      private static const UnknownConstFromAvatarImageWidget_String_4:String = "avatar_image:zoomY";
      
      private static const UnknownConstFromAvatarImageWidget_Array_1:Array = ["northeast","east","southeast","south","southwest","west","northwest","north"];
      
      private static const FIGURE_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:figure","hd-180-1.ch-210-66.lg-270-82.sh-290-81","String");
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:scale","h","String",false,["sh","h"]);
      
      private static const ONLY_HEAD_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:only_head",false,"Boolean");
      
      private static const CROPPED_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:cropped",false,"Boolean");
      
      private static const DIRECTION_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:direction",UnknownConstFromAvatarImageWidget_Array_1[2],"String",false,UnknownConstFromAvatarImageWidget_Array_1);
      
      private static const ZOOM_X_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:zoomX",1,"Number");
      
      private static const ZOOM_Y_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:zoomY",1,"Number");
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromAvatarImageWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromAvatarImageWidget_IWindowController_1_1:IWindowController_1;
      
      private var _bitmap:IBitmapWrapperController;
      
      private var UnknownVarFromAvatarImageWidget_IRegionWindow_1:IRegionWindow;
      
      private var _figure:String = String(FIGURE_DEFAULT.value);
      
      private var UnknownVarFromAvatarImageWidget_Boolean_1:Boolean = false;
      
      private var _scale:String = String(SCALE_DEFAULT.value);
      
      private var _onlyHead:Boolean = Boolean(ONLY_HEAD_DEFAULT.value);
      
      private var _cropped:Boolean = Boolean(CROPPED_DEFAULT.value);
      
      private var _direction:int = UnknownConstFromAvatarImageWidget_Array_1.indexOf(String(DIRECTION_DEFAULT.value));
      
      private var _zoomX:Number = Number(ZOOM_X_DEFAULT.value);
      
      private var _zoomY:Number = Number(ZOOM_Y_DEFAULT.value);
      
      private var _userId:int;
      
      private var UnknownVarFromAvatarImageWidget_Boolean_2:Boolean;
      
      private const rc:Number = 0.3333333333333333;
      
      private const gc:Number = 0.3333333333333333;
      
      private const bc:Number = 0.3333333333333333;
      
      public function AvatarImageWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromAvatarImageWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromAvatarImageWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("avatar_image_xml").content as XML) as IWindowController_1;
         _bitmap = UnknownVarFromAvatarImageWidget_IWindowController_1_1.findChildByName("bitmap") as IBitmapWrapperController;
         UnknownVarFromAvatarImageWidget_IRegionWindow_1 = UnknownVarFromAvatarImageWidget_IWindowController_1_1.findChildByName("region") as IRegionWindow;
         UnknownVarFromAvatarImageWidget_IRegionWindow_1.addEventListener("WME_CLICK",onClick);
         refresh();
         UnknownVarFromAvatarImageWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromAvatarImageWidget_IWindowController_1_1;
         UnknownVarFromAvatarImageWidget_IWindowController_1_1.width = UnknownVarFromAvatarImageWidget_IWidgetWindowController_1.width;
         UnknownVarFromAvatarImageWidget_IWindowController_1_1.height = UnknownVarFromAvatarImageWidget_IWidgetWindowController_1.height;
      }
      
      private static function cleanupAvatarString(param1:String) : String
      {
         return param1 == null || param1.length == 0 ? String(FIGURE_DEFAULT.value) : param1.replace(/NaN/g,"");
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromAvatarImageWidget_IRegionWindow_1 != null)
            {
               UnknownVarFromAvatarImageWidget_IRegionWindow_1.removeEventListener("WME_CLICK",onClick);
               UnknownVarFromAvatarImageWidget_IRegionWindow_1.dispose();
               UnknownVarFromAvatarImageWidget_IRegionWindow_1 = null;
            }
            _bitmap = null;
            if(UnknownVarFromAvatarImageWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromAvatarImageWidget_IWindowController_1_1.dispose();
               UnknownVarFromAvatarImageWidget_IWindowController_1_1 = null;
            }
            if(UnknownVarFromAvatarImageWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromAvatarImageWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromAvatarImageWidget_IWidgetWindowController_1 = null;
            }
            if(UnknownVarFromAvatarImageWidget_Boolean_2)
            {
               _windowManager.avatarRenderer.events.removeEventListener("AVATAR_RENDER_READY",onAvatarRendererReady);
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
         _loc1_.push(ONLY_HEAD_DEFAULT.withValue(_onlyHead));
         _loc1_.push(CROPPED_DEFAULT.withValue(_cropped));
         _loc1_.push(DIRECTION_DEFAULT.withValue(UnknownConstFromAvatarImageWidget_Array_1[_direction]));
         _loc1_.push(ZOOM_X_DEFAULT.withValue(_zoomX));
         _loc1_.push(ZOOM_Y_DEFAULT.withValue(_zoomY));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "avatar_image:figure":
                  figure = String(_loc2_.value);
                  break;
               case "avatar_image:scale":
                  scale = String(_loc2_.value);
                  break;
               case "avatar_image:only_head":
                  onlyHead = Boolean(_loc2_.value);
                  break;
               case "avatar_image:cropped":
                  cropped = Boolean(_loc2_.value);
                  break;
               case "avatar_image:direction":
                  direction = UnknownConstFromAvatarImageWidget_Array_1.indexOf(String(_loc2_.value));
                  break;
               case "avatar_image:zoomX":
                  zoomX = Number(_loc2_.value);
                  break;
               case "avatar_image:zoomY":
                  zoomY = Number(_loc2_.value);
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
         if(param1 != _figure)
         {
            UnknownVarFromAvatarImageWidget_Boolean_1 = param1 == null || param1.length == 0;
            _figure = cleanupAvatarString(param1);
            refresh();
         }
      }
      
      public function get scale() : String
      {
         return _scale;
      }
      
      public function set scale(param1:String) : void
      {
         if(param1 != _scale)
         {
            _scale = param1;
            refresh();
         }
      }
      
      public function get onlyHead() : Boolean
      {
         return _onlyHead;
      }
      
      public function set onlyHead(param1:Boolean) : void
      {
         if(param1 != _onlyHead)
         {
            _onlyHead = param1;
            refresh();
         }
      }
      
      public function get cropped() : Boolean
      {
         return _cropped;
      }
      
      public function set cropped(param1:Boolean) : void
      {
         if(param1 != _cropped)
         {
            _cropped = param1;
            refresh();
         }
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(param1:int) : void
      {
         if(param1 != _direction)
         {
            _direction = param1;
            refresh();
         }
      }
      
      public function get zoomX() : Number
      {
         return _zoomX;
      }
      
      public function set zoomX(param1:Number) : void
      {
         if(param1 != _zoomX)
         {
            _zoomX = param1;
            refresh();
         }
      }
      
      public function get zoomY() : Number
      {
         return _zoomY;
      }
      
      public function set zoomY(param1:Number) : void
      {
         if(param1 != _zoomY)
         {
            _zoomY = param1;
            refresh();
         }
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function set userId(param1:int) : void
      {
         if(_userId != param1)
         {
            _userId = param1;
            UnknownVarFromAvatarImageWidget_IRegionWindow_1.visible = _userId > 0;
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(cleanupAvatarString(param1) == _figure)
         {
            refresh();
         }
      }
      
      private function onAvatarRendererReady(param1:Event) : void
      {
         UnknownVarFromAvatarImageWidget_Boolean_2 = false;
         _windowManager.avatarRenderer.events.removeEventListener("AVATAR_RENDER_READY",onAvatarRendererReady);
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:IAvatarImage_2 = null;
         var _loc2_:String = null;
         _bitmap.bitmap = null;
         if(_windowManager.avatarRenderer != null)
         {
            if(!_windowManager.avatarRenderer.isReady)
            {
               if(!UnknownVarFromAvatarImageWidget_Boolean_2)
               {
                  _windowManager.avatarRenderer.events.addEventListener("AVATAR_RENDER_READY",onAvatarRendererReady);
                  UnknownVarFromAvatarImageWidget_Boolean_2 = true;
               }
            }
            else
            {
               _loc3_ = _scale == "h" ? 1 : 0.5;
               _loc1_ = _windowManager.avatarRenderer.createAvatarImage(_figure,"h",null,this);
               if(_loc1_ != null)
               {
                  _loc1_.setDirection(_onlyHead ? "head" : "full",_direction);
                  if(_cropped)
                  {
                     _bitmap.bitmap = _loc1_.getCroppedImage(_onlyHead ? "head" : "full",_loc3_);
                  }
                  else
                  {
                     _bitmap.bitmap = _loc1_.getImage(_onlyHead ? "head" : "full",true,_loc3_);
                  }
                  if(UnknownVarFromAvatarImageWidget_Boolean_1)
                  {
                     greyBitmap(_bitmap);
                  }
                  _bitmap.disposesBitmap = true;
                  _loc1_.dispose();
               }
            }
         }
         if(_bitmap.bitmap == null || _bitmap.bitmap.width < 2)
         {
            _loc2_ = "placeholder_avatar" + (_scale == "sh" ? "_small" : "") + (_onlyHead ? "_head" : "") + (_cropped ? "_cropped" : "") + "_png";
            _bitmap.bitmap = _windowManager.assets.getAssetByName(_loc2_).content as BitmapData;
            _bitmap.disposesBitmap = false;
            greyBitmap(_bitmap);
         }
         if(_zoomX != 1 || _zoomY != 1)
         {
            _bitmap.bitmap = zoomBitmapData(_bitmap.bitmap,_zoomX,_zoomY);
            _bitmap.disposesBitmap = true;
         }
         _bitmap.invalidate();
         UnknownVarFromAvatarImageWidget_IWidgetWindowController_1.width = _bitmap.bitmap.width;
         UnknownVarFromAvatarImageWidget_IWidgetWindowController_1.height = _bitmap.bitmap.height;
      }
      
      private function zoomBitmapData(param1:BitmapData, param2:Number, param3:Number) : BitmapData
      {
         var _loc4_:BitmapData = new BitmapData(param1.width * param2,param1.height * param3,true,0);
         var _loc5_:Matrix = new Matrix();
         _loc5_.scale(param2,param3);
         _loc4_.draw(param1,_loc5_);
         return _loc4_;
      }
      
      private function greyBitmap(param1:IBitmapWrapperController) : void
      {
         _bitmap.bitmap.applyFilter(_bitmap.bitmap,_bitmap.bitmap.rect,new Point(),new ColorMatrixFilter([0.3333333333333333,0.3333333333333333,0.3333333333333333,0,0,0.3333333333333333,0.3333333333333333,0.3333333333333333,0,0,0.3333333333333333,0.3333333333333333,0.3333333333333333,0,0,0,0,0,1,0]));
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(_userId > 0)
         {
            _windowManager.communication.connection.send(new GetExtendedProfileMessageComposer(_userId));
         }
      }
   }
}


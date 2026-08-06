package com.sulake.habbo.window.widgets
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class IlluminaBorderWidget implements IIlluminaBorderWidget
   {
      public static const TYPE:String = "illumina_border";
      
      public static const BORDER_STYLE_ILLUMINA_LIGHT:String = "illumina_light";
      
      public static const BORDER_STYLE_ILLUMINA_DARK:String = "illumina_dark";
      
      public static const BORDER_STYLE_KEY:String = "illumina_border:border_style";
      
      private static const CONTENT_CHILD_KEY:String = "illumina_border:content_child";
      
      private static const CONTENT_PADDING_KEY:String = "illumina_border:content_padding";
      
      private static const SIDE_PADDING_KEY:String = "illumina_border:side_padding";
      
      private static const CHILD_MARGIN_KEY:String = "illumina_border:child_margin";
      
      private static const TOP_LEFT_CHILD_KEY:String = "illumina_border:top_left_child";
      
      private static const TOP_CENTER_CHILD_KEY:String = "illumina_border:top_center_child";
      
      private static const TOP_RIGHT_CHILD_KEY:String = "illumina_border:top_right_child";
      
      private static const BOTTOM_LEFT_CHILD_KEY:String = "illumina_border:bottom_left_child";
      
      private static const BOTTOM_CENTER_CHILD_KEY:String = "illumina_border:bottom_center_child";
      
      private static const BOTTOM_RIGHT_CHILD_KEY:String = "illumina_border:bottom_right_child";
      
      private static const LANDING_VIEW_MODE_KEY:String = "illumina_border:landing_view_mode";
      
      private static const TOP_LEFT:String = "top_left";
      
      private static const TOP:String = "top_center";
      
      private static const TOP_RIGHT:String = "top_right";
      
      private static const RIGHT:String = "center_right";
      
      private static const BOTTOM_RIGHT:String = "bottom_right";
      
      private static const BOTTOM:String = "bottom_center";
      
      private static const BOTTOM_LEFT:String = "bottom_left";
      
      private static const UnknownConstFromIlluminaBorderWidget_String_1:String = "center_left";
      
      public static const BORDER_STYLES:Array = ["illumina_light","illumina_dark"];
      
      private static const CONTENT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:content_child","","String");
      
      private static const CONTENT_PADDING_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:content_padding",5,"uint");
      
      private static const SIDE_PADDING_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:side_padding",15,"uint");
      
      private static const CHILD_MARGIN_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:child_margin",3,"uint");
      
      private static const TOP_LEFT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_left_child","","String");
      
      private static const TOP_CENTER_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_center_child","","String");
      
      private static const TOP_RIGHT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_right_child","","String");
      
      private static const BOTTOM_LEFT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_left_child","","String");
      
      private static const BOTTOM_CENTER_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_center_child","","String");
      
      private static const BOTTOM_RIGHT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_right_child","","String");
      
      private static const LANDING_VIEW_MODE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:landing_view_mode",false,"Boolean");
      
      private static const MATRIX:Matrix = new Matrix();
      
      private static const BORDER_PIECES:Array = ["top_left","top_center","top_right","center_right","bottom_right","bottom_center","bottom_left","center_left"];
      
      private var _borderPieces:Dictionary;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromIlluminaBorderWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromIlluminaBorderWidget_BitmapData_1:BitmapData;
      
      private var _children:IWindowController_1;
      
      private var _settingProperties:Boolean = false;
      
      private var UnknownVarFromIlluminaBorderWidget_Boolean_1:Boolean = false;
      
      private var _borderStyle:String;
      
      private var _contentChild:String = String(CONTENT_CHILD_DEFAULT.value);
      
      private var _contentPadding:uint = uint(CONTENT_PADDING_DEFAULT.value);
      
      private var _sidePadding:uint = uint(SIDE_PADDING_DEFAULT.value);
      
      private var _childMargin:uint = uint(CHILD_MARGIN_DEFAULT.value);
      
      private var _topLeftChild:String = String(TOP_LEFT_CHILD_DEFAULT.value);
      
      private var _topCenterChild:String = String(TOP_CENTER_CHILD_DEFAULT.value);
      
      private var _topRightChild:String = String(TOP_RIGHT_CHILD_DEFAULT.value);
      
      private var _bottomLeftChild:String = String(BOTTOM_LEFT_CHILD_DEFAULT.value);
      
      private var _bottomCenterChild:String = String(BOTTOM_CENTER_CHILD_DEFAULT.value);
      
      private var _bottomRightChild:String = String(BOTTOM_RIGHT_CHILD_DEFAULT.value);
      
      private var _landingViewMode:Boolean = Boolean(LANDING_VIEW_MODE_DEFAULT.value);
      
      public function IlluminaBorderWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromIlluminaBorderWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("illumina_border_xml").content as XML) as IWindowController_1;
         UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1 = UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.getChildByName("canvas") as IBitmapWrapperController;
         _children = UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.getChildByName("children") as IWindowController_1;
         borderStyle = String(UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.getDefaultProperty("illumina_border:border_style").value);
         UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.addEventListener("WE_RESIZE",onChange);
         UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.addEventListener("WE_RESIZED",onChange);
         _children.addEventListener("WE_CHILD_ADDED",onChange);
         _children.addEventListener("WE_CHILD_REMOVED",onChange);
         _children.addEventListener("WE_CHILD_RELOCATED",onChange);
         _children.addEventListener("WE_CHILD_RESIZED",onChange);
         UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromIlluminaBorderWidget_IWindowController_1_1;
         UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.width = UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.width;
         UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.height = UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.height;
      }
      
      private function onChange(param1:WindowEvent) : void
      {
         refresh();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromIlluminaBorderWidget_BitmapData_1 != null)
            {
               UnknownVarFromIlluminaBorderWidget_BitmapData_1.dispose();
               UnknownVarFromIlluminaBorderWidget_BitmapData_1 = null;
            }
            if(UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1 != null)
            {
               UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.removeEventListener("WE_RESIZE",onChange);
               UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.removeEventListener("WE_RESIZED",onChange);
               UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1 = null;
            }
            if(_children != null)
            {
               _children.removeEventListener("WE_CHILD_ADDED",onChange);
               _children.removeEventListener("WE_CHILD_REMOVED",onChange);
               _children.removeEventListener("WE_CHILD_RELOCATED",onChange);
               _children.removeEventListener("WE_CHILD_RESIZED",onChange);
               _children = null;
            }
            if(UnknownVarFromIlluminaBorderWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.dispose();
               UnknownVarFromIlluminaBorderWidget_IWindowController_1_1 = null;
            }
            if(UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1 = null;
            }
            _borderPieces = null;
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
         return _children.iterator;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.createProperty("illumina_border:border_style",_borderStyle));
         _loc1_.push(CONTENT_CHILD_DEFAULT.withValue(_contentChild));
         _loc1_.push(CONTENT_PADDING_DEFAULT.withValue(_contentPadding));
         _loc1_.push(SIDE_PADDING_DEFAULT.withValue(_sidePadding));
         _loc1_.push(CHILD_MARGIN_DEFAULT.withValue(_childMargin));
         _loc1_.push(TOP_LEFT_CHILD_DEFAULT.withValue(_topLeftChild));
         _loc1_.push(TOP_CENTER_CHILD_DEFAULT.withValue(_topCenterChild));
         _loc1_.push(TOP_RIGHT_CHILD_DEFAULT.withValue(_topRightChild));
         _loc1_.push(BOTTOM_LEFT_CHILD_DEFAULT.withValue(_bottomLeftChild));
         _loc1_.push(BOTTOM_CENTER_CHILD_DEFAULT.withValue(_bottomCenterChild));
         _loc1_.push(BOTTOM_RIGHT_CHILD_DEFAULT.withValue(_bottomRightChild));
         _loc1_.push(LANDING_VIEW_MODE_DEFAULT.withValue(_landingViewMode));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         _settingProperties = true;
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "illumina_border:border_style":
                  borderStyle = String(_loc2_.value);
                  break;
               case "illumina_border:content_child":
                  contentChild = String(_loc2_.value);
                  break;
               case "illumina_border:content_padding":
                  contentPadding = uint(_loc2_.value);
                  break;
               case "illumina_border:side_padding":
                  sidePadding = uint(_loc2_.value);
                  break;
               case "illumina_border:child_margin":
                  childMargin = uint(_loc2_.value);
                  break;
               case "illumina_border:top_left_child":
                  topLeftChild = String(_loc2_.value);
                  break;
               case "illumina_border:top_center_child":
                  topCenterChild = String(_loc2_.value);
                  break;
               case "illumina_border:top_right_child":
                  topRightChild = String(_loc2_.value);
                  break;
               case "illumina_border:bottom_left_child":
                  bottomLeftChild = String(_loc2_.value);
                  break;
               case "illumina_border:bottom_center_child":
                  bottomCenterChild = String(_loc2_.value);
                  break;
               case "illumina_border:bottom_right_child":
                  bottomRightChild = String(_loc2_.value);
                  break;
               case "illumina_border:landing_view_mode":
                  landingViewMode = Boolean(_loc2_.value);
                  break;
            }
         }
         _settingProperties = false;
         refresh();
      }
      
      public function get borderStyle() : String
      {
         return _borderStyle;
      }
      
      public function set borderStyle(param1:String) : void
      {
         _borderStyle = param1;
         _borderPieces = new Dictionary();
         for each(var _loc2_ in BORDER_PIECES)
         {
            _borderPieces[_loc2_] = _windowManager.assets.getAssetByName(_borderStyle + "_border_" + _loc2_);
         }
         refresh();
      }
      
      public function get contentChild() : String
      {
         return _contentChild;
      }
      
      public function set contentChild(param1:String) : void
      {
         _contentChild = param1 ?? "";
         refresh();
      }
      
      public function get contentPadding() : uint
      {
         return _contentPadding;
      }
      
      public function set contentPadding(param1:uint) : void
      {
         _contentPadding = param1;
         refresh();
      }
      
      public function get sidePadding() : uint
      {
         return _sidePadding;
      }
      
      public function set sidePadding(param1:uint) : void
      {
         _sidePadding = param1;
         refresh();
      }
      
      public function get childMargin() : uint
      {
         return _childMargin;
      }
      
      public function set childMargin(param1:uint) : void
      {
         _childMargin = param1;
         refresh();
      }
      
      public function get topLeftChild() : String
      {
         return _topLeftChild;
      }
      
      public function set topLeftChild(param1:String) : void
      {
         _topLeftChild = param1 ?? "";
         refresh();
      }
      
      public function get topCenterChild() : String
      {
         return _topCenterChild;
      }
      
      public function set topCenterChild(param1:String) : void
      {
         _topCenterChild = param1 ?? "";
         refresh();
      }
      
      public function get topRightChild() : String
      {
         return _topRightChild;
      }
      
      public function set topRightChild(param1:String) : void
      {
         _topRightChild = param1 ?? "";
         refresh();
      }
      
      public function get bottomLeftChild() : String
      {
         return _bottomLeftChild;
      }
      
      public function set bottomLeftChild(param1:String) : void
      {
         _bottomLeftChild = param1 ?? "";
         refresh();
      }
      
      public function get bottomCenterChild() : String
      {
         return _bottomCenterChild;
      }
      
      public function set bottomCenterChild(param1:String) : void
      {
         _bottomCenterChild = param1 ?? "";
         refresh();
      }
      
      public function get bottomRightChild() : String
      {
         return _bottomRightChild;
      }
      
      public function set bottomRightChild(param1:String) : void
      {
         _bottomRightChild = param1 ?? "";
         refresh();
      }
      
      public function get landingViewMode() : Boolean
      {
         return _landingViewMode;
      }
      
      public function set landingViewMode(param1:Boolean) : void
      {
         _landingViewMode = param1;
         refresh();
      }
      
      private function getPiece(param1:String) : BitmapDataAsset
      {
         return _borderPieces[param1];
      }
      
      private function getChildHeight(param1:String) : int
      {
         var _loc2_:IWindowModel = _children.getChildByName(param1);
         return param1 != null && param1.length > 0 && _loc2_ != null ? _loc2_.height : 0;
      }
      
      private function get topPadding() : int
      {
         return Math.max(getChildHeight(_topCenterChild),Math.max(getChildHeight(_topLeftChild),getChildHeight(_topRightChild))) / 2;
      }
      
      private function get bottomPadding() : int
      {
         return Math.max(getChildHeight(_bottomCenterChild),Math.max(getChildHeight(_bottomLeftChild),getChildHeight(_bottomRightChild))) / 2;
      }
      
      private function refresh() : void
      {
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:BitmapDataAsset = null;
         var _loc6_:BitmapData = null;
         var _loc13_:Rectangle = null;
         var _loc4_:Rectangle = null;
         var _loc1_:int = 0;
         var _loc8_:int = 0;
         if(_settingProperties || UnknownVarFromIlluminaBorderWidget_Boolean_1 || disposed)
         {
            return;
         }
         UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.limits.setEmpty();
         UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.width = UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.width;
         UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.height = UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.height;
         var _loc2_:IWindowModel = _children.getChildByName(_contentChild);
         if(_loc2_ != null)
         {
            _loc3_ = Math.max(1,_loc2_.width + 2 * _contentPadding);
            _loc9_ = Math.max(1,_loc2_.height + 2 * _contentPadding + topPadding + bottomPadding);
            UnknownVarFromIlluminaBorderWidget_Boolean_1 = true;
            if(UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.testParamFlag(131072))
            {
               UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.limits.minWidth = _loc3_;
               UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.limits.minHeight = _loc9_;
            }
            if(UnknownVarFromIlluminaBorderWidget_IWidgetWindowController_1.testParamFlag(147456))
            {
               UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.limits.minWidth = _loc3_;
               UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.limits.minHeight = _loc9_;
               UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.limits.maxWidth = _loc3_;
               UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.limits.maxHeight = _loc9_;
            }
            UnknownVarFromIlluminaBorderWidget_Boolean_1 = false;
         }
         if(UnknownVarFromIlluminaBorderWidget_BitmapData_1 == null || UnknownVarFromIlluminaBorderWidget_BitmapData_1.width != UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.width || UnknownVarFromIlluminaBorderWidget_BitmapData_1.height != UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.height)
         {
            UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.width = UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.width;
            UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.height = UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.height;
            _children.width = UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.width;
            _children.height = UnknownVarFromIlluminaBorderWidget_IWindowController_1_1.height;
            if(UnknownVarFromIlluminaBorderWidget_BitmapData_1 != null)
            {
               UnknownVarFromIlluminaBorderWidget_BitmapData_1.dispose();
            }
            UnknownVarFromIlluminaBorderWidget_BitmapData_1 = new BitmapData(UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.width,UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.height,true,0);
            UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.bitmap = UnknownVarFromIlluminaBorderWidget_BitmapData_1;
         }
         var _loc12_:Rectangle = UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.rectangle;
         _loc12_.y = _loc12_.y + topPadding;
         _loc12_.height -= topPadding + bottomPadding;
         UnknownVarFromIlluminaBorderWidget_BitmapData_1.lock();
         UnknownVarFromIlluminaBorderWidget_BitmapData_1.fillRect(new Rectangle(0,0,UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.width,UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.height),0);
         for(var _loc5_ in _borderPieces)
         {
            _loc10_ = getPiece(_loc5_);
            if(!(_loc10_ == null || _landingViewMode && (_loc5_ == "top_left" || _loc5_ == "center_left" || _loc5_ == "bottom_left")))
            {
               _loc6_ = _loc10_.content as BitmapData;
               _loc13_ = _loc10_.rectangle;
               _loc4_ = new Rectangle(_loc12_.x,_loc12_.y,_loc13_.width,_loc13_.height);
               switch(_loc5_)
               {
                  case "top_left":
                     break;
                  case "top_center":
                     _loc4_.x += getPiece("top_left").rectangle.width;
                     _loc4_.width = _loc12_.width - getPiece("top_left").rectangle.width - getPiece("top_right").rectangle.width;
                     break;
                  case "top_right":
                     _loc4_.x += _loc12_.width - _loc13_.width;
                     break;
                  case "center_right":
                     _loc4_.x += _loc12_.width - _loc13_.width;
                     _loc4_.y += getPiece("top_right").rectangle.height;
                     _loc4_.height = _loc12_.height - getPiece("top_right").rectangle.height - getPiece("bottom_right").rectangle.height;
                     break;
                  case "bottom_right":
                     _loc4_.x += _loc12_.width - _loc13_.width;
                     _loc4_.y += _loc12_.height - _loc13_.height;
                     break;
                  case "bottom_center":
                     _loc4_.x += getPiece("bottom_left").rectangle.width;
                     _loc4_.y += _loc12_.height - _loc13_.height;
                     _loc4_.width = _loc12_.width - getPiece("bottom_left").rectangle.width - getPiece("bottom_right").rectangle.width;
                     if(_landingViewMode)
                     {
                        _loc1_ = _loc4_.width / 2;
                        _loc4_.x += _loc1_;
                        _loc4_.width -= _loc1_;
                     }
                     break;
                  case "bottom_left":
                     _loc4_.y += _loc12_.height - _loc13_.height;
                     break;
                  case "center_left":
                     _loc4_.y += getPiece("top_left").rectangle.height;
                     _loc4_.height = _loc12_.height - getPiece("top_left").rectangle.height - getPiece("bottom_left").rectangle.height;
                     break;
                  default:
                     continue;
               }
               MATRIX.a = _loc4_.width / _loc13_.width;
               MATRIX.d = _loc4_.height / _loc13_.height;
               MATRIX.tx = _loc4_.x - _loc13_.x * MATRIX.a;
               MATRIX.ty = _loc4_.y - _loc13_.y * MATRIX.d;
               UnknownVarFromIlluminaBorderWidget_BitmapData_1.draw(_loc6_,MATRIX,null,null,_loc4_,false);
            }
         }
         var _loc11_:Array = [_topLeftChild,_topCenterChild,_topRightChild,_bottomLeftChild,_bottomCenterChild,_bottomRightChild];
         for each(var _loc7_ in _children.iterator)
         {
            if(_loc7_.name != null && _loc7_.name.length > 0)
            {
               _loc8_ = int(_loc11_.indexOf(_loc7_.name));
               if(_loc8_ < 0)
               {
                  if(_loc7_.name == _contentChild)
                  {
                     _loc7_.x = _loc12_.x + contentPadding;
                     _loc7_.y = _loc12_.y + contentPadding;
                     _loc7_.visible = true;
                  }
                  else
                  {
                     _loc7_.visible = false;
                  }
               }
               else
               {
                  switch(_loc8_ % 3)
                  {
                     case 0:
                        _loc7_.x = Math.min(_sidePadding,UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.width - _loc7_.width);
                        break;
                     case 1:
                        _loc7_.x = Math.max(UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.width - _loc7_.width,0) / 2;
                        break;
                     case 2:
                        _loc7_.x = Math.max(UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.width - _loc7_.width - _sidePadding,0);
                  }
                  if(_loc8_ < 3)
                  {
                     _loc7_.y = topPadding - _loc7_.height / 2;
                  }
                  else
                  {
                     _loc7_.y = UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.height - (bottomPadding + _loc7_.height / 2);
                  }
                  _loc7_.visible = true;
                  UnknownVarFromIlluminaBorderWidget_BitmapData_1.fillRect(new Rectangle(_loc7_.x - _childMargin,_loc7_.y,_loc7_.width + _childMargin * 2,_loc7_.height),0);
               }
            }
            else
            {
               _loc7_.visible = false;
            }
         }
         UnknownVarFromIlluminaBorderWidget_BitmapData_1.unlock();
         UnknownVarFromIlluminaBorderWidget_IBitmapWrapperController_1.invalidate();
      }
   }
}


package com.sulake.habbo.avatar.common
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarFigureContainer;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.avatar.structure.figure.IFigurePart;
   import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class AvatarEditorGridPartItem implements UnknownIHabboAvatar1
   {
      private static var _downloadIcon:BitmapData;
      
      private static var DRAW_ORDER:Array = [];
      
      DRAW_ORDER.push("li");
      DRAW_ORDER.push("lh");
      DRAW_ORDER.push("ls");
      DRAW_ORDER.push("lc");
      DRAW_ORDER.push("mcl");
      DRAW_ORDER.push("ptl");
      DRAW_ORDER.push("bd");
      DRAW_ORDER.push("sh");
      DRAW_ORDER.push("lg");
      DRAW_ORDER.push("ch");
      DRAW_ORDER.push("ca");
      DRAW_ORDER.push("cc");
      DRAW_ORDER.push("cp");
      DRAW_ORDER.push("mc");
      DRAW_ORDER.push("pt");
      DRAW_ORDER.push("wa");
      DRAW_ORDER.push("rh");
      DRAW_ORDER.push("rs");
      DRAW_ORDER.push("rc");
      DRAW_ORDER.push("mcr");
      DRAW_ORDER.push("ptr");
      DRAW_ORDER.push("hd");
      DRAW_ORDER.push("fc");
      DRAW_ORDER.push("ey");
      DRAW_ORDER.push("hr");
      DRAW_ORDER.push("hrb");
      DRAW_ORDER.push("fa");
      DRAW_ORDER.push("ea");
      DRAW_ORDER.push("ha");
      DRAW_ORDER.push("he");
      DRAW_ORDER.push("ri");
      
      private var UnknownVarFromAvatarEditorGridPartItem_ICategoryBaseModel_1_1:ICategoryBaseModel_1;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromAvatarEditorGridPartItem_IWindowModel_1:IWindowModel;
      
      private var _partSet:IFigurePartSet;
      
      private var _colors:Array;
      
      private var _useColors:Boolean;
      
      private var _isSelected:Boolean = false;
      
      private var UnknownVarFromAvatarEditorGridPartItem_BitmapData_1:BitmapData;
      
      private var UnknownVarFromAvatarEditorGridPartItem_Rectangle_1:Rectangle;
      
      private var _colorLayerCount:int = 0;
      
      private var UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1:IAvatarRenderManager;
      
      private var _disposed:Boolean;
      
      private var _isDisabledForWearing:Boolean;
      
      private const THUMB_DIRECTIONS:Array;
      
      public function AvatarEditorGridPartItem(param1:IWindowController_1, param2:ICategoryBaseModel_1, param3:IFigurePartSet, param4:Array, param5:Boolean = true, param6:Boolean = false)
      {
         var _loc7_:* = null;
         var _loc8_:Array = null;
         THUMB_DIRECTIONS = [2,6,0,4,3,1];
         super();
         UnknownVarFromAvatarEditorGridPartItem_ICategoryBaseModel_1_1 = param2;
         _partSet = param3;
         _window = param1;
         UnknownVarFromAvatarEditorGridPartItem_IWindowModel_1 = _window.findChildByTag("BG_COLOR");
         _colors = param4;
         _useColors = param5;
         _isDisabledForWearing = param6;
         if(param3 == null)
         {
            UnknownVarFromAvatarEditorGridPartItem_BitmapData_1 = new BitmapData(1,1,true,16777215);
         }
         if(param3 != null)
         {
            _loc8_ = param3.parts;
            for each(_loc7_ in _loc8_)
            {
               _colorLayerCount = Math.max(_colorLayerCount,_loc7_.colorLayerIndex);
            }
         }
         UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1 = UnknownVarFromAvatarEditorGridPartItem_ICategoryBaseModel_1_1.controller.manager.avatarRenderManager;
         _window.addEventListener("WME_OVER",onMouseOver);
         _window.addEventListener("WME_OUT",onMousetOut);
         updateThumbVisualization();
      }
      
      private function onMousetOut(param1:WindowMouseEvent) : void
      {
         if(!_isSelected)
         {
            UnknownVarFromAvatarEditorGridPartItem_IWindowModel_1.visible = false;
         }
         UnknownVarFromAvatarEditorGridPartItem_IWindowModel_1.blend = 1;
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         if(!_isSelected)
         {
            UnknownVarFromAvatarEditorGridPartItem_IWindowModel_1.visible = true;
            UnknownVarFromAvatarEditorGridPartItem_IWindowModel_1.blend = 0.5;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromAvatarEditorGridPartItem_ICategoryBaseModel_1_1 = null;
         _partSet = null;
         if(_window != null)
         {
            if(!_window.disposed)
            {
               _window.dispose();
            }
         }
         _window = null;
         if(UnknownVarFromAvatarEditorGridPartItem_BitmapData_1)
         {
            UnknownVarFromAvatarEditorGridPartItem_BitmapData_1.dispose();
         }
         UnknownVarFromAvatarEditorGridPartItem_BitmapData_1 = null;
         _disposed = true;
         _downloadIcon = null;
         UnknownVarFromAvatarEditorGridPartItem_IWindowModel_1 = null;
         UnknownVarFromAvatarEditorGridPartItem_Rectangle_1 = null;
         UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1 = null;
         _disposed = true;
         _colors = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get view() : IWindowController_1
      {
         return _window;
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
         updateThumbVisualization();
      }
      
      public function get id() : int
      {
         if(_partSet == null)
         {
            return -1;
         }
         return _partSet.id;
      }
      
      public function get colorLayerCount() : int
      {
         return _colorLayerCount;
      }
      
      public function update() : void
      {
         updateThumbVisualization();
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         UnknownVarFromAvatarEditorGridPartItem_BitmapData_1 = param1;
         updateThumbVisualization();
      }
      
      public function get partSet() : IFigurePartSet
      {
         return _partSet;
      }
      
      public function set colors(param1:Array) : void
      {
         _colors = param1;
         updateThumbVisualization();
      }
      
      private function updateThumbVisualization() : void
      {
         var _loc1_:BitmapData = null;
         var _loc3_:BitmapData = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc5_:IBitmapWrapperController = _window.findChildByName("bitmap") as IBitmapWrapperController;
         if(_loc5_)
         {
            if(UnknownVarFromAvatarEditorGridPartItem_BitmapData_1 != null && !_useColors)
            {
               _loc1_ = UnknownVarFromAvatarEditorGridPartItem_BitmapData_1;
            }
            else
            {
               _loc1_ = renderThumb();
               if(!_loc1_)
               {
                  return;
               }
            }
            _loc3_ = !!_loc5_.bitmap ? _loc5_.bitmap : new BitmapData(_loc5_.width,_loc5_.height);
            _loc3_.fillRect(_loc3_.rect,16777215);
            _loc4_ = (_loc3_.width - _loc1_.width) / 2;
            _loc6_ = (_loc3_.height - _loc1_.height) / 2;
            _loc3_.copyPixels(_loc1_,_loc1_.rect,new Point(_loc4_,_loc6_),null,null,true);
            _loc5_.bitmap = _loc3_;
         }
         var _loc7_:IWindowModel = _window.findChildByTag("CLUB_ICON");
         var _loc2_:IStaticBitmapWrapperWindow = _window.findChildByTag("SELLABLE_ICON") as IStaticBitmapWrapperWindow;
         if(_partSet)
         {
            _loc7_.visible = _partSet.clubLevel > 0;
            _loc2_.visible = _partSet.isSellable;
         }
         else
         {
            _loc7_.visible = false;
            _loc2_.visible = false;
         }
         if(_isDisabledForWearing)
         {
            setAlpha(_loc3_,0.2);
         }
         if(UnknownVarFromAvatarEditorGridPartItem_IWindowModel_1 == null)
         {
            return;
         }
         UnknownVarFromAvatarEditorGridPartItem_IWindowModel_1.visible = _isSelected;
         UnknownVarFromAvatarEditorGridPartItem_IWindowModel_1.blend = 1;
         _window.invalidate();
      }
      
      private function analyzePartLayers() : Boolean
      {
         var _loc4_:* = null;
         var _loc6_:String = null;
         var _loc7_:BitmapDataAsset = null;
         var _loc3_:BitmapData = null;
         if(UnknownVarFromAvatarEditorGridPartItem_ICategoryBaseModel_1_1 == null)
         {
            UnknownVarFromAvatarEditorGridPartItem_Rectangle_1 = null;
            return false;
         }
         if(!partSet || !partSet.parts || partSet.parts.length == 0)
         {
            UnknownVarFromAvatarEditorGridPartItem_Rectangle_1 = null;
            return false;
         }
         if(!UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1)
         {
            return false;
         }
         var _loc2_:IAvatarFigureContainer = UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1.createFigureContainer(partSet.type + "-" + partSet.id);
         if(!UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1.isFigureReady(_loc2_))
         {
            UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1.downloadFigure(_loc2_,this);
            return false;
         }
         var _loc8_:int = 0;
         var _loc5_:Boolean = false;
         var _loc1_:Rectangle = new Rectangle();
         for each(_loc4_ in partSet.parts)
         {
            if(_loc5_)
            {
               _loc6_ = "h_std_" + _loc4_.type + "_" + _loc4_.id + "_" + THUMB_DIRECTIONS[_loc8_] + "_" + "0";
               _loc7_ = UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1.getAssetByName(_loc6_) as BitmapDataAsset;
            }
            else
            {
               _loc8_ = 0;
               while(!_loc5_ && _loc8_ < THUMB_DIRECTIONS.length)
               {
                  _loc6_ = "h_std_" + _loc4_.type + "_" + _loc4_.id + "_" + THUMB_DIRECTIONS[_loc8_] + "_" + "0";
                  _loc7_ = UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1.getAssetByName(_loc6_) as BitmapDataAsset;
                  if(_loc7_ && _loc7_.content)
                  {
                     _loc5_ = true;
                  }
                  else
                  {
                     _loc8_++;
                  }
               }
            }
            if(_loc7_ && _loc7_.content)
            {
               _loc3_ = _loc7_.content as BitmapData;
               _loc1_ = _loc1_.union(new Rectangle(-1 * _loc7_.offset.x,-1 * _loc7_.offset.y,_loc7_.rectangle.width,_loc7_.rectangle.height));
            }
         }
         if(_loc1_ && _loc1_.width > 0)
         {
            UnknownVarFromAvatarEditorGridPartItem_Rectangle_1 = _loc1_;
            return true;
         }
         return false;
      }
      
      private function renderThumb() : BitmapData
      {
         var _loc11_:ISoundAsset = null;
         var _loc4_:BitmapData = null;
         var _loc3_:* = null;
         var _loc10_:String = null;
         var _loc12_:BitmapDataAsset = null;
         var _loc1_:BitmapData = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:ColorTransform = null;
         var _loc2_:IPartColor = null;
         var _loc6_:Rectangle = null;
         if(partSet == null)
         {
            return null;
         }
         if(UnknownVarFromAvatarEditorGridPartItem_ICategoryBaseModel_1_1 == null)
         {
            return null;
         }
         if(UnknownVarFromAvatarEditorGridPartItem_Rectangle_1 == null)
         {
            if(!analyzePartLayers())
            {
               if(!_downloadIcon)
               {
                  _loc11_ = UnknownVarFromAvatarEditorGridPartItem_ICategoryBaseModel_1_1.controller.manager.windowManager.assets.getAssetByName("avatar_editor_avatar_editor_download_icon");
                  _downloadIcon = _loc11_.content as BitmapData;
               }
               return _downloadIcon;
            }
         }
         if(!UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1)
         {
            return null;
         }
         _loc4_ = new BitmapData(UnknownVarFromAvatarEditorGridPartItem_Rectangle_1.width,UnknownVarFromAvatarEditorGridPartItem_Rectangle_1.height,true,16777215);
         var _loc5_:int = 0;
         var _loc9_:Boolean = false;
         var _loc14_:Array = partSet.parts.concat().sort(sortByDrawOrder);
         for each(_loc3_ in _loc14_)
         {
            _loc12_ = null;
            if(_loc9_)
            {
               _loc10_ = "h_std_" + _loc3_.type + "_" + _loc3_.id + "_" + THUMB_DIRECTIONS[_loc5_] + "_" + "0";
               _loc12_ = UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1.getAssetByName(_loc10_) as BitmapDataAsset;
            }
            else
            {
               _loc5_ = 0;
               while(!_loc9_ && _loc5_ < THUMB_DIRECTIONS.length)
               {
                  _loc10_ = "h_std_" + _loc3_.type + "_" + _loc3_.id + "_" + THUMB_DIRECTIONS[_loc5_] + "_" + "0";
                  _loc12_ = UnknownVarFromAvatarEditorGridPartItem_IAvatarRenderManager_1.getAssetByName(_loc10_) as BitmapDataAsset;
                  if(_loc12_ && _loc12_.content)
                  {
                     _loc9_ = true;
                  }
                  else
                  {
                     _loc5_++;
                  }
               }
            }
            if(_loc12_)
            {
               _loc1_ = BitmapData(_loc12_.content);
               _loc7_ = -1 * _loc12_.offset.x - UnknownVarFromAvatarEditorGridPartItem_Rectangle_1.x;
               _loc8_ = -1 * _loc12_.offset.y - UnknownVarFromAvatarEditorGridPartItem_Rectangle_1.y;
               _loc13_ = null;
               if(_useColors && _loc3_.colorLayerIndex > 0)
               {
                  _loc2_ = _colors[_loc3_.colorLayerIndex - 1];
                  if(_loc2_ != null)
                  {
                     _loc13_ = _loc2_.colorTransform;
                  }
               }
               if(_loc13_)
               {
                  _loc6_ = new Rectangle(_loc7_,_loc8_,_loc12_.rectangle.width,_loc12_.rectangle.height);
                  _loc4_.draw(_loc12_.content as BitmapData,new Matrix(1,0,0,1,-_loc12_.rectangle.x + _loc7_,-_loc12_.rectangle.y + _loc8_),_loc13_,null,_loc6_);
               }
               else
               {
                  _loc4_.copyPixels(_loc1_,_loc12_.rectangle,new Point(_loc7_,_loc8_),null,null,true);
               }
            }
         }
         return _loc4_;
      }
      
      private function setAlpha(param1:BitmapData, param2:Number) : BitmapData
      {
         var _loc3_:Rectangle = new Rectangle(0,0,param1.width,param1.height);
         var _loc4_:ColorTransform = new ColorTransform();
         _loc4_.alphaMultiplier = param2;
         param1.colorTransform(_loc3_,_loc4_);
         return param1;
      }
      
      private function sortByDrawOrder(param1:IFigurePart, param2:IFigurePart) : Number
      {
         var _loc3_:Number = Number(DRAW_ORDER.indexOf(param1.type));
         var _loc4_:Number = Number(DRAW_ORDER.indexOf(param2.type));
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.index < param2.index)
         {
            return -1;
         }
         if(param1.index > param2.index)
         {
            return 1;
         }
         return 0;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(!analyzePartLayers())
         {
            return;
         }
         updateThumbVisualization();
      }
      
      public function get isDisabledForWearing() : Boolean
      {
         return _isDisabledForWearing;
      }
   }
}


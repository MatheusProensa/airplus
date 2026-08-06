package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.actions.ActionDefinition;
   import com.sulake.habbo.avatar.actions.ActiveActionData;
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   import com.sulake.habbo.avatar.actions.IActiveActionData;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.animation.Animation;
   import com.sulake.habbo.avatar.animation.IAnimationLayerData;
   import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.cache.AvatarImageCache;
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.utils.BitmapHelper;
   import flash.display.BitmapData;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class AvatarImage implements IAvatarImage_2, IComponentInterfaceQueue, IAvatarImage_1
   {
      private static const CHANNELS_EQUAL:String = "CHANNELS_EQUAL";
      
      private static const CHANNELS_UNIQUE:String = "CHANNELS_UNIQUE";
      
      private static const CHANNELS_RED:String = "CHANNELS_RED";
      
      private static const CHANNELS_GREEN:String = "CHANNELS_GREEN";
      
      private static const CHANNELS_BLUE:String = "CHANNELS_BLUE";
      
      private static const CHANNELS_SATURATED:String = "CHANNELS_SATURATED";
      
      private static const DEFAULT_ACTION:String = "Default";
      
      private static const DEFAULT_DIR:int = 2;
      
      private static const DEFAULT_AVATAR_SET:String = "full";
      
      private static const MAX_IDLE_FRAMES:* = 8;
      
      private static const MAX_OTHER_FRAMES:* = 4;
      
      private static const DEFAULT_POINT:Point = new Point(0,0);
      
      protected var UnknownVarFromAvatarImage_AvatarStructure_1:AvatarStructure;
      
      protected var _scale:String;
      
      protected var _direction:int;
      
      protected var _headDirection:int;
      
      protected var UnknownVarFromAvatarImage_IActiveActionData_1:IActiveActionData;
      
      protected var _disposed:Boolean;
      
      protected var _canvasOffsets:Array = [];
      
      protected var _assets:AssetAliasCollection;
      
      protected var _cache:AvatarImageCache;
      
      protected var _figure:AvatarFigureContainer;
      
      protected var _avatarSpriteData:IAvatarDataContainer;
      
      protected var UnknownVarFromAvatarImage_Array_1:Array = [];
      
      protected var UnknownVarFromAvatarImage_BitmapData_1:BitmapData;
      
      private var _defaultAction:IActiveActionData;
      
      private var UnknownVarFromAvatarImage_IActiveActionData_2:IActiveActionData;
      
      private var UnknownVarFromAvatarImage_Int_1:int = 0;
      
      private var UnknownVarFromAvatarImage_Int_2:int = 0;
      
      private var _changes:Boolean;
      
      private var _sprites:Vector.<ISpriteDataContainer>;
      
      private var UnknownVarFromAvatarImage_Boolean_1:Boolean;
      
      private var _animationHasResetOnToggle:Boolean = false;
      
      private var UnknownVarFromAvatarImage_Boolean_2:Boolean = false;
      
      private var UnknownVarFromAvatarImage_Array_2:Array;
      
      private var _lastActionsStr:String;
      
      private var _currentActionsStr:String;
      
      private var _fullImageCache:Map;
      
      protected var UnknownVarFromAvatarImage_Boolean_3:Boolean = false;
      
      private var _useFullImageCache:Boolean;
      
      private var UnknownVarFromAvatarImage_Int_3:int = -1;
      
      private var UnknownVarFromAvatarImage_Int_4:int;
      
      private var UnknownVarFromAvatarImage_Array_3:Array = [];
      
      private var UnknownVarFromAvatarImage_Int_5:int = -1;
      
      private var UnknownVarFromAvatarImage_String_1:String = null;
      
      private var UnknownVarFromAvatarImage_String_2:String = null;
      
      private var UnknownVarFromAvatarImage_EffectAssetDownloadManager_1:EffectAssetDownloadManager;
      
      private var UnknownVarFromAvatarImage_IAvatarImage_1_1:IAvatarImage_1;
      
      public function AvatarImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:AvatarFigureContainer, param4:String, param5:EffectAssetDownloadManager, param6:IAvatarImage_1)
      {
         super();
         _changes = true;
         UnknownVarFromAvatarImage_EffectAssetDownloadManager_1 = param5;
         UnknownVarFromAvatarImage_AvatarStructure_1 = param1;
         _assets = param2;
         _scale = param4;
         UnknownVarFromAvatarImage_IAvatarImage_1_1 = param6;
         var _loc7_:Boolean = false;
         if(_scale == null)
         {
            _scale = "h";
         }
         else if(_scale == "h_50")
         {
            _loc7_ = true;
            _scale = "sh";
         }
         if(param3 == null)
         {
            param3 = new AvatarFigureContainer("hr-893-45.hd-180-2.ch-210-66.lg-270-82.sh-300-91.wa-2007-.ri-1-");
            Logger.log("Using default avatar figure");
         }
         _figure = param3;
         _cache = new AvatarImageCache(UnknownVarFromAvatarImage_AvatarStructure_1,this,_assets,_scale,_loc7_);
         setDirection("full",2);
         UnknownVarFromAvatarImage_Array_1 = [];
         _defaultAction = new ActiveActionData("std");
         _defaultAction.definition = UnknownVarFromAvatarImage_AvatarStructure_1.getDefaultActionDefinition();
         UnknownVarFromAvatarImage_IActiveActionData_2 = new ActiveActionData("lay");
         UnknownVarFromAvatarImage_IActiveActionData_2.definition = UnknownVarFromAvatarImage_AvatarStructure_1.getDefaultLayActionDefinition();
         resetActions();
         _fullImageCache = new Map();
      }
      
      public function getServerRenderData() : Array
      {
         getAvatarPartsForCamera("full");
         return _cache.getServerRenderData();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            UnknownVarFromAvatarImage_AvatarStructure_1 = null;
            _assets = null;
            UnknownVarFromAvatarImage_IActiveActionData_1 = null;
            _figure = null;
            _avatarSpriteData = null;
            UnknownVarFromAvatarImage_Array_1 = null;
            if(UnknownVarFromAvatarImage_BitmapData_1)
            {
               UnknownVarFromAvatarImage_BitmapData_1.dispose();
            }
            if(_cache)
            {
               _cache.dispose();
               _cache = null;
            }
            if(_fullImageCache)
            {
               for each(var _loc1_ in _fullImageCache)
               {
                  _loc1_.dispose();
               }
               _fullImageCache.dispose();
               _fullImageCache = null;
            }
            UnknownVarFromAvatarImage_BitmapData_1 = null;
            _canvasOffsets = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function getFigure() : IAvatarFigureContainer
      {
         return _figure;
      }
      
      public function getScale() : String
      {
         return _scale;
      }
      
      public function getPartColor(param1:String) : IPartColor
      {
         return UnknownVarFromAvatarImage_AvatarStructure_1.getPartColor(_figure,param1);
      }
      
      public function setDirection(param1:String, param2:int) : void
      {
         param2 += UnknownVarFromAvatarImage_Int_2;
         if(param2 < 0)
         {
            param2 = 7 + (param2 + 1);
         }
         if(param2 > 7)
         {
            param2 -= 7 + 1;
         }
         if(UnknownVarFromAvatarImage_AvatarStructure_1.isMainAvatarSet(param1))
         {
            _direction = param2;
         }
         if(param1 == "head" || param1 == "full")
         {
            if(param1 == "head" && isHeadTurnPreventedByAction())
            {
               param2 = _direction;
            }
            _headDirection = param2;
         }
         _cache.setDirection(param1,param2);
         _changes = true;
      }
      
      public function setDirectionAngle(param1:String, param2:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = param2 / 45;
         setDirection(param1,_loc3_);
      }
      
      public function getSprites() : Vector.<ISpriteDataContainer>
      {
         return _sprites;
      }
      
      public function getCanvasOffsets() : Array
      {
         return _canvasOffsets;
      }
      
      public function getLayerData(param1:ISpriteDataContainer) : IAnimationLayerData
      {
         return UnknownVarFromAvatarImage_AvatarStructure_1.getBodyPartData(param1.animation.id,UnknownVarFromAvatarImage_Int_1,param1.id);
      }
      
      public function updateAnimationByFrames(param1:int = 1) : void
      {
         UnknownVarFromAvatarImage_Int_1 += param1;
         _changes = true;
      }
      
      public function resetAnimationFrameCounter() : void
      {
         UnknownVarFromAvatarImage_Int_1 = 0;
         _changes = true;
      }
      
      private function getFullImageCacheKey() : String
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         if(!_useFullImageCache)
         {
            return null;
         }
         if(UnknownVarFromAvatarImage_Array_2.length == 1 && _direction == _headDirection)
         {
            if(_currentActionsStr == "std" || _currentActionsStr == "lay" || _currentActionsStr == "sit")
            {
               _loc2_ = UnknownVarFromAvatarImage_Int_1 % 8;
            }
            else
            {
               _loc2_ = UnknownVarFromAvatarImage_Int_1 % 4;
            }
            return _direction + _currentActionsStr + _loc2_;
         }
         if(UnknownVarFromAvatarImage_Array_2.length == 2)
         {
            for each(_loc1_ in UnknownVarFromAvatarImage_Array_2)
            {
               if(_loc1_.actionType == "fx" && (_loc1_.actionParameter == "33" || _loc1_.actionParameter == "34" || _loc1_.actionParameter == "35" || _loc1_.actionParameter == "36"))
               {
                  return _direction + _currentActionsStr + 0;
               }
               if(_loc1_.actionType == "fx" && (_loc1_.actionParameter == "38" || _loc1_.actionParameter == "39"))
               {
                  _loc3_ = UnknownVarFromAvatarImage_Int_1 % 11;
                  return _direction + "_" + _headDirection + _currentActionsStr + _loc3_;
               }
            }
         }
         return null;
      }
      
      private function getBodyParts(param1:String, param2:String, param3:int) : Array
      {
         if(param3 != UnknownVarFromAvatarImage_Int_5 || param2 != UnknownVarFromAvatarImage_String_1 || param1 != UnknownVarFromAvatarImage_String_2)
         {
            UnknownVarFromAvatarImage_Int_5 = param3;
            UnknownVarFromAvatarImage_String_1 = param2;
            UnknownVarFromAvatarImage_String_2 = param1;
            UnknownVarFromAvatarImage_Array_3 = UnknownVarFromAvatarImage_AvatarStructure_1.getBodyParts(param1,param2,param3);
         }
         return UnknownVarFromAvatarImage_Array_3;
      }
      
      public function getAvatarPartsForCamera(param1:String) : void
      {
         var _loc4_:String = null;
         var _loc2_:AvatarImageBodyPartContainer = null;
         var _loc6_:int = 0;
         if(UnknownVarFromAvatarImage_IActiveActionData_1 == null)
         {
            return;
         }
         var _loc5_:AvatarCanvas = UnknownVarFromAvatarImage_AvatarStructure_1.getCanvas(_scale,UnknownVarFromAvatarImage_IActiveActionData_1.definition.geometryType);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc3_:Array = getBodyParts(param1,UnknownVarFromAvatarImage_IActiveActionData_1.definition.geometryType,_direction);
         _loc6_ = _loc3_.length - 1;
         while(_loc6_ >= 0)
         {
            _loc4_ = _loc3_[_loc6_];
            _loc2_ = _cache.getImageContainer(_loc4_,UnknownVarFromAvatarImage_Int_1,true);
            _loc6_--;
         }
      }
      
      public function getImage(param1:String, param2:Boolean, param3:Number = 1) : BitmapData
      {
         var _loc12_:String = null;
         var _loc4_:AvatarImageBodyPartContainer = null;
         var _loc10_:BitmapData = null;
         var _loc8_:Point = null;
         var _loc11_:int = 0;
         var _loc7_:BitmapData = null;
         if(!_changes)
         {
            return UnknownVarFromAvatarImage_BitmapData_1;
         }
         if(UnknownVarFromAvatarImage_IActiveActionData_1 == null)
         {
            return null;
         }
         if(!UnknownVarFromAvatarImage_Boolean_2)
         {
            endActionAppends();
         }
         var _loc9_:String = getFullImageCacheKey();
         if(_loc9_ != null)
         {
            if(getFullImage(_loc9_))
            {
               _changes = false;
               if(param2)
               {
                  return (getFullImage(_loc9_) as BitmapData).clone();
               }
               UnknownVarFromAvatarImage_BitmapData_1 = getFullImage(_loc9_) as BitmapData;
               UnknownVarFromAvatarImage_Boolean_3 = true;
               return UnknownVarFromAvatarImage_BitmapData_1;
            }
         }
         var _loc6_:AvatarCanvas = UnknownVarFromAvatarImage_AvatarStructure_1.getCanvas(_scale,UnknownVarFromAvatarImage_IActiveActionData_1.definition.geometryType);
         if(_loc6_ == null)
         {
            return null;
         }
         if(UnknownVarFromAvatarImage_Boolean_3 || UnknownVarFromAvatarImage_BitmapData_1 == null || (UnknownVarFromAvatarImage_BitmapData_1.width != _loc6_.width || UnknownVarFromAvatarImage_BitmapData_1.height != _loc6_.height))
         {
            if(UnknownVarFromAvatarImage_BitmapData_1 != null && !UnknownVarFromAvatarImage_Boolean_3)
            {
               UnknownVarFromAvatarImage_BitmapData_1.dispose();
            }
            UnknownVarFromAvatarImage_BitmapData_1 = new BitmapData(_loc6_.width,_loc6_.height,true,0);
            UnknownVarFromAvatarImage_Boolean_3 = false;
         }
         var _loc5_:Array = getBodyParts(param1,UnknownVarFromAvatarImage_IActiveActionData_1.definition.geometryType,_direction);
         UnknownVarFromAvatarImage_BitmapData_1.lock();
         UnknownVarFromAvatarImage_BitmapData_1.fillRect(UnknownVarFromAvatarImage_BitmapData_1.rect,0);
         var _loc13_:Boolean = true;
         _loc11_ = _loc5_.length - 1;
         while(_loc11_ >= 0)
         {
            _loc12_ = _loc5_[_loc11_];
            _loc4_ = _cache.getImageContainer(_loc12_,UnknownVarFromAvatarImage_Int_1);
            if(_loc4_)
            {
               _loc13_ &&= _loc4_.isCacheable;
               _loc10_ = _loc4_.image;
               _loc8_ = _loc4_.regPoint.add(_loc6_.offset);
               if(_loc10_ && _loc8_)
               {
                  _loc8_ = _loc8_.add(_loc6_.regPoint);
                  UnknownVarFromAvatarImage_BitmapData_1.copyPixels(_loc10_,_loc10_.rect,_loc8_,null,null,true);
               }
            }
            _loc11_--;
         }
         UnknownVarFromAvatarImage_BitmapData_1.unlock();
         _changes = false;
         if(_avatarSpriteData != null)
         {
            if(_avatarSpriteData.paletteIsGrayscale)
            {
               _loc7_ = convertToGrayscale(UnknownVarFromAvatarImage_BitmapData_1);
               if(UnknownVarFromAvatarImage_BitmapData_1)
               {
                  UnknownVarFromAvatarImage_BitmapData_1.dispose();
               }
               UnknownVarFromAvatarImage_BitmapData_1 = _loc7_;
               UnknownVarFromAvatarImage_BitmapData_1.paletteMap(UnknownVarFromAvatarImage_BitmapData_1,UnknownVarFromAvatarImage_BitmapData_1.rect,DEFAULT_POINT,_avatarSpriteData.reds,[],[]);
            }
            else
            {
               UnknownVarFromAvatarImage_BitmapData_1.copyChannel(UnknownVarFromAvatarImage_BitmapData_1,UnknownVarFromAvatarImage_BitmapData_1.rect,DEFAULT_POINT,2,8);
            }
         }
         if(_loc9_ != null && _loc13_)
         {
            cacheFullImage(_loc9_,UnknownVarFromAvatarImage_BitmapData_1.clone());
         }
         if(param3 != 1)
         {
            UnknownVarFromAvatarImage_BitmapData_1 = BitmapHelper.resampleBitmapData(UnknownVarFromAvatarImage_BitmapData_1,param3);
         }
         if(UnknownVarFromAvatarImage_BitmapData_1 && param2)
         {
            return UnknownVarFromAvatarImage_BitmapData_1.clone();
         }
         return UnknownVarFromAvatarImage_BitmapData_1;
      }
      
      public function getHeadRegPoints(param1:String) : Point
      {
         var _loc2_:AvatarImageBodyPartContainer = _cache.getImageContainer("head",UnknownVarFromAvatarImage_Int_1);
         if(_loc2_ == null)
         {
            return new Point(0,0);
         }
         return new Point(_loc2_.regPoint.x,_loc2_.regPoint.y);
      }
      
      public function getFaceOffset(param1:String) : Point
      {
         var _loc2_:AvatarImageBodyPartContainer = _cache.getImageContainer("head",UnknownVarFromAvatarImage_Int_1);
         if(_loc2_ == null || _loc2_.faceOffset == null)
         {
            return new Point(0,0);
         }
         return new Point(_loc2_.faceOffset.x,_loc2_.faceOffset.y);
      }
      
      public function getCroppedImage(param1:String, param2:Number = 1) : BitmapData
      {
         var _loc11_:String = null;
         var _loc3_:AvatarImageBodyPartContainer = null;
         var _loc8_:BitmapData = null;
         var _loc7_:Point = null;
         var _loc9_:int = 0;
         if(UnknownVarFromAvatarImage_IActiveActionData_1 == null)
         {
            return null;
         }
         if(!UnknownVarFromAvatarImage_Boolean_2)
         {
            endActionAppends();
         }
         var _loc6_:AvatarCanvas = UnknownVarFromAvatarImage_AvatarStructure_1.getCanvas(_scale,UnknownVarFromAvatarImage_IActiveActionData_1.definition.geometryType);
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc4_:BitmapData = new BitmapData(_loc6_.width,_loc6_.height,true,16777215);
         var _loc5_:Array = UnknownVarFromAvatarImage_AvatarStructure_1.getBodyParts(param1,UnknownVarFromAvatarImage_IActiveActionData_1.definition.geometryType,_direction);
         var _loc10_:Rectangle = null;
         var _loc13_:Rectangle = new Rectangle();
         _loc9_ = _loc5_.length - 1;
         while(_loc9_ >= 0)
         {
            _loc11_ = _loc5_[_loc9_];
            _loc3_ = _cache.getImageContainer(_loc11_,UnknownVarFromAvatarImage_Int_1);
            if(_loc3_ != null)
            {
               _loc8_ = _loc3_.image;
               if(_loc8_ == null)
               {
                  _loc4_.dispose();
                  return null;
               }
               _loc7_ = _loc3_.regPoint;
               _loc4_.copyPixels(_loc8_,_loc8_.rect,_loc7_,null,null,true);
               _loc13_.x = _loc7_.x;
               _loc13_.y = _loc7_.y;
               _loc13_.width = _loc8_.width;
               _loc13_.height = _loc8_.height;
               if(_loc10_ == null)
               {
                  _loc10_ = _loc13_.clone();
               }
               else
               {
                  _loc10_ = _loc10_.union(_loc13_);
               }
            }
            _loc9_--;
         }
         if(_loc10_ == null)
         {
            _loc10_ = new Rectangle(0,0,1,1);
         }
         var _loc12_:BitmapData = new BitmapData(_loc10_.width,_loc10_.height,true,16777215);
         _loc12_.copyPixels(_loc4_,_loc10_,DEFAULT_POINT,null,null,true);
         _loc4_.dispose();
         if(param2 != 1)
         {
            _loc12_ = BitmapHelper.resampleBitmapData(_loc12_,param2);
         }
         return _loc12_;
      }
      
      protected function getFullImage(param1:String) : BitmapData
      {
         return _fullImageCache[param1];
      }
      
      protected function cacheFullImage(param1:String, param2:BitmapData) : void
      {
         if(_fullImageCache.getValue(param1))
         {
            (_fullImageCache.getValue(param1) as BitmapData).dispose();
            _fullImageCache.remove(param1);
         }
         _fullImageCache[param1] = param2;
      }
      
      public function getAsset(param1:String) : BitmapDataAsset
      {
         return _assets.getAssetByName(param1) as BitmapDataAsset;
      }
      
      public function getDirection() : int
      {
         return _direction;
      }
      
      public function initActionAppends() : void
      {
         UnknownVarFromAvatarImage_Array_1 = [];
         UnknownVarFromAvatarImage_Boolean_2 = false;
         _currentActionsStr = "";
         _useFullImageCache = false;
      }
      
      public function endActionAppends() : void
      {
         var _loc1_:* = null;
         if(sortActions())
         {
            for each(_loc1_ in UnknownVarFromAvatarImage_Array_2)
            {
               if(_loc1_.actionType == "fx")
               {
                  if(!UnknownVarFromAvatarImage_EffectAssetDownloadManager_1.isReady(parseInt(_loc1_.actionParameter)))
                  {
                     UnknownVarFromAvatarImage_EffectAssetDownloadManager_1.loadEffectData(parseInt(_loc1_.actionParameter),this);
                  }
               }
            }
            resetActions();
            setActionsToParts();
         }
      }
      
      public function appendAction(param1:String, ... rest) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:ActionDefinition = null;
         UnknownVarFromAvatarImage_Boolean_2 = false;
         if(rest != null && rest.length > 0)
         {
            _loc3_ = rest[0];
         }
         switch(param1)
         {
            case "posture":
               switch(_loc3_)
               {
                  case "lay":
                     if(_direction == 0)
                     {
                        setDirection("full",4);
                     }
                     else
                     {
                        setDirection("full",2);
                     }
                  case "mv":
                  case "std":
                  case "sit":
                     _useFullImageCache = true;
                     addActionData(_loc3_);
                     break;
                  case "swim":
                  case "float":
                  case "swrun":
                  case "swdiefront":
                  case "swdieback":
                  case "swpick":
                  case "swthrow":
                     _useFullImageCache = false;
                     addActionData(_loc3_);
                     break;
                  default:
                     errorThis("appendAction() >> UNKNOWN POSTURE TYPE: " + _loc3_);
               }
               break;
            case "gest":
               switch(_loc3_)
               {
                  case "agr":
                  case "sad":
                  case "sml":
                  case "srp":
                     addActionData(_loc3_);
                     break;
                  default:
                     errorThis("appendAction() >> UNKNOWN GESTURE TYPE: " + _loc3_);
               }
               break;
            case "fx":
               if(_loc3_ == "33" || _loc3_ == "34" || _loc3_ == "35" || _loc3_ == "36" || _loc3_ == "38" || _loc3_ == "39")
               {
                  _useFullImageCache = true;
               }
            case "dance":
            case "talk":
            case "wave":
            case "Sleep":
            case "sign":
            case "respect":
            case "blow":
            case "67":
            case "laugh":
            case "cry":
            case "idle":
            case "sbollie":
            case "sb360":
            case "ridejump":
               addActionData(param1,_loc3_);
               break;
            case "cri":
            case "usei":
               _loc4_ = UnknownVarFromAvatarImage_AvatarStructure_1.getActionDefinitionWithState(param1);
               if(_loc4_ != null)
               {
                  logThis("appendAction:" + [_loc3_,"->",_loc4_.getParameterValue(_loc3_)]);
                  _loc3_ = _loc4_.getParameterValue(_loc3_);
               }
               addActionData(param1,_loc3_);
               break;
            default:
               errorThis("appendAction() >> UNKNOWN ACTION TYPE: " + param1);
         }
         return true;
      }
      
      protected function addActionData(param1:String, param2:String = "") : void
      {
         var _loc4_:ActiveActionData = null;
         var _loc3_:int = 0;
         if(UnknownVarFromAvatarImage_Array_1 == null)
         {
            UnknownVarFromAvatarImage_Array_1 = [];
         }
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromAvatarImage_Array_1.length)
         {
            _loc4_ = UnknownVarFromAvatarImage_Array_1[_loc3_];
            if(_loc4_.actionType == param1 && _loc4_.actionParameter == param2)
            {
               return;
            }
            _loc3_++;
         }
         UnknownVarFromAvatarImage_Array_1.push(new ActiveActionData(param1,param2,UnknownVarFromAvatarImage_Int_1));
      }
      
      public function isAnimating() : Boolean
      {
         return UnknownVarFromAvatarImage_Boolean_1 || UnknownVarFromAvatarImage_Int_4 > 1;
      }
      
      private function resetActions() : Boolean
      {
         _animationHasResetOnToggle = false;
         UnknownVarFromAvatarImage_Boolean_1 = false;
         _sprites = new Vector.<ISpriteDataContainer>(0);
         _avatarSpriteData = null;
         UnknownVarFromAvatarImage_Int_2 = 0;
         UnknownVarFromAvatarImage_AvatarStructure_1.removeDynamicItems(this);
         UnknownVarFromAvatarImage_IActiveActionData_1 = _defaultAction;
         UnknownVarFromAvatarImage_IActiveActionData_1.definition = _defaultAction.definition;
         resetBodyPartCache(_defaultAction);
         return true;
      }
      
      private function isHeadTurnPreventedByAction() : Boolean
      {
         var _loc2_:IActionDefinition = null;
         var _loc1_:* = null;
         if(UnknownVarFromAvatarImage_Array_2 == null)
         {
            return false;
         }
         for each(_loc1_ in UnknownVarFromAvatarImage_Array_2)
         {
            _loc2_ = UnknownVarFromAvatarImage_AvatarStructure_1.getActionDefinitionWithState(_loc1_.actionType);
            if(!(_loc1_.actionType == "Sleep" && UnknownVarFromAvatarImage_IActiveActionData_1 && UnknownVarFromAvatarImage_IActiveActionData_1.actionType != "lay"))
            {
               if(_loc2_ != null && _loc2_.getPreventHeadTurn(_loc1_.actionParameter))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function sortActions() : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc1_:Boolean = false;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         _currentActionsStr = "";
         UnknownVarFromAvatarImage_Array_2 = UnknownVarFromAvatarImage_AvatarStructure_1.sortActions(UnknownVarFromAvatarImage_Array_1);
         UnknownVarFromAvatarImage_Int_4 = UnknownVarFromAvatarImage_AvatarStructure_1.maxFrames(UnknownVarFromAvatarImage_Array_2);
         if(UnknownVarFromAvatarImage_Array_2 == null)
         {
            _canvasOffsets = new Array(0,0,0);
            if(_lastActionsStr != "")
            {
               _loc3_ = true;
               _lastActionsStr = "";
            }
         }
         else
         {
            _canvasOffsets = UnknownVarFromAvatarImage_AvatarStructure_1.getCanvasOffsets(UnknownVarFromAvatarImage_Array_2,_scale,_direction);
            for each(_loc4_ in UnknownVarFromAvatarImage_Array_2)
            {
               _currentActionsStr += _loc4_.actionType + _loc4_.actionParameter;
               if(_loc4_.actionType == "fx")
               {
                  _loc2_ = parseInt(_loc4_.actionParameter);
                  if(UnknownVarFromAvatarImage_Int_3 != _loc2_)
                  {
                     _loc5_ = true;
                  }
                  UnknownVarFromAvatarImage_Int_3 = _loc2_;
                  _loc1_ = true;
               }
            }
            if(!_loc1_)
            {
               if(UnknownVarFromAvatarImage_Int_3 > -1)
               {
                  _loc5_ = true;
               }
               UnknownVarFromAvatarImage_Int_3 = -1;
            }
            if(_loc5_)
            {
               _cache.disposeInactiveActions(0);
            }
            if(_lastActionsStr != _currentActionsStr)
            {
               _loc3_ = true;
               _lastActionsStr = _currentActionsStr;
            }
         }
         UnknownVarFromAvatarImage_Boolean_2 = true;
         return _loc3_;
      }
      
      private function setActionsToParts() : void
      {
         var _loc2_:* = null;
         var _loc6_:Animation = null;
         var _loc1_:Array = null;
         var _loc4_:* = null;
         var _loc5_:* = undefined;
         if(UnknownVarFromAvatarImage_Array_2 == null)
         {
            return;
         }
         var _loc3_:int = getTimer();
         var _loc7_:Array = [];
         for each(_loc2_ in UnknownVarFromAvatarImage_Array_2)
         {
            _loc7_.push(_loc2_.actionType);
         }
         for each(_loc2_ in UnknownVarFromAvatarImage_Array_2)
         {
            if(_loc2_ && _loc2_.definition && _loc2_.definition.isAnimation)
            {
               _loc6_ = UnknownVarFromAvatarImage_AvatarStructure_1.getAnimation(_loc2_.definition.state + "." + _loc2_.actionParameter);
               if(_loc6_ && _loc6_.hasOverriddenActions())
               {
                  _loc1_ = _loc6_.overriddenActionNames();
                  if(_loc1_)
                  {
                     for each(_loc4_ in _loc1_)
                     {
                        if(_loc7_.indexOf(_loc4_) >= 0)
                        {
                           _loc2_.overridingAction = _loc6_.overridingAction(_loc4_);
                        }
                     }
                  }
               }
               if(_loc6_ && _loc6_.resetOnToggle)
               {
                  _animationHasResetOnToggle = true;
               }
            }
         }
         for each(_loc2_ in UnknownVarFromAvatarImage_Array_2)
         {
            if(!(!_loc2_ || !_loc2_.definition))
            {
               if(_loc2_.definition.isAnimation && _loc2_.actionParameter == "")
               {
                  _loc2_.actionParameter = "1";
               }
               setActionToParts(_loc2_,_loc3_);
               if(_loc2_.definition.isAnimation)
               {
                  UnknownVarFromAvatarImage_Boolean_1 = _loc2_.definition.isAnimated(_loc2_.actionParameter);
                  _loc6_ = UnknownVarFromAvatarImage_AvatarStructure_1.getAnimation(_loc2_.definition.state + "." + _loc2_.actionParameter);
                  if(_loc6_ != null)
                  {
                     _loc5_ = _loc6_.spriteData;
                     if(_loc5_)
                     {
                        _sprites = _sprites.concat(_loc5_);
                     }
                     if(_loc6_.hasDirectionData())
                     {
                        UnknownVarFromAvatarImage_Int_2 = _loc6_.directionData.offset;
                     }
                     if(_loc6_.hasAvatarData())
                     {
                        _avatarSpriteData = _loc6_.avatarData;
                     }
                  }
               }
            }
         }
      }
      
      private function setActionToParts(param1:IActiveActionData, param2:int) : void
      {
         if(param1 == null || param1.definition == null)
         {
            return;
         }
         if(param1.definition.assetPartDefinition == "")
         {
            return;
         }
         if(param1.definition.isMain)
         {
            UnknownVarFromAvatarImage_IActiveActionData_1 = param1;
            _cache.setGeometryType(param1.definition.geometryType);
         }
         _cache.setAction(param1,param2);
         _changes = true;
      }
      
      private function resetBodyPartCache(param1:IActiveActionData) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.definition.assetPartDefinition == "")
         {
            return;
         }
         if(param1.definition.isMain)
         {
            UnknownVarFromAvatarImage_IActiveActionData_1 = param1;
            _cache.setGeometryType(param1.definition.geometryType);
         }
         _cache.resetBodyPartCache(param1);
         _changes = true;
      }
      
      public function get avatarSpriteData() : IAvatarDataContainer
      {
         return _avatarSpriteData;
      }
      
      private function convertToGrayscale(param1:BitmapData, param2:String = "CHANNELS_EQUAL") : BitmapData
      {
         var _loc5_:Number = 0.33;
         var _loc8_:Number = 0.33;
         var _loc6_:Number = 0.33;
         var _loc4_:Number = 1;
         switch(param2)
         {
            case "CHANNELS_UNIQUE":
               _loc5_ = 0.3;
               _loc8_ = 0.59;
               _loc6_ = 0.11;
               break;
            case "CHANNELS_RED":
               _loc5_ = 1;
               _loc8_ = 0;
               _loc6_ = 0;
               break;
            case "CHANNELS_GREEN":
               _loc5_ = 0;
               _loc8_ = 1;
               _loc6_ = 0;
               break;
            case "CHANNELS_BLUE":
               _loc5_ = 0;
               _loc8_ = 0;
               _loc6_ = 1;
               break;
            case "CHANNELS_DESATURATED":
               _loc5_ = 0.3086;
               _loc8_ = 0.6094;
               _loc6_ = 0.082;
         }
         var _loc7_:Array = [_loc5_,_loc8_,_loc6_,0,0,_loc5_,_loc8_,_loc6_,0,0,_loc5_,_loc8_,_loc6_,0,0,0,0,0,1,0];
         var _loc3_:ColorMatrixFilter = new ColorMatrixFilter(_loc7_);
         var _loc9_:BitmapData = new BitmapData(param1.width,param1.height,param1.transparent,4294967295);
         _loc9_.copyPixels(param1,param1.rect,DEFAULT_POINT,null,null,false);
         _loc9_.applyFilter(_loc9_,_loc9_.rect,DEFAULT_POINT,_loc3_);
         return _loc9_;
      }
      
      private function errorThis(param1:String) : void
      {
      }
      
      private function logThis(param1:String) : void
      {
      }
      
      public function isPlaceholder() : Boolean
      {
         return false;
      }
      
      public function isBlocked() : Boolean
      {
         return false;
      }
      
      public function forceActionUpdate() : void
      {
         _lastActionsStr = "";
      }
      
      public function get animationHasResetOnToggle() : Boolean
      {
         return _animationHasResetOnToggle;
      }
      
      public function get mainAction() : String
      {
         return UnknownVarFromAvatarImage_IActiveActionData_1.actionType;
      }
      
      public function disposeInactiveActionCache() : void
      {
         if(_cache)
         {
            _cache.disposeInactiveActions();
         }
      }
      
      public function avatarEffectReady(param1:int) : void
      {
         if(param1 == UnknownVarFromAvatarImage_Int_3)
         {
            resetActions();
            setActionsToParts();
            _animationHasResetOnToggle = true;
            _changes = true;
            if(UnknownVarFromAvatarImage_IAvatarImage_1_1)
            {
               UnknownVarFromAvatarImage_IAvatarImage_1_1.avatarEffectReady(param1);
            }
         }
      }
      
      public function resetCache() : void
      {
         if(_cache != null)
         {
            _cache.reset();
         }
         if(_fullImageCache)
         {
            for each(var _loc1_ in _fullImageCache)
            {
               _loc1_.dispose();
            }
            _fullImageCache.dispose();
            _fullImageCache = new Map();
         }
         UnknownVarFromAvatarImage_Array_3 = [];
         UnknownVarFromAvatarImage_Int_5 = -1;
         UnknownVarFromAvatarImage_String_1 = null;
         UnknownVarFromAvatarImage_String_2 = null;
         _lastActionsStr = "";
         UnknownVarFromAvatarImage_Boolean_2 = false;
         _changes = true;
         UnknownVarFromAvatarImage_Boolean_3 = false;
         if(UnknownVarFromAvatarImage_BitmapData_1)
         {
            UnknownVarFromAvatarImage_BitmapData_1.dispose();
            UnknownVarFromAvatarImage_BitmapData_1 = null;
         }
         UnknownVarFromAvatarImage_Int_1 = 0;
      }
   }
}


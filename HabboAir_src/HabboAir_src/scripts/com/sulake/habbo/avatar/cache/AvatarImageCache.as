package com.sulake.habbo.avatar.cache
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.AvatarImageBodyPartContainer;
   import com.sulake.habbo.avatar.AvatarImagePartContainer;
   import com.sulake.habbo.avatar.AvatarStructure;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.actions.IActiveActionData;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.animation.Animation;
   import com.sulake.habbo.avatar.animation.AnimationLayerData;
   import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import com.sulake.habbo.avatar.structure.animation.AnimationFrame;
   import com.sulake.habbo.utils.BitmapHelper;
   import com.sulake.habbo.utils.StringBuffer;
   import com.sulake.room.data.RoomObjectSpriteData;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class AvatarImageCache
   {
      private static const DEFAULT_MAX_CACHE_STORAGE_TIME_MS:int = 60000;
      
      private static const UnknownConstFromAvatarImageCache_String_1:String = "_";
      
      private static const DEF_SEPARATOR:String = ".";
      
      private static const BASE_ACTION:String = "std";
      
      private static const LAY_BASE_ACTION:String = "lay";
      
      private static const PART_FACE:String = "fc";
      
      private static const PART_EYES:String = "ey";
      
      private static const PART_RIGHT_ITEM:String = "ri";
      
      private static const ACTION_WAVE:String = "wav";
      
      private static const ACTION_DRINK:String = "drk";
      
      private static const ACTION_BLOW:String = "blw";
      
      private static const ACTION_SIGN:String = "sig";
      
      private static const ACTION_RESPECT:String = "respect";
      
      private static var UnknownVarFromAvatarImageCache_StringBuffer_1:StringBuffer;
      
      private static var _partNameArray:Array;
      
      private static var UnknownVarFromAvatarImageCache_Array_1:Array;
      
      private var UnknownVarFromAvatarImageCache_AvatarStructure_1:AvatarStructure;
      
      private var UnknownVarFromAvatarImageCache_IAvatarImage_2_1:IAvatarImage_2;
      
      private var _assets:AssetAliasCollection;
      
      private var UnknownVarFromAvatarImageCache_String_1:String;
      
      private var _cache:Map;
      
      private var UnknownVarFromAvatarImageCache_AvatarCanvas_1:AvatarCanvas;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromAvatarImageCache_String_2:String;
      
      private var _unionImages:Array;
      
      private var UnknownVarFromAvatarImageCache_ColorTransform_1:ColorTransform;
      
      private var UnknownVarFromAvatarImageCache_Matrix_1:Matrix;
      
      private var UnknownVarFromAvatarImageCache_Array_2:Array;
      
      private var _largeScaledSmall:Boolean = false;
      
      private var UnknownVarFromAvatarImageCache_String_3:String = "std";
      
      private var _cachedPartName:String;
      
      private var UnknownVarFromAvatarImageCache_BitmapDataAsset_1:BitmapDataAsset;
      
      public function AvatarImageCache(param1:AvatarStructure, param2:IAvatarImage_2, param3:AssetAliasCollection, param4:String, param5:Boolean)
      {
         var _loc6_:int = 0;
         _unionImages = [];
         UnknownVarFromAvatarImageCache_ColorTransform_1 = new ColorTransform();
         UnknownVarFromAvatarImageCache_Matrix_1 = new Matrix();
         UnknownVarFromAvatarImageCache_Array_2 = [];
         super();
         UnknownVarFromAvatarImageCache_AvatarStructure_1 = param1;
         UnknownVarFromAvatarImageCache_IAvatarImage_2_1 = param2;
         _assets = param3;
         UnknownVarFromAvatarImageCache_String_1 = param4;
         _cache = new Map();
         _largeScaledSmall = param5;
         if(!UnknownVarFromAvatarImageCache_StringBuffer_1)
         {
            UnknownVarFromAvatarImageCache_StringBuffer_1 = new StringBuffer();
         }
         if(!_partNameArray)
         {
            _partNameArray = [null,"_",null,"_",null,"_",null,"_",null,"_",null];
         }
         if(!UnknownVarFromAvatarImageCache_Array_1)
         {
            UnknownVarFromAvatarImageCache_Array_1 = [];
            _loc6_ = 0;
            while(_loc6_ < 10000)
            {
               UnknownVarFromAvatarImageCache_Array_1.push(_loc6_.toString());
               _loc6_++;
            }
         }
      }
      
      private static function convertColorToHex(param1:Number) : String
      {
         var _loc2_:String = (param1 * 255).toString(16);
         if(_loc2_.length < 2)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         var _loc2_:AvatarImageBodyPartCache = null;
         var _loc1_:Array = null;
         var _loc3_:* = null;
         if(_disposed)
         {
            return;
         }
         UnknownVarFromAvatarImageCache_AvatarStructure_1 = null;
         UnknownVarFromAvatarImageCache_IAvatarImage_2_1 = null;
         _assets = null;
         if(_cache != null)
         {
            _loc1_ = _cache.getKeys();
            for each(_loc3_ in _loc1_)
            {
               _loc2_ = _cache.getValue(_loc3_) as AvatarImageBodyPartCache;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
            }
            _cache.dispose();
            _cache = null;
         }
         UnknownVarFromAvatarImageCache_AvatarCanvas_1 = null;
         _disposed = true;
      }
      
      public function reset() : void
      {
         var _loc2_:AvatarImageBodyPartCache = null;
         var _loc1_:Array = null;
         if(_cache != null)
         {
            _loc1_ = _cache.getKeys();
            for each(var _loc3_ in _loc1_)
            {
               _loc2_ = _cache.getValue(_loc3_) as AvatarImageBodyPartCache;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
            }
            _cache.reset();
         }
         UnknownVarFromAvatarImageCache_AvatarCanvas_1 = null;
         UnknownVarFromAvatarImageCache_String_3 = "std";
      }
      
      public function disposeInactiveActions(param1:int = 60000) : void
      {
         var _loc4_:AvatarImageBodyPartCache = null;
         var _loc5_:* = null;
         var _loc3_:int = getTimer();
         var _loc2_:Array = _cache.getKeys();
         for each(_loc5_ in _loc2_)
         {
            _loc4_ = _cache.getValue(_loc5_) as AvatarImageBodyPartCache;
            if(_loc4_ != null)
            {
               _loc4_.disposeActions(param1,_loc3_);
            }
         }
      }
      
      public function resetBodyPartCache(param1:IActiveActionData) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in _cache)
         {
            if(_loc2_ != null)
            {
               _loc2_.setAction(param1,0);
            }
         }
      }
      
      public function setDirection(param1:String, param2:int) : void
      {
         var _loc5_:AvatarImageBodyPartCache = null;
         var _loc3_:Array = UnknownVarFromAvatarImageCache_AvatarStructure_1.getBodyPartsUnordered(param1);
         for each(var _loc4_ in _loc3_)
         {
            _loc5_ = getBodyPartCache(_loc4_);
            if(_loc5_ != null)
            {
               _loc5_.setDirection(param2);
            }
         }
      }
      
      public function setAction(param1:IActiveActionData, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc5_:AvatarImageBodyPartCache = null;
         var _loc3_:Array = UnknownVarFromAvatarImageCache_AvatarStructure_1.getActiveBodyPartIds(param1,UnknownVarFromAvatarImageCache_IAvatarImage_2_1);
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = getBodyPartCache(_loc4_);
            if(_loc5_ != null)
            {
               _loc5_.setAction(param1,param2);
            }
         }
      }
      
      public function setGeometryType(param1:String) : void
      {
         if(UnknownVarFromAvatarImageCache_String_2 == param1)
         {
            return;
         }
         if(UnknownVarFromAvatarImageCache_String_2 == "sitting" && param1 == "vertical" || UnknownVarFromAvatarImageCache_String_2 == "vertical" && param1 == "sitting" || (UnknownVarFromAvatarImageCache_String_2 == "swhorizontal" || param1 == "swhorizontal"))
         {
            UnknownVarFromAvatarImageCache_String_2 = param1;
            UnknownVarFromAvatarImageCache_AvatarCanvas_1 = null;
            UnknownVarFromAvatarImageCache_String_3 = getDefaultActionFromGeometryType(UnknownVarFromAvatarImageCache_String_2);
            return;
         }
         disposeInactiveActions(0);
         UnknownVarFromAvatarImageCache_String_2 = param1;
         UnknownVarFromAvatarImageCache_AvatarCanvas_1 = null;
         UnknownVarFromAvatarImageCache_String_3 = getDefaultActionFromGeometryType(UnknownVarFromAvatarImageCache_String_2);
      }
      
      public function getImageContainer(param1:String, param2:int, param3:Boolean = false) : AvatarImageBodyPartContainer
      {
         var _loc7_:* = 0;
         var _loc14_:Animation = null;
         var _loc17_:int = 0;
         var _loc13_:AnimationLayerData = null;
         var _loc20_:* = undefined;
         var _loc18_:* = undefined;
         var _loc10_:AvatarImageBodyPartCache = getBodyPartCache(param1);
         if(_loc10_ == null)
         {
            _loc10_ = new AvatarImageBodyPartCache();
            _cache.add(param1,_loc10_);
         }
         var _loc11_:* = _loc10_.getDirection();
         var _loc9_:* = param2;
         var _loc15_:IActiveActionData = _loc10_.getAction();
         if(_loc15_ && _loc15_.definition.startFromFrameZero)
         {
            _loc9_ -= _loc15_.startFrame;
         }
         var _loc8_:* = _loc15_;
         var _loc4_:Array = [];
         var _loc16_:Map = new Map();
         var _loc12_:Point = new Point();
         if(!_loc15_ || !_loc15_.definition)
         {
            debugInfo("Action not found!");
            return null;
         }
         if(_loc15_.definition.isAnimation)
         {
            _loc7_ = _loc11_;
            _loc14_ = UnknownVarFromAvatarImageCache_AvatarStructure_1.getAnimation(_loc15_.definition.state + "." + _loc15_.actionParameter);
            _loc17_ = param2 - _loc15_.startFrame;
            if(_loc14_ != null)
            {
               _loc13_ = _loc14_.getLayerData(_loc17_,param1,_loc15_.overridingAction);
               if(_loc13_ != null)
               {
                  _loc7_ = _loc11_ + _loc13_.directionOffset;
                  if(_loc13_.directionOffset < 0)
                  {
                     if(_loc7_ < 0)
                     {
                        _loc7_ = 8 + _loc7_;
                     }
                     else if(_loc7_ > 7)
                     {
                        _loc7_ = 8 - _loc7_;
                     }
                  }
                  else if(_loc7_ < 0)
                  {
                     _loc7_ += 8;
                  }
                  else if(_loc7_ > 7)
                  {
                     _loc7_ -= 8;
                  }
                  if(UnknownVarFromAvatarImageCache_String_1 == "h")
                  {
                     _loc12_.x = _loc13_.dx;
                     _loc12_.y = _loc13_.dy;
                  }
                  else
                  {
                     _loc12_.x = _loc13_.dx / 2;
                     _loc12_.y = _loc13_.dy / 2;
                  }
                  _loc9_ = _loc13_.animationFrame;
                  if(_loc13_.action != null)
                  {
                     _loc15_ = _loc13_.action;
                  }
                  if(_loc13_.type == "bodypart")
                  {
                     if(_loc13_.action != null)
                     {
                        _loc8_ = _loc13_.action;
                     }
                     _loc11_ = _loc7_;
                  }
                  else if(_loc13_.type == "fx")
                  {
                     _loc11_ = _loc7_;
                  }
                  _loc16_ = _loc13_.items;
               }
               _loc4_ = _loc14_.removeData;
            }
         }
         var _loc19_:AvatarImageActionCache = _loc10_.getActionCache(_loc8_);
         if(_loc19_ == null || param3)
         {
            debugInfo("[CacheMiss (bodyPartCache.getActionCache)] [AvatarImageCache.getImageContainer] action.id: " + [param1,_loc8_.id]);
            _loc19_ = new AvatarImageActionCache();
            _loc10_.updateActionCache(_loc8_,_loc19_);
         }
         var _loc5_:AvatarImageDirectionCache = _loc19_.getDirectionCache(_loc11_);
         if(_loc5_ == null || param3)
         {
            debugInfo("[CacheMiss (actionCache.getDirectionCache)] [AvatarImageCache.getImageContainer] direction: " + [param1,_loc11_]);
            _loc20_ = UnknownVarFromAvatarImageCache_AvatarStructure_1.getParts(param1,UnknownVarFromAvatarImageCache_IAvatarImage_2_1.getFigure(),_loc8_,UnknownVarFromAvatarImageCache_String_2,_loc11_,_loc4_,UnknownVarFromAvatarImageCache_IAvatarImage_2_1,_loc16_);
            if(!_loc20_)
            {
               return null;
            }
            _loc5_ = new AvatarImageDirectionCache(_loc20_);
            _loc19_.updateDirectionCache(_loc11_,_loc5_);
         }
         var _loc6_:AvatarImageBodyPartContainer = _loc5_.getImageContainer(_loc9_);
         if(_loc6_ == null || param3)
         {
            _loc18_ = _loc5_.getPartList();
            _loc6_ = renderBodyPart(_loc11_,_loc18_,_loc9_,_loc15_,param3);
            if(!(_loc6_ != null && !param3))
            {
               return null;
            }
            if(_loc6_.isCacheable)
            {
               _loc5_.updateImageContainer(_loc6_,_loc9_);
            }
         }
         _loc6_.offset = _loc12_.add(UnknownVarFromAvatarImageCache_AvatarStructure_1.getFrameBodyPartOffset(_loc8_,_loc11_,_loc9_,param1));
         return _loc6_;
      }
      
      public function getServerRenderData() : Array
      {
         var _loc1_:Array = UnknownVarFromAvatarImageCache_Array_2;
         UnknownVarFromAvatarImageCache_Array_2 = [];
         return _loc1_;
      }
      
      public function getBodyPartCache(param1:String) : AvatarImageBodyPartCache
      {
         var _loc2_:AvatarImageBodyPartCache = _cache.getValue(param1) as AvatarImageBodyPartCache;
         if(_loc2_ == null)
         {
            _loc2_ = new AvatarImageBodyPartCache();
            _cache.add(param1,_loc2_);
         }
         return _loc2_;
      }
      
      private function renderBodyPart(param1:int, param2:Vector.<AvatarImagePartContainer>, param3:int, param4:IActiveActionData, param5:Boolean = false) : AvatarImageBodyPartContainer
      {
         var _loc12_:Boolean = false;
         var _loc25_:* = 0;
         var _loc8_:AvatarImagePartContainer = null;
         var _loc18_:String = null;
         var _loc6_:String = null;
         var _loc15_:AnimationFrame = null;
         var _loc27_:int = 0;
         var _loc31_:BitmapDataAsset = null;
         var _loc10_:String = null;
         var _loc30_:BitmapData = null;
         var _loc21_:Boolean = false;
         var _loc17_:ColorTransform = null;
         var _loc19_:Point = null;
         var _loc11_:ColorTransform = null;
         var _loc28_:RoomObjectSpriteData = null;
         var _loc9_:ImageData = null;
         if(param2 == null)
         {
            return null;
         }
         if(param2.length == 0)
         {
            return null;
         }
         if(!ensureCanvas())
         {
            return null;
         }
         var _loc24_:* = param1;
         var _loc26_:Boolean = Boolean(AvatarDirectionAngle.UnknownConstFromAvatarDirectionAngle_Array_2[param1]);
         var _loc32_:String = param4.definition.assetPartDefinition;
         var _loc13_:Boolean = true;
         var _loc23_:* = null;
         var _loc20_:int;
         _loc25_ = _loc20_ = param2.length - 1;
         while(_loc25_ >= 0)
         {
            _loc8_ = param2[_loc25_] as AvatarImagePartContainer;
            if(!(param1 == 7 && (_loc8_.partType == "fc" || _loc8_.partType == "ey")))
            {
               if(!(_loc8_.partType == "ri" && _loc8_.partId == null))
               {
                  _loc18_ = _loc8_.partType;
                  _loc6_ = _loc8_.partId;
                  _loc15_ = _loc8_.getFrameDefinition(param3);
                  if(_loc15_)
                  {
                     _loc27_ = _loc15_.number;
                     if(_loc15_.assetPartDefinition && _loc15_.assetPartDefinition.length > 0)
                     {
                        _loc32_ = _loc15_.assetPartDefinition;
                     }
                  }
                  else
                  {
                     _loc27_ = _loc8_.getFrameIndex(param3);
                  }
                  _loc24_ = param1;
                  _loc12_ = false;
                  if(_loc26_)
                  {
                     if(_loc32_ == "wav" && (_loc18_ == "lh" || _loc18_ == "ls" || _loc18_ == "lc" || _loc18_ == "mcl"))
                     {
                        _loc12_ = true;
                     }
                     else if(_loc32_ == "drk" && (_loc18_ == "rh" || _loc18_ == "rs" || _loc18_ == "rc" || _loc18_ == "mcr"))
                     {
                        _loc12_ = true;
                     }
                     else if(_loc32_ == "blw" && _loc18_ == "rh")
                     {
                        _loc12_ = true;
                     }
                     else if(_loc32_ == "sig" && _loc18_ == "lh")
                     {
                        _loc12_ = true;
                     }
                     else if(_loc32_ == "respect" && _loc18_ == "lh")
                     {
                        _loc12_ = true;
                     }
                     else if(_loc18_ == "ri")
                     {
                        _loc12_ = true;
                     }
                     else if(_loc18_ == "li")
                     {
                        _loc12_ = true;
                     }
                     else if(_loc18_ == "cp")
                     {
                        _loc12_ = true;
                     }
                     else
                     {
                        if(param1 == 4)
                        {
                           _loc24_ = 2;
                        }
                        else if(param1 == 5)
                        {
                           _loc24_ = 1;
                        }
                        else if(param1 == 6)
                        {
                           _loc24_ = 0;
                        }
                        if(_loc8_.flippedPartType != _loc18_)
                        {
                           _loc18_ = _loc8_.flippedPartType;
                        }
                     }
                  }
                  UnknownVarFromAvatarImageCache_StringBuffer_1.length = 0;
                  _partNameArray[0] = _largeScaledSmall ? "h" : UnknownVarFromAvatarImageCache_String_1;
                  _partNameArray[2] = _loc32_;
                  _partNameArray[4] = _loc18_;
                  _partNameArray[6] = _loc6_;
                  _partNameArray[8] = UnknownVarFromAvatarImageCache_Array_1[_loc24_];
                  _partNameArray[10] = UnknownVarFromAvatarImageCache_Array_1[_loc27_];
                  UnknownVarFromAvatarImageCache_StringBuffer_1.appendStringArray(_partNameArray);
                  _loc31_ = tryResolveAsset(_loc32_,_loc18_,_loc6_,_loc24_,_loc27_);
                  _loc10_ = _cachedPartName;
                  if(_loc31_)
                  {
                     _loc30_ = _loc31_.content as BitmapData;
                     if(_loc30_ == null)
                     {
                        _loc13_ = false;
                     }
                     else
                     {
                        _loc21_ = false;
                        if(_loc8_.isColorable && _loc8_.color != null)
                        {
                           _loc17_ = _loc8_.color.colorTransform;
                           UnknownVarFromAvatarImageCache_ColorTransform_1.redMultiplier = _loc17_.redMultiplier;
                           UnknownVarFromAvatarImageCache_ColorTransform_1.greenMultiplier = _loc17_.greenMultiplier;
                           UnknownVarFromAvatarImageCache_ColorTransform_1.blueMultiplier = _loc17_.blueMultiplier;
                           UnknownVarFromAvatarImageCache_ColorTransform_1.alphaMultiplier = _loc17_.alphaMultiplier;
                           _loc21_ = true;
                        }
                        else
                        {
                           UnknownVarFromAvatarImageCache_ColorTransform_1.redMultiplier = UnknownVarFromAvatarImageCache_ColorTransform_1.greenMultiplier = UnknownVarFromAvatarImageCache_ColorTransform_1.blueMultiplier = UnknownVarFromAvatarImageCache_ColorTransform_1.alphaMultiplier = 1;
                        }
                        if(_loc8_.isBlendable)
                        {
                           UnknownVarFromAvatarImageCache_ColorTransform_1.concat(_loc8_.blendTransform);
                           _loc21_ = true;
                        }
                        _loc19_ = _loc31_.offset.clone();
                        if(_loc12_)
                        {
                           _loc19_.x += UnknownVarFromAvatarImageCache_String_1 == "h" ? 65 : 31;
                        }
                        _loc11_ = null;
                        if(_loc21_)
                        {
                           _loc11_ = new ColorTransform();
                           _loc11_.concat(UnknownVarFromAvatarImageCache_ColorTransform_1);
                        }
                        if(param5)
                        {
                           _loc28_ = new RoomObjectSpriteData();
                           _loc28_.name = _assets.getAssetName(_loc10_);
                           _loc28_.x = -_loc19_.x - 33;
                           _loc28_.y = -_loc19_.y;
                           _loc28_.z = UnknownVarFromAvatarImageCache_Array_2.length * -0.0001;
                           _loc28_.width = _loc31_.rectangle.width;
                           _loc28_.height = _loc31_.rectangle.height;
                           _loc28_.flipH = _loc12_;
                           if(_loc32_ == "lay")
                           {
                              _loc28_.x += 53;
                           }
                           if(_loc26_)
                           {
                              _loc28_.flipH = !_loc28_.flipH;
                              if(_loc28_.flipH)
                              {
                                 _loc28_.x = -_loc28_.x - _loc30_.width;
                              }
                              else
                              {
                                 _loc28_.x += 65;
                              }
                           }
                           if(_loc8_.isColorable && _loc11_)
                           {
                              _loc28_.color = "0x" + convertColorToHex(_loc11_.redMultiplier) + convertColorToHex(_loc11_.greenMultiplier) + convertColorToHex(_loc11_.blueMultiplier);
                           }
                           UnknownVarFromAvatarImageCache_Array_2.push(_loc28_);
                        }
                        if(_loc8_.partType == "fc")
                        {
                           _loc23_ = _loc19_;
                        }
                        _unionImages.push(new ImageData(_loc30_,_loc31_.rectangle,_loc19_,_loc12_,_loc11_));
                     }
                  }
               }
            }
            _loc25_--;
         }
         if(_unionImages.length == 0)
         {
            return null;
         }
         var _loc16_:ImageData = createUnionImage(_unionImages,_loc26_);
         if(!ensureCanvas())
         {
            return null;
         }
         var _loc14_:int = UnknownVarFromAvatarImageCache_String_1 == "h" ? UnknownVarFromAvatarImageCache_AvatarCanvas_1.height - 16 : UnknownVarFromAvatarImageCache_AvatarCanvas_1.height - 8;
         var _loc22_:Point = _loc16_.regPoint;
         if(_largeScaledSmall)
         {
            _loc22_ = new Point(_loc22_.x / 2,_loc22_.y / 2);
         }
         var _loc7_:Point = new Point(-_loc22_.x,_loc14_ - _loc22_.y);
         if(_loc26_ && _loc32_ != "lay")
         {
            _loc7_.x += UnknownVarFromAvatarImageCache_String_1 == "h" ? 67 : 31;
         }
         _loc25_ = _unionImages.length - 1;
         while(_loc25_ >= 0)
         {
            _loc9_ = _unionImages.pop();
            if(_loc9_)
            {
               _loc9_.dispose();
            }
            _loc25_--;
         }
         var _loc29_:BitmapData = _loc16_.bitmap;
         if(_largeScaledSmall)
         {
            _loc29_ = BitmapHelper.resampleBitmapData(_loc29_,0.5);
         }
         return new AvatarImageBodyPartContainer(_loc29_,_loc7_,_loc13_,_loc23_);
      }
      
      private function ensureCanvas() : Boolean
      {
         if(!UnknownVarFromAvatarImageCache_AvatarCanvas_1)
         {
            UnknownVarFromAvatarImageCache_AvatarCanvas_1 = UnknownVarFromAvatarImageCache_AvatarStructure_1.getCanvas(UnknownVarFromAvatarImageCache_String_1,UnknownVarFromAvatarImageCache_String_2);
            if(!UnknownVarFromAvatarImageCache_AvatarCanvas_1)
            {
               return false;
            }
         }
         return true;
      }
      
      private function tryResolveAsset(param1:String, param2:String, param3:String, param4:int, param5:int) : BitmapDataAsset
      {
         var _loc6_:String = _largeScaledSmall ? "h" : UnknownVarFromAvatarImageCache_String_1;
         _partNameArray[0] = _loc6_;
         _partNameArray[2] = param1;
         _partNameArray[4] = param2;
         _partNameArray[6] = param3;
         _partNameArray[8] = UnknownVarFromAvatarImageCache_Array_1[param4];
         _partNameArray[10] = UnknownVarFromAvatarImageCache_Array_1[param5];
         if(tryGetAssetWithArray(_partNameArray))
         {
            return UnknownVarFromAvatarImageCache_BitmapDataAsset_1;
         }
         _partNameArray[10] = UnknownVarFromAvatarImageCache_Array_1[0];
         if(tryGetAssetWithArray(_partNameArray))
         {
            return UnknownVarFromAvatarImageCache_BitmapDataAsset_1;
         }
         _partNameArray[2] = UnknownVarFromAvatarImageCache_String_3;
         _partNameArray[10] = UnknownVarFromAvatarImageCache_Array_1[param5];
         if(tryGetAssetWithArray(_partNameArray))
         {
            return UnknownVarFromAvatarImageCache_BitmapDataAsset_1;
         }
         _partNameArray[10] = UnknownVarFromAvatarImageCache_Array_1[0];
         if(tryGetAssetWithArray(_partNameArray))
         {
            return UnknownVarFromAvatarImageCache_BitmapDataAsset_1;
         }
         return null;
      }
      
      private function tryGetAssetWithArray(param1:Array) : Boolean
      {
         UnknownVarFromAvatarImageCache_StringBuffer_1.length = 0;
         UnknownVarFromAvatarImageCache_StringBuffer_1.appendStringArray(param1);
         _cachedPartName = UnknownVarFromAvatarImageCache_StringBuffer_1.toString();
         UnknownVarFromAvatarImageCache_BitmapDataAsset_1 = _assets.getAssetByName(_cachedPartName) as BitmapDataAsset;
         return UnknownVarFromAvatarImageCache_BitmapDataAsset_1 != null;
      }
      
      private function getDefaultActionFromGeometryType(param1:String) : String
      {
         return param1 == "horizontal" ? "lay" : "std";
      }
      
      private function createUnionImage(param1:Array, param2:Boolean) : ImageData
      {
         var _loc4_:* = null;
         var _loc7_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:BitmapData = null;
         var _loc8_:Boolean = false;
         var _loc3_:Rectangle = null;
         _loc3_ = new Rectangle();
         for each(_loc4_ in param1)
         {
            _loc3_ = _loc3_.union(_loc4_.offsetRect);
         }
         _loc5_ = new Point(-_loc3_.left,-_loc3_.top);
         _loc6_ = new BitmapData(_loc3_.width,_loc3_.height,true,16777215);
         for each(_loc4_ in param1)
         {
            _loc7_ = _loc5_.subtract(_loc4_.regPoint);
            if(param2)
            {
               _loc7_.x = _loc6_.width - (_loc7_.x + _loc4_.rect.width);
            }
            _loc8_ = !(param2 && _loc4_.flipH) && (param2 || _loc4_.flipH);
            if(_loc8_)
            {
               UnknownVarFromAvatarImageCache_Matrix_1.a = -1;
               UnknownVarFromAvatarImageCache_Matrix_1.tx = _loc4_.rect.x + _loc4_.rect.width + _loc7_.x;
               UnknownVarFromAvatarImageCache_Matrix_1.ty = _loc7_.y - _loc4_.rect.y;
               _loc3_.x = _loc7_.x;
               _loc3_.y = _loc7_.y;
               _loc3_.width = _loc4_.rect.width;
               _loc3_.height = _loc4_.rect.height;
               _loc6_.draw(_loc4_.bitmap,UnknownVarFromAvatarImageCache_Matrix_1,_loc4_.colorTransform,null,_loc3_);
            }
            else if(_loc4_.colorTransform)
            {
               UnknownVarFromAvatarImageCache_Matrix_1.a = 1;
               UnknownVarFromAvatarImageCache_Matrix_1.tx = _loc7_.x - _loc4_.rect.x;
               UnknownVarFromAvatarImageCache_Matrix_1.ty = _loc7_.y - _loc4_.rect.y;
               _loc3_.x = _loc7_.x;
               _loc3_.y = _loc7_.y;
               _loc3_.width = _loc4_.rect.width;
               _loc3_.height = _loc4_.rect.height;
               _loc6_.draw(_loc4_.bitmap,UnknownVarFromAvatarImageCache_Matrix_1,_loc4_.colorTransform,null,_loc3_);
            }
            else
            {
               _loc6_.copyPixels(_loc4_.bitmap,_loc4_.rect,_loc7_,null,null,true);
            }
         }
         return new ImageData(_loc6_,_loc6_.rect,_loc5_,param2,null);
      }
      
      private function drawBorders(param1:BitmapData, param2:Rectangle, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = param2.bottom - 1;
         _loc4_ = param2.left;
         while(_loc4_ < param2.right - 1)
         {
            param1.setPixel32(_loc4_,0,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc4_++;
         }
         _loc5_ = param2.top;
         while(_loc5_ < param2.bottom - 1)
         {
            param1.setPixel32(0,_loc5_,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc5_++;
         }
      }
      
      private function debugInfo(param1:String) : void
      {
      }
   }
}


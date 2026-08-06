package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.utils.StringBuffer;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   
   public class FurnitureVisualization extends RoomObjectSpriteVisualization
   {
      private static var UnknownVarFromFurnitureVisualization_StringBuffer_1:StringBuffer;
      
      private static var UnknownVarFromFurnitureVisualization_Array_1:Array;
      
      protected static const Z_MULTIPLIER:Number = Math.sqrt(0.5);
      
      private const UnknownConstFromFurnitureVisualization_Int_1:int = 41;
      
      protected var _lastUpdateTime:int = -1000;
      
      private var _direction:int;
      
      private var UnknownVarFromFurnitureVisualization_Number_1:Number = NaN;
      
      private var _selectedColor:int = -1;
      
      protected var UnknownVarFromFurnitureVisualization_Number_2:Number = 1;
      
      private var UnknownVarFromFurnitureVisualization_String_1:String = null;
      
      private var UnknownVarFromFurnitureVisualization_Boolean_1:Boolean = false;
      
      private var _data:FurnitureVisualizationData = null;
      
      private var _type:String = "";
      
      private var _assetNames:Array = [];
      
      private var _assetNamesFrame:Array = [];
      
      private var UnknownVarFromFurnitureVisualization_Number_3:Number = 0;
      
      private var UnknownVarFromFurnitureVisualization_Int_1:int = -1;
      
      private var UnknownVarFromFurnitureVisualization_Int_2:int = -1;
      
      private var UnknownVarFromFurnitureVisualization_Array_2:Array = [];
      
      private var UnknownVarFromFurnitureVisualization_Array_3:Array = [];
      
      private var _spriteColors:Array = [];
      
      private var UnknownVarFromFurnitureVisualization_Array_4:Array = [];
      
      private var UnknownVarFromFurnitureVisualization_Array_5:Array = [];
      
      private var UnknownVarFromFurnitureVisualization_Array_6:Array = [];
      
      private var _spriteMouseCaptures:Array = [];
      
      private var UnknownVarFromFurnitureVisualization_Array_7:Array = [];
      
      protected var UnknownVarFromFurnitureVisualization_Boolean_2:Boolean = true;
      
      protected var UnknownVarFromFurnitureVisualization_Int_3:int = 0;
      
      protected var UnknownVarFromFurnitureVisualization_Int_4:int = -1;
      
      private var _updatedLayers:int = 0;
      
      private var UnknownVarFromFurnitureVisualization_Number_4:Number = 0;
      
      private var UnknownVarFromFurnitureVisualization_Boolean_3:Boolean = false;
      
      private var UnknownVarFromFurnitureVisualization_Boolean_4:Boolean = false;
      
      private var _filters:Array = null;
      
      private var UnknownVarFromFurnitureVisualization_Boolean_5:Boolean = false;
      
      private var UnknownVarFromFurnitureVisualization_Boolean_6:Boolean = false;
      
      public function FurnitureVisualization()
      {
         super();
         reset();
         if(!UnknownVarFromFurnitureVisualization_StringBuffer_1)
         {
            UnknownVarFromFurnitureVisualization_StringBuffer_1 = new StringBuffer();
            UnknownVarFromFurnitureVisualization_Array_1 = [];
            UnknownVarFromFurnitureVisualization_Array_1[0] = null;
            UnknownVarFromFurnitureVisualization_Array_1[1] = "_";
            UnknownVarFromFurnitureVisualization_Array_1[2] = null;
            UnknownVarFromFurnitureVisualization_Array_1[3] = "_";
            UnknownVarFromFurnitureVisualization_Array_1[4] = null;
            UnknownVarFromFurnitureVisualization_Array_1[5] = "_";
            UnknownVarFromFurnitureVisualization_Array_1[6] = null;
            UnknownVarFromFurnitureVisualization_Array_1[7] = "_";
         }
      }
      
      private static function concatListWillEqual(param1:Array, param2:Array, param3:Array) : Boolean
      {
         var _loc4_:int = 0;
         if(param3 == null)
         {
            return false;
         }
         if(param1.length + param2.length != param3.length)
         {
            return false;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] !== param3[_loc4_])
            {
               return false;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            if(param2[_loc4_] !== param3[param1.length + _loc4_])
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      protected function set direction(param1:int) : void
      {
         _direction = param1;
      }
      
      protected function get direction() : int
      {
         return _direction;
      }
      
      protected function get type() : String
      {
         return _type;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _data = null;
         _assetNames = null;
         _assetNamesFrame = null;
         UnknownVarFromFurnitureVisualization_Array_2 = null;
         UnknownVarFromFurnitureVisualization_Array_3 = null;
         _spriteColors = null;
         UnknownVarFromFurnitureVisualization_Array_4 = null;
         UnknownVarFromFurnitureVisualization_Array_5 = null;
         UnknownVarFromFurnitureVisualization_Array_6 = null;
         _spriteMouseCaptures = null;
         UnknownVarFromFurnitureVisualization_Array_7 = null;
         _filters = null;
      }
      
      override protected function reset() : void
      {
         super.reset();
         direction = -1;
         _data = null;
         _assetNames = _assetNames.length > 0 ? [] : _assetNames;
         _assetNamesFrame = _assetNamesFrame.length > 0 ? [] : _assetNamesFrame;
         UnknownVarFromFurnitureVisualization_Array_2 = UnknownVarFromFurnitureVisualization_Array_2.length > 0 ? [] : UnknownVarFromFurnitureVisualization_Array_2;
         UnknownVarFromFurnitureVisualization_Array_3 = UnknownVarFromFurnitureVisualization_Array_3.length > 0 ? [] : UnknownVarFromFurnitureVisualization_Array_3;
         _spriteColors = _spriteColors.length > 0 ? [] : _spriteColors;
         UnknownVarFromFurnitureVisualization_Array_4 = UnknownVarFromFurnitureVisualization_Array_4.length > 0 ? [] : UnknownVarFromFurnitureVisualization_Array_4;
         UnknownVarFromFurnitureVisualization_Array_5 = UnknownVarFromFurnitureVisualization_Array_5.length > 0 ? [] : UnknownVarFromFurnitureVisualization_Array_5;
         UnknownVarFromFurnitureVisualization_Array_6 = UnknownVarFromFurnitureVisualization_Array_6.length > 0 ? [] : UnknownVarFromFurnitureVisualization_Array_6;
         _spriteMouseCaptures = _spriteMouseCaptures.length > 0 ? [] : _spriteMouseCaptures;
         UnknownVarFromFurnitureVisualization_Array_7 = UnknownVarFromFurnitureVisualization_Array_7.length > 0 ? [] : UnknownVarFromFurnitureVisualization_Array_7;
         clearSprites();
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         reset();
         if(param1 == null || !(param1 is FurnitureVisualizationData))
         {
            return false;
         }
         _data = param1 as FurnitureVisualizationData;
         _type = _data.getType();
         return true;
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2 < _lastUpdateTime + 41 && param1.LockAnimationFPS)
         {
            return;
         }
         _lastUpdateTime += 41;
         if(_lastUpdateTime + 41 < param2)
         {
            _lastUpdateTime = param2 - 41;
         }
         var _loc5_:Boolean = false;
         var _loc6_:Number = param1.scale;
         if(updateObject(_loc6_,param1.direction.x))
         {
            _loc5_ = true;
         }
         if(updateModel(_loc6_))
         {
            _loc5_ = true;
         }
         if(UnknownVarFromFurnitureVisualization_Boolean_4)
         {
            _loc5_ = true;
            UnknownVarFromFurnitureVisualization_Boolean_4 = false;
         }
         if(UnknownVarFromFurnitureVisualization_Boolean_5)
         {
            _loc5_ = true;
            UnknownVarFromFurnitureVisualization_Boolean_5 = false;
         }
         var _loc7_:* = 0;
         if(param4)
         {
            _updatedLayers |= updateAnimation(_loc6_);
         }
         else
         {
            _loc7_ = updateAnimation(_loc6_) | _updatedLayers;
            _updatedLayers = 0;
         }
         if(_loc5_ || _loc7_ != 0)
         {
            updateSprites(_loc6_,_loc5_,_loc7_);
            UnknownVarFromRoomObjectSpriteVisualization_Int_4 = _loc6_;
            increaseUpdateId();
         }
      }
      
      protected function updateSprites(param1:int, param2:Boolean, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(UnknownVarFromFurnitureVisualization_Int_3 != spriteCount)
         {
            createSprites(UnknownVarFromFurnitureVisualization_Int_3);
         }
         if(param2)
         {
            _loc5_ = spriteCount - 1;
            while(_loc5_ >= 0)
            {
               updateSprite(param1,_loc5_);
               _loc5_--;
            }
         }
         else
         {
            _loc4_ = 0;
            while(param3 > 0)
            {
               if(param3 & 1)
               {
                  updateSprite(param1,_loc4_);
               }
               _loc4_++;
               param3 >>= 1;
            }
         }
         UnknownVarFromFurnitureVisualization_Boolean_2 = false;
      }
      
      protected function updateSprite(param1:int, param2:int) : void
      {
         var _loc7_:IGraphicAsset = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:String = getSpriteAssetName(param1,param2);
         var _loc6_:IRoomObjectSprite = getSprite(param2);
         if(_loc6_ != null && _loc5_ != null)
         {
            _loc7_ = getAsset(_loc5_,param2);
            if(_loc7_ != null && _loc7_.asset != null)
            {
               _loc6_.visible = true;
               _loc6_.objectType = _type;
               _loc6_.asset = _loc7_.asset.content as BitmapData;
               if(_loc7_.asset.content == null)
               {
                  UnknownVarFromRoomObjectSpriteVisualization_Int_3++;
               }
               _loc6_.flipH = _loc7_.flipH;
               _loc6_.flipV = _loc7_.flipV;
               _loc6_.direction = _direction;
               _loc3_ = 0;
               if(param2 != UnknownVarFromFurnitureVisualization_Int_4)
               {
                  _loc6_.tag = getSpriteTag(param1,_direction,param2);
                  _loc6_.alpha = getSpriteAlpha(param1,_direction,param2);
                  _loc6_.color = getSpriteColor(param1,param2,_selectedColor);
                  _loc6_.offsetX = _loc7_.offsetX + getSpriteXOffset(param1,_direction,param2);
                  _loc6_.offsetY = _loc7_.offsetY + getSpriteYOffset(param1,_direction,param2);
                  _loc6_.alphaTolerance = getSpriteMouseCapture(param1,_direction,param2) ? 128 : 256;
                  _loc6_.blendMode = getBlendMode(getSpriteInk(param1,_direction,param2));
                  if(getSpriteFlipH(param1,_direction,param2))
                  {
                     _loc6_.flipH = !_loc6_.flipH;
                  }
                  if(UnknownVarFromFurnitureVisualization_Boolean_6 && _loc6_.tag == "invisible")
                  {
                     _loc6_.alpha = 0;
                     _loc6_.alphaTolerance = 256;
                  }
                  _loc3_ = getSpriteZOffset(param1,_direction,param2);
                  _loc3_ -= param2 * 0.001;
               }
               else
               {
                  _loc6_.offsetX = _loc7_.offsetX;
                  _loc6_.offsetY = _loc7_.offsetY + getSpriteYOffset(param1,_direction,param2);
                  _loc4_ = 48;
                  _loc4_ = _loc4_ * UnknownVarFromFurnitureVisualization_Number_2;
                  _loc6_.alpha = _loc4_;
                  _loc6_.alphaTolerance = 256;
                  _loc3_ = 1;
               }
               if(UnknownVarFromFurnitureVisualization_Boolean_3)
               {
                  _loc6_.alpha *= 0.2;
               }
               _loc3_ *= Z_MULTIPLIER;
               _loc6_.relativeDepth = _loc3_;
               _loc6_.assetName = _loc7_.assetName;
               _loc6_.libraryAssetName = getLibraryAssetNameForSprite(_loc7_,_loc6_);
               _loc6_.assetPosture = getPostureForAssetFile(param1,_loc7_.libraryAssetName);
               _loc6_.clickHandling = UnknownVarFromFurnitureVisualization_Boolean_1;
               updateSpriteFilters(param1,_loc6_,param2);
            }
            else
            {
               resetSprite(_loc6_,param2);
            }
         }
         else if(_loc6_ != null)
         {
            resetSprite(_loc6_,param2);
         }
      }
      
      private function updateSpriteFilters(param1:int, param2:IRoomObjectSprite, param3:int) : void
      {
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         if(param2.blendMode != "add")
         {
            _loc4_ = getSpriteFilters(param1,_direction,param3);
            if(_loc4_ == null)
            {
               param2.filters = _filters;
            }
            else if(_filters == null)
            {
               param2.filters = _loc4_;
            }
            else
            {
               if(concatListWillEqual(_filters,_loc4_,param2.filters))
               {
                  return;
               }
               _loc5_ = _filters.concat(_loc4_);
               param2.filters = _loc5_;
            }
         }
         else if(param2.filters != null)
         {
            param2.filters = null;
         }
      }
      
      protected function getLibraryAssetNameForSprite(param1:IGraphicAsset, param2:IRoomObjectSprite) : String
      {
         return param1.libraryAssetName;
      }
      
      private function resetSprite(param1:IRoomObjectSprite, param2:int) : void
      {
         param1.asset = null;
         param1.assetName = "";
         param1.assetPosture = null;
         param1.alpha = 0;
         param1.tag = "";
         param1.flipH = false;
         param1.flipV = false;
         param1.offsetX = 0;
         param1.offsetY = 0;
         param1.relativeDepth = 0;
         param1.clickHandling = false;
         if(UnknownVarFromFurnitureVisualization_Boolean_2)
         {
            delete UnknownVarFromFurnitureVisualization_Array_3[param2];
         }
      }
      
      protected function getBlendMode(param1:int) : String
      {
         var _loc2_:String = "normal";
         switch(param1)
         {
            case 0:
               break;
            case 1:
               _loc2_ = "add";
               break;
            case 2:
               _loc2_ = "subtract";
               break;
            case 3:
               _loc2_ = "darken";
               break;
            case 4:
               _loc2_ = "difference";
               break;
            case 5:
               _loc2_ = "multiply";
               break;
            case 6:
               _loc2_ = "invert";
               break;
            case 7:
               _loc2_ = "screen";
         }
         return _loc2_;
      }
      
      protected function updateObject(param1:Number, param2:Number) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc3_:IRoomObject = object;
         if(_loc3_ == null)
         {
            return false;
         }
         if(UnknownVarFromRoomObjectSpriteVisualization_Int_2 != _loc3_.getUpdateID() || param1 != UnknownVarFromRoomObjectSpriteVisualization_Int_4 || param2 != UnknownVarFromFurnitureVisualization_Number_1)
         {
            _loc4_ = _loc3_.getDirection().x - (param2 + 135);
            _loc4_ = (_loc4_ % 360 + 360) % 360;
            if(_data != null)
            {
               direction = _loc5_ = _data.getDirectionValue(param1,_loc4_);
            }
            UnknownVarFromRoomObjectSpriteVisualization_Int_2 = _loc3_.getUpdateID();
            UnknownVarFromFurnitureVisualization_Number_1 = param2;
            UnknownVarFromRoomObjectSpriteVisualization_Int_4 = param1;
            updateAssetAndSpriteCache(param1,_direction);
            return true;
         }
         return false;
      }
      
      protected function updateModel(param1:Number) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc5_:* = false;
         var _loc2_:IRoomObject = object;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:IRoomObjectModel = _loc2_.getModel();
         if(_loc3_ == null)
         {
            return false;
         }
         if(UnknownVarFromRoomObjectSpriteVisualization_Int_3 != _loc3_.getUpdateID())
         {
            _selectedColor = _loc3_.getNumber("furniture_color");
            _loc4_ = _loc3_.getNumber("furniture_alpha_multiplier");
            if(isNaN(_loc4_))
            {
               _loc4_ = 1;
            }
            if(_loc4_ != UnknownVarFromFurnitureVisualization_Number_2)
            {
               UnknownVarFromFurnitureVisualization_Number_2 = _loc4_;
               UnknownVarFromFurnitureVisualization_Boolean_2 = true;
            }
            _loc5_ = _loc3_.getNumber("furniture_invisible_layer") > 0;
            if(_loc5_ != UnknownVarFromFurnitureVisualization_Boolean_6)
            {
               UnknownVarFromFurnitureVisualization_Boolean_6 = _loc5_;
               UnknownVarFromFurnitureVisualization_Boolean_2 = true;
            }
            UnknownVarFromFurnitureVisualization_String_1 = getAdClickUrl(_loc3_);
            UnknownVarFromFurnitureVisualization_Boolean_1 = UnknownVarFromFurnitureVisualization_String_1 != null && UnknownVarFromFurnitureVisualization_String_1 != "" && UnknownVarFromFurnitureVisualization_String_1.indexOf("http") == 0;
            UnknownVarFromFurnitureVisualization_Number_4 = _loc3_.getNumber("furniture_lift_amount");
            UnknownVarFromRoomObjectSpriteVisualization_Int_3 = _loc3_.getUpdateID();
            return true;
         }
         return false;
      }
      
      protected function getAdClickUrl(param1:IRoomObjectModel) : String
      {
         return param1.getString("furniture_ad_url");
      }
      
      protected function updateAnimation(param1:Number) : int
      {
         return 0;
      }
      
      private function updateAssetAndSpriteCache(param1:Number, param2:int) : void
      {
         if(UnknownVarFromFurnitureVisualization_Int_2 != param2 || UnknownVarFromFurnitureVisualization_Number_3 != param1)
         {
            _assetNames = [];
            _assetNamesFrame = [];
            UnknownVarFromFurnitureVisualization_Array_2 = [];
            UnknownVarFromFurnitureVisualization_Array_3 = [];
            _spriteColors = [];
            UnknownVarFromFurnitureVisualization_Array_4 = [];
            UnknownVarFromFurnitureVisualization_Array_5 = [];
            UnknownVarFromFurnitureVisualization_Array_6 = [];
            _spriteMouseCaptures = [];
            UnknownVarFromFurnitureVisualization_Array_7 = [];
            UnknownVarFromFurnitureVisualization_Int_2 = param2;
            UnknownVarFromFurnitureVisualization_Number_3 = param1;
            UnknownVarFromFurnitureVisualization_Int_1 = getSize(param1);
            updateLayerCount(_data.getLayerCount(param1) + getAdditionalSpriteCount(param1),param1);
         }
      }
      
      protected function updateLayerCount(param1:int, param2:Number) : void
      {
         UnknownVarFromFurnitureVisualization_Int_3 = param1;
         UnknownVarFromFurnitureVisualization_Int_4 = UnknownVarFromFurnitureVisualization_Int_3 - getAdditionalSpriteCount(param2);
      }
      
      protected function getAdditionalSpriteCount(param1:Number) : int
      {
         return 1;
      }
      
      protected function getFrameNumber(param1:int, param2:int) : int
      {
         return 0;
      }
      
      protected function getPostureForAssetFile(param1:int, param2:String) : String
      {
         return null;
      }
      
      protected function getAsset(param1:String, param2:int = -1) : IGraphicAsset
      {
         var _loc3_:* = null;
         if(assetCollection != null)
         {
            return assetCollection.getAsset(param1);
         }
         return null;
      }
      
      protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         if(_data == null || param2 >= FurnitureVisualizationData.LAYER_NAMES.length)
         {
            return "";
         }
         var _loc4_:String = _assetNames[param2];
         var _loc3_:* = Boolean(_assetNamesFrame[param2]);
         if(_loc4_ == null || _loc4_.length == 0)
         {
            _loc4_ = getSpriteAssetNameWithoutFrame(param1,param2,true);
            _loc3_ = UnknownVarFromFurnitureVisualization_Int_1 != 1;
         }
         if(_loc3_)
         {
            _loc4_ += getFrameNumber(param1,param2);
         }
         return _loc4_;
      }
      
      protected function getSpriteAssetNameWithoutFrame(param1:int, param2:int, param3:Boolean) : String
      {
         var _loc7_:String = null;
         var _loc4_:int = param3 ? UnknownVarFromFurnitureVisualization_Int_1 : getSize(param1);
         var _loc5_:* = _loc4_ == 1;
         if(param2 != UnknownVarFromFurnitureVisualization_Int_4)
         {
            _loc7_ = FurnitureVisualizationData.LAYER_NAMES[param2];
         }
         else
         {
            _loc7_ = "sd";
         }
         if(_loc5_)
         {
            return _type + "_icon_" + _loc7_;
         }
         UnknownVarFromFurnitureVisualization_Array_1[0] = _type;
         UnknownVarFromFurnitureVisualization_Array_1[2] = _loc4_;
         UnknownVarFromFurnitureVisualization_Array_1[4] = _loc7_;
         UnknownVarFromFurnitureVisualization_Array_1[6] = _direction;
         UnknownVarFromFurnitureVisualization_StringBuffer_1.length = 0;
         UnknownVarFromFurnitureVisualization_StringBuffer_1.appendStringArray(UnknownVarFromFurnitureVisualization_Array_1);
         var _loc6_:String = UnknownVarFromFurnitureVisualization_StringBuffer_1.toString();
         if(param3)
         {
            _assetNames[param2] = _loc6_;
            _assetNamesFrame[param2] = !_loc5_;
         }
         return _loc6_;
      }
      
      protected function getSpriteTag(param1:int, param2:int, param3:int) : String
      {
         if(UnknownVarFromFurnitureVisualization_Array_2[param3] != null)
         {
            return UnknownVarFromFurnitureVisualization_Array_2[param3];
         }
         if(_data == null)
         {
            return "";
         }
         var _loc4_:String = _data.getTag(param1,param2,param3);
         UnknownVarFromFurnitureVisualization_Array_2[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteFilters(param1:int, param2:int, param3:int) : Array
      {
         return null;
      }
      
      protected function getSpriteAlpha(param1:int, param2:int, param3:int) : int
      {
         if(UnknownVarFromFurnitureVisualization_Array_3[param3] != null && !UnknownVarFromFurnitureVisualization_Boolean_2)
         {
            return UnknownVarFromFurnitureVisualization_Array_3[param3];
         }
         if(_data == null)
         {
            return 255;
         }
         var _loc4_:int = _data.getAlpha(param1,param2,param3);
         _loc4_ = _loc4_ * UnknownVarFromFurnitureVisualization_Number_2;
         UnknownVarFromFurnitureVisualization_Array_3[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteColor(param1:int, param2:int, param3:int) : int
      {
         if(_spriteColors[param2] != null)
         {
            return _spriteColors[param2];
         }
         if(_data == null)
         {
            return 16777215;
         }
         var _loc4_:int = _data.getColor(param1,param2,param3);
         _spriteColors[param2] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         if(UnknownVarFromFurnitureVisualization_Array_4[param3] != null)
         {
            return UnknownVarFromFurnitureVisualization_Array_4[param3];
         }
         if(_data == null)
         {
            return 0;
         }
         var _loc4_:int = _data.getXOffset(param1,param2,param3);
         UnknownVarFromFurnitureVisualization_Array_4[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         if(param3 != UnknownVarFromFurnitureVisualization_Int_4)
         {
            if(UnknownVarFromFurnitureVisualization_Array_5[param3] != null)
            {
               return UnknownVarFromFurnitureVisualization_Array_5[param3];
            }
            if(_data != null)
            {
               _loc4_ = _data.getYOffset(param1,param2,param3);
               UnknownVarFromFurnitureVisualization_Array_5[param3] = _loc4_;
               return _loc4_;
            }
            return 0;
         }
         return Math.ceil(UnknownVarFromFurnitureVisualization_Number_4 * (param1 / 2));
      }
      
      protected function getSpriteMouseCapture(param1:int, param2:int, param3:int) : Boolean
      {
         if(_spriteMouseCaptures[param3] != null)
         {
            return _spriteMouseCaptures[param3];
         }
         if(_data == null)
         {
            return true;
         }
         var _loc4_:* = !_data.getIgnoreMouse(param1,param2,param3);
         _spriteMouseCaptures[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteInk(param1:int, param2:int, param3:int) : int
      {
         if(UnknownVarFromFurnitureVisualization_Array_7[param3] != null)
         {
            return UnknownVarFromFurnitureVisualization_Array_7[param3];
         }
         if(_data == null)
         {
            return 0;
         }
         var _loc4_:int = _data.getInk(param1,param2,param3);
         UnknownVarFromFurnitureVisualization_Array_7[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteZOffset(param1:int, param2:int, param3:int) : Number
      {
         if(UnknownVarFromFurnitureVisualization_Array_6[param3] != null)
         {
            return UnknownVarFromFurnitureVisualization_Array_6[param3];
         }
         if(_data == null)
         {
            return 0;
         }
         var _loc4_:Number = _data.getZOffset(param1,param2,param3);
         UnknownVarFromFurnitureVisualization_Array_6[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteFlipH(param1:int, param2:int, param3:int) : Boolean
      {
         return false;
      }
      
      protected function getSize(param1:int) : int
      {
         if(_data != null)
         {
            return _data.getSize(param1);
         }
         return param1;
      }
      
      protected function get data() : FurnitureVisualizationData
      {
         return _data;
      }
      
      public function set lookThrough(param1:Boolean) : *
      {
         if(UnknownVarFromFurnitureVisualization_Boolean_3 != param1)
         {
            UnknownVarFromFurnitureVisualization_Boolean_4 = true;
            UnknownVarFromFurnitureVisualization_Boolean_3 = param1;
         }
      }
      
      public function set filters(param1:Array) : *
      {
         _filters = param1;
         UnknownVarFromFurnitureVisualization_Boolean_5 = true;
      }
      
      public function get filters() : Array
      {
         return _filters;
      }
   }
}


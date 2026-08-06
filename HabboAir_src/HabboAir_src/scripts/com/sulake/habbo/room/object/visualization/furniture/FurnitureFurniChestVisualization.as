package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.visualization.utils.GraphicAsset;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.filters.GlowFilter;
   
   public class FurnitureFurniChestVisualization extends FurnitureChestVisualization
   {
      private static const FLOATING_ICON_TAG_PREFIX:String = "floating_icon_";
      
      private static const UnknownConstFromFurnitureFurniChestVisualization_Int_1:int = 4;
      
      private static const FLOATING_PIXELS:int = 2;
      
      private static const UnknownConstFromFurnitureFurniChestVisualization_Int_2:int = 1200;
      
      private static const INDIVIDUAL_FLOATING_ENABLED:Boolean = false;
      
      private static const FLOATING_ICON_GLOW_FILTER:Array = [new GlowFilter(16777215,1,2,2,10,1,false,false)];
      
      private static const ICON_POSITIONING:Array = [[],[[0,-68,17,17]],[[16,-70,4,4],[-14,-59,4,4]],[[12,-52,2,2],[-17,-70,3,2],[17,-87,7,2]],[[14,-50,2,2],[-14,-59,2,2],[19,-78,4,2],[-20,-90,4,2]]];
      
      private var UnknownVarFromFurnitureFurniChestVisualization_Vector_1:Vector.<GraphicAsset> = null;
      
      private var _lastAssetsStr:String = "";
      
      private var _assetNames:Array = [];
      
      private var UnknownVarFromFurnitureFurniChestVisualization_Boolean_1:Boolean = false;
      
      private var UnknownVarFromFurnitureFurniChestVisualization_Array_1:Array = [];
      
      private var UnknownVarFromFurnitureFurniChestVisualization_Int_1:int = 0;
      
      private var _lastFloatUpdate:int = -1;
      
      public function FurnitureFurniChestVisualization()
      {
         super();
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc3_:Boolean = super.updateModel(param1);
         var _loc2_:String = object.getModel().getString("furniture_furni_chest_shown_asset_names");
         if(_loc2_ == null || param1 != 64)
         {
            _loc2_ = "";
         }
         if(_lastAssetsStr != _loc2_)
         {
            _lastAssetsStr = _loc2_;
            if(_lastAssetsStr.length == 0)
            {
               _assetNames = [];
            }
            else
            {
               _assetNames = _lastAssetsStr.split(",");
            }
            createIconAssets();
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      override protected function updateObject(param1:Number, param2:Number) : Boolean
      {
         var _loc5_:Boolean = super.updateObject(param1,param2);
         var _loc3_:int = _lastUpdateTime - _lastFloatUpdate;
         var _loc4_:int = 300;
         if(_loc3_ > _loc4_)
         {
            _loc5_ = true;
            _lastFloatUpdate = _lastUpdateTime;
            UnknownVarFromFurnitureFurniChestVisualization_Int_1 += 1;
            if(UnknownVarFromFurnitureFurniChestVisualization_Int_1 >= 2 * 2)
            {
               UnknownVarFromFurnitureFurniChestVisualization_Int_1 = 0;
            }
         }
         return _loc5_;
      }
      
      override protected function getAdditionalSpriteCount(param1:Number) : int
      {
         return super.getAdditionalSpriteCount(param1) + 4;
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         if(!isFloatingIcon(param2) || param1 != 64)
         {
            return super.getSpriteAssetName(param1,param2);
         }
         var _loc3_:int = param2 - spriteCount + 4;
         if(_loc3_ < 0 || _loc3_ >= _assetNames.length)
         {
            return super.getSpriteAssetName(param1,param2);
         }
         return _assetNames[_loc3_];
      }
      
      private function isFloatingIcon(param1:int) : Boolean
      {
         var _loc2_:int = param1 - spriteCount + 4;
         return _loc2_ >= 0 && _loc2_ < UnknownVarFromFurnitureFurniChestVisualization_Array_1.length;
      }
      
      override protected function reset() : void
      {
         super.reset();
         clearIconAssets();
      }
      
      override protected function createSprites(param1:int) : void
      {
         super.createSprites(param1);
      }
      
      private function clearIconAssets() : void
      {
         UnknownVarFromFurnitureFurniChestVisualization_Vector_1 = null;
      }
      
      private function createIconAssets() : void
      {
         var _loc5_:int = 0;
         var _loc8_:String = null;
         var _loc11_:IGraphicAsset = null;
         var _loc6_:Array = null;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc12_:* = false;
         var _loc9_:int = 0;
         var _loc13_:int = 0;
         var _loc7_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc4_:int = 0;
         if(UnknownVarFromFurnitureFurniChestVisualization_Vector_1 != null)
         {
            clearIconAssets();
         }
         UnknownVarFromFurnitureFurniChestVisualization_Vector_1 = new Vector.<GraphicAsset>();
         UnknownVarFromFurnitureFurniChestVisualization_Array_1 = [];
         UnknownVarFromFurnitureFurniChestVisualization_Boolean_1 = Math.random() < 0.5;
         UnknownVarFromFurnitureFurniChestVisualization_Int_1 = 0;
         _lastFloatUpdate = _lastUpdateTime;
         var _loc3_:int = Math.min(4,_assetNames.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc8_ = getSpriteAssetName(64,spriteCount - 4 + _loc5_);
            _loc11_ = assetCollection.getAsset(_loc8_);
            UnknownVarFromFurnitureFurniChestVisualization_Vector_1.push(_loc11_);
            _loc6_ = ICON_POSITIONING[_loc3_][_loc5_];
            _loc2_ = _loc6_[0] + Math.random() * (_loc6_[2] + 1) - _loc6_[2] / 2;
            _loc1_ = _loc6_[1] + Math.random() * (_loc6_[3] + 1) - _loc6_[3] / 2;
            _loc12_ = Math.random() < 0.5;
            _loc9_ = _loc11_?.width;
            _loc13_ = _loc11_?.height;
            _loc7_ = calculateAlphaForYOffset(_loc1_);
            _loc10_ = 0.001 + _loc1_ / 10000;
            _loc4_ = 0;
            UnknownVarFromFurnitureFurniChestVisualization_Array_1.push([_loc2_,_loc1_,_loc12_,_loc9_,_loc13_,_loc7_,_loc10_,_loc4_]);
            _loc5_ += 1;
         }
      }
      
      private function calculateAlphaForYOffset(param1:int) : Number
      {
         var _loc5_:Number = -40;
         var _loc2_:Number = -100;
         var _loc4_:Number = (param1 - _loc5_) / (_loc2_ - _loc5_);
         var _loc7_:Number = 0.9;
         var _loc6_:Number = 0.4;
         var _loc3_:Number = _loc7_ + (_loc6_ - _loc7_) * _loc4_;
         _loc3_ = Math.max(_loc3_,_loc6_);
         return Math.min(_loc3_,_loc7_);
      }
      
      override protected function getAsset(param1:String, param2:int = -1) : IGraphicAsset
      {
         var _loc3_:int = 0;
         if(isFloatingIcon(param2))
         {
            _loc3_ = param2 - spriteCount + 4;
            if(UnknownVarFromFurnitureFurniChestVisualization_Vector_1 == null)
            {
               createIconAssets();
            }
            if(_loc3_ < UnknownVarFromFurnitureFurniChestVisualization_Vector_1.length && UnknownVarFromFurnitureFurniChestVisualization_Vector_1[_loc3_] != null)
            {
               return UnknownVarFromFurnitureFurniChestVisualization_Vector_1[_loc3_];
            }
         }
         return super.getAsset(param1,param2);
      }
      
      override protected function getSpriteTag(param1:int, param2:int, param3:int) : String
      {
         if(isFloatingIcon(param3))
         {
            return "floating_icon_" + (param3 - spriteCount + 4);
         }
         return super.getSpriteTag(param1,param2,param3);
      }
      
      override protected function getSpriteAlpha(param1:int, param2:int, param3:int) : int
      {
         var _loc6_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = super.getSpriteAlpha(param1,param2,param3);
         if(isFloatingIcon(param3))
         {
            _loc6_ = param3 - spriteCount + 4;
            _loc4_ = Number(UnknownVarFromFurnitureFurniChestVisualization_Array_1[_loc6_][5]);
            return _loc4_ * _loc5_;
         }
         return _loc5_;
      }
      
      override protected function getSpriteColor(param1:int, param2:int, param3:int) : int
      {
         return super.getSpriteColor(param1,param2,param3);
      }
      
      override protected function getSpriteMouseCapture(param1:int, param2:int, param3:int) : Boolean
      {
         if(isFloatingIcon(param3))
         {
            return false;
         }
         return super.getSpriteMouseCapture(param1,param2,param3);
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc7_:int = 0;
         var _loc6_:* = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(isFloatingIcon(param3))
         {
            _loc7_ = param3 - spriteCount + 4;
            _loc6_ = param2 / 2 % 2 == 1;
            _loc4_ = int(UnknownVarFromFurnitureFurniChestVisualization_Array_1[_loc7_][0]);
            _loc5_ = int(UnknownVarFromFurnitureFurniChestVisualization_Array_1[_loc7_][3]);
            if(UnknownVarFromFurnitureFurniChestVisualization_Boolean_1 != _loc6_)
            {
               _loc4_ = -_loc4_;
            }
            return _loc4_ - _loc5_ / 2;
         }
         return super.getSpriteXOffset(param1,param2,param3);
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(isFloatingIcon(param3))
         {
            _loc7_ = param3 - spriteCount + 4;
            _loc5_ = int(UnknownVarFromFurnitureFurniChestVisualization_Array_1[_loc7_][1]);
            _loc8_ = int(UnknownVarFromFurnitureFurniChestVisualization_Array_1[_loc7_][4]);
            _loc6_ = int(UnknownVarFromFurnitureFurniChestVisualization_Array_1[_loc7_][7]);
            _loc4_ = (UnknownVarFromFurnitureFurniChestVisualization_Int_1 + _loc6_) % (2 * 2);
            if(_loc4_ > 2)
            {
               _loc4_ = 2 - (_loc4_ - 2);
            }
            return _loc5_ + _loc8_ / 2 - _loc4_;
         }
         return super.getSpriteYOffset(param1,param2,param3);
      }
      
      override protected function getSpriteZOffset(param1:int, param2:int, param3:int) : Number
      {
         var _loc5_:int = 0;
         var _loc4_:Number = NaN;
         if(isFloatingIcon(param3))
         {
            _loc5_ = param3 - spriteCount + 4;
            return Number(UnknownVarFromFurnitureFurniChestVisualization_Array_1[_loc5_][6]);
         }
         return super.getSpriteZOffset(param1,param2,param3);
      }
      
      override protected function getSpriteInk(param1:int, param2:int, param3:int) : int
      {
         if(isFloatingIcon(param3))
         {
            return 0;
         }
         return super.getSpriteInk(param1,param2,param3);
      }
      
      override protected function getSpriteFilters(param1:int, param2:int, param3:int) : Array
      {
         if(isFloatingIcon(param3))
         {
            return FLOATING_ICON_GLOW_FILTER;
         }
         return super.getSpriteFilters(param1,param2,param3);
      }
      
      override protected function getSpriteFlipH(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:* = false;
         var _loc4_:int = 0;
         if(isFloatingIcon(param3))
         {
            _loc6_ = param3 - spriteCount + 4;
            _loc5_ = param2 / 2 % 2 == 1;
            _loc4_ = int(UnknownVarFromFurnitureFurniChestVisualization_Array_1[_loc6_][2]);
            return UnknownVarFromFurnitureFurniChestVisualization_Boolean_1 != _loc5_ != _loc4_;
         }
         return super.getSpriteFlipH(param1,param2,param3);
      }
   }
}


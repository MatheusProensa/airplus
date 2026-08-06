package com.sulake.habbo.room.object.visualization.pet
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.habbo.room.object.visualization.data.AnimationSizeData;
   import com.sulake.habbo.room.object.visualization.data.SizeData;
   import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualizationData;
   
   public class AnimatedPetVisualizationData extends AnimatedFurnitureVisualizationData
   {
      private var _commonAssets:IAssetLibraryCollection = null;
      
      private var _isAllowedToTurnHead:Boolean = true;
      
      public function AnimatedPetVisualizationData()
      {
         super();
      }
      
      public function set commonAssets(param1:IAssetLibraryCollection) : void
      {
         _commonAssets = param1;
      }
      
      public function get commonAssets() : IAssetLibraryCollection
      {
         return _commonAssets;
      }
      
      override protected function defineVisualizations(param1:XML) : Boolean
      {
         _isAllowedToTurnHead = !!param1.graphics.hasOwnProperty("@disableheadturn") ? param1.graphics.@disableheadturn != "1" : true;
         return super.defineVisualizations(param1);
      }
      
      override protected function createSizeData(param1:int, param2:int, param3:int) : SizeData
      {
         var _loc4_:SizeData = null;
         if(param1 > 1)
         {
            _loc4_ = new PetAnimationSizeData(param2,param3);
         }
         else
         {
            _loc4_ = new AnimationSizeData(param2,param3);
         }
         return _loc4_;
      }
      
      override protected function processVisualizationElement(param1:SizeData, param2:XML) : Boolean
      {
         var _loc3_:PetAnimationSizeData = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         switch(String(param2.name()))
         {
            case "postures":
               _loc3_ = param1 as PetAnimationSizeData;
               if(_loc3_ != null)
               {
                  if(!_loc3_.definePostures(param2))
                  {
                     return false;
                  }
               }
               break;
            case "gestures":
               _loc3_ = param1 as PetAnimationSizeData;
               if(_loc3_ != null)
               {
                  if(!_loc3_.defineGestures(param2))
                  {
                     return false;
                  }
               }
               break;
            default:
               if(!super.processVisualizationElement(param1,param2))
               {
                  return false;
               }
               break;
         }
         return true;
      }
      
      public function getAnimationForPosture(param1:int, param2:String) : int
      {
         var _loc3_:PetAnimationSizeData = getSizeData(param1) as PetAnimationSizeData;
         if(_loc3_ != null)
         {
            return _loc3_.getAnimationForPosture(param2);
         }
         return -1;
      }
      
      public function getGestureDisabled(param1:int, param2:String) : Boolean
      {
         var _loc3_:PetAnimationSizeData = getSizeData(param1) as PetAnimationSizeData;
         if(_loc3_ != null)
         {
            return _loc3_.getGestureDisabled(param2);
         }
         return false;
      }
      
      public function getAnimationForGesture(param1:int, param2:String) : int
      {
         var _loc3_:PetAnimationSizeData = getSizeData(param1) as PetAnimationSizeData;
         if(_loc3_ != null)
         {
            return _loc3_.getAnimationForGesture(param2);
         }
         return -1;
      }
      
      public function getPostureForAnimation(param1:int, param2:int, param3:Boolean) : String
      {
         var _loc4_:PetAnimationSizeData = getSizeData(param1) as PetAnimationSizeData;
         if(_loc4_ != null)
         {
            return _loc4_.getPostureForAnimation(param2,param3);
         }
         return null;
      }
      
      public function getGestureForAnimation(param1:int, param2:int) : String
      {
         var _loc3_:PetAnimationSizeData = getSizeData(param1) as PetAnimationSizeData;
         if(_loc3_ != null)
         {
            return _loc3_.getGestureForAnimation(param2);
         }
         return null;
      }
      
      public function getGestureForAnimationId(param1:int, param2:int) : String
      {
         var _loc3_:PetAnimationSizeData = getSizeData(param1) as PetAnimationSizeData;
         return _loc3_ == null ? null : _loc3_.getGestureForAnimationId(param2);
      }
      
      public function getPostureCount(param1:int) : int
      {
         var _loc2_:PetAnimationSizeData = getSizeData(param1) as PetAnimationSizeData;
         if(_loc2_ != null)
         {
            return _loc2_.getPostureCount();
         }
         return 0;
      }
      
      public function getGestureCount(param1:int) : int
      {
         var _loc2_:PetAnimationSizeData = getSizeData(param1) as PetAnimationSizeData;
         if(_loc2_ != null)
         {
            return _loc2_.getGestureCount();
         }
         return 0;
      }
      
      public function get isAllowedToTurnHead() : Boolean
      {
         return _isAllowedToTurnHead;
      }
   }
}


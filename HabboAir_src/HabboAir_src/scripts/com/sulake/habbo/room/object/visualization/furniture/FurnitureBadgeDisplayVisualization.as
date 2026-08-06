package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   
   public class FurnitureBadgeDisplayVisualization extends AnimatedFurnitureVisualization
   {
      private static const BADGE_SPRITE_TAG:String = "BADGE";
      
      private var UnknownVarFromFurnitureBadgeDisplayVisualization_String_1:String = "";
      
      private var UnknownVarFromFurnitureBadgeDisplayVisualization_String_2:String = "";
      
      private var UnknownVarFromFurnitureBadgeDisplayVisualization_Int_1:int = -1;
      
      public function FurnitureBadgeDisplayVisualization()
      {
         super();
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc2_:* = false;
         var _loc3_:Boolean = super.updateModel(param1);
         if(!isNaN(object.getModel().getNumber("furniture_badge_image_status")))
         {
            _loc2_ = object.getModel().getNumber("furniture_badge_image_status") != 0;
            if(_loc2_ && UnknownVarFromFurnitureBadgeDisplayVisualization_String_1 == "")
            {
               UnknownVarFromFurnitureBadgeDisplayVisualization_String_1 = object.getModel().getString("furniture_badge_asset_name");
               if(UnknownVarFromFurnitureBadgeDisplayVisualization_String_2 == "")
               {
                  UnknownVarFromFurnitureBadgeDisplayVisualization_String_2 = UnknownVarFromFurnitureBadgeDisplayVisualization_String_1 + "_32";
               }
               if(object.getModel().hasNumber("furniture_badge_visible_in_state"))
               {
                  UnknownVarFromFurnitureBadgeDisplayVisualization_Int_1 = object.getModel().getNumber("furniture_badge_visible_in_state");
               }
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         var _loc3_:String = getSpriteTag(param1,direction,param2);
         if(_loc3_ != "BADGE" || UnknownVarFromFurnitureBadgeDisplayVisualization_Int_1 != -1 && object.getState(0) != UnknownVarFromFurnitureBadgeDisplayVisualization_Int_1)
         {
            return super.getSpriteAssetName(param1,param2);
         }
         if(param1 == 32)
         {
            return UnknownVarFromFurnitureBadgeDisplayVisualization_String_2;
         }
         return UnknownVarFromFurnitureBadgeDisplayVisualization_String_1;
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc5_:IGraphicAsset = null;
         var _loc4_:int = super.getSpriteXOffset(param1,param2,param3);
         if(getSpriteTag(param1,param2,param3) == "BADGE")
         {
            _loc5_ = getAsset(param1 == 32 ? UnknownVarFromFurnitureBadgeDisplayVisualization_String_2 : UnknownVarFromFurnitureBadgeDisplayVisualization_String_1,param3);
            if(param1 == 64)
            {
               _loc4_ += (40 - _loc5_.width) / 2;
               if(param2 == 2 && (type == "china_c24_resolution1" || type == "china_c24_resolution2"))
               {
                  _loc4_ -= 40;
               }
            }
            else
            {
               _loc4_ += (20 - _loc5_.width) / 2;
            }
         }
         return _loc4_;
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc5_:IGraphicAsset = null;
         var _loc4_:int = super.getSpriteYOffset(param1,param2,param3);
         if(getSpriteTag(param1,param2,param3) == "BADGE")
         {
            _loc5_ = getAsset(param1 == 32 ? UnknownVarFromFurnitureBadgeDisplayVisualization_String_2 : UnknownVarFromFurnitureBadgeDisplayVisualization_String_1,param3);
            if(param1 == 64)
            {
               _loc4_ += (40 - _loc5_.height) / 2;
            }
            else
            {
               _loc4_ += (20 - _loc5_.height) / 2;
            }
         }
         return _loc4_;
      }
      
      override protected function getLibraryAssetNameForSprite(param1:IGraphicAsset, param2:IRoomObjectSprite) : String
      {
         if(param2.tag == "BADGE")
         {
            return "%image.library.url%album1584/" + param2.assetName.replace("badge_","") + ".png";
         }
         return super.getLibraryAssetNameForSprite(param1,param2);
      }
   }
}


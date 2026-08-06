package com.sulake.habbo.inventory.furni
{
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   
   public class InventoryFilterTypeHelper
   {
      public static const MAIN_ALL:String = "all";
      
      public static const MAIN_FLOOR_ITEMS:String = "floor_items";
      
      public static const MAIN_WALL_ITEMS:String = "wall_items";
      
      public static const MAIN_ROOM_LAYOUT:String = "room_layout";
      
      public static const UnknownConstFromInventoryFilterTypeHelper_String_1:String = "any";
      
      public static const UnknownConstFromInventoryFilterTypeHelper_String_2:String = "sittable";
      
      public static const UnknownConstFromInventoryFilterTypeHelper_String_3:String = "layable";
      
      public static const UnknownConstFromInventoryFilterTypeHelper_String_4:String = "tiles_or_rugs";
      
      public static const TYPE_LTD:String = "ltd";
      
      public static const UnknownConstFromInventoryFilterTypeHelper_String_5:String = "wired";
      
      public static const TYPE_CREDIT_FURNI:String = "credit_furni";
      
      public static const TYPE_CLOTHES:String = "clothes";
      
      public static const UnknownConstFromInventoryFilterTypeHelper_String_6:String = "pet_food";
      
      public static const TYPE_COLLECTIBLES:String = "collectibles";
      
      public static const UnknownConstFromInventoryFilterTypeHelper_String_7:String = "tradable";
      
      public static const UnknownConstFromInventoryFilterTypeHelper_String_8:String = "non_tradable";
      
      public static const UnknownConstFromInventoryFilterTypeHelper_String_9:String = "recyclable";
      
      public static const TYPE_WINDOWS:String = "windows";
      
      public static const TYPE_DIMMERS:String = "dimmers";
      
      public static const TYPE_STICKIES:String = "stickies";
      
      public static const UnknownConstFromInventoryFilterTypeHelper_String_10:String = "paintings";
      
      public static const TYPE_FLOORS:String = "floors";
      
      public static const TYPE_WALLPAPERS:String = "wallpapers";
      
      public static const TYPE_LANDSCAPE:String = "landscape";
      
      public function InventoryFilterTypeHelper()
      {
         super();
      }
      
      public static function isRoomLayout(param1:GroupItem) : Boolean
      {
         return hasCategory(param1,2,3,4);
      }
      
      public static function isWallpaper(param1:GroupItem) : Boolean
      {
         return hasCategory(param1,2);
      }
      
      public static function isFloor(param1:GroupItem) : Boolean
      {
         return hasCategory(param1,3);
      }
      
      public static function isLandscape(param1:GroupItem) : Boolean
      {
         return hasCategory(param1,4);
      }
      
      public static function isSittable(param1:GroupItem) : Boolean
      {
         var _loc2_:IFurnitureData = getFurnitureData(param1);
         return _loc2_ != null && _loc2_.canSitOn;
      }
      
      public static function isLayable(param1:GroupItem) : Boolean
      {
         var _loc2_:IFurnitureData = getFurnitureData(param1);
         return _loc2_ != null && _loc2_.canLayOn;
      }
      
      public static function isTilesOrRugs(param1:GroupItem) : Boolean
      {
         var _loc2_:IFurnitureData = getFurnitureData(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         if(_loc2_.className.startsWith("tile_walkmagic") || _loc2_.className == "hole")
         {
            return false;
         }
         if(!_loc2_.canPutStuffOn)
         {
            return false;
         }
         if(_loc2_.furniDataCategory == "rug" || _loc2_.furniDataCategory == "floor")
         {
            return true;
         }
         var _loc3_:String = _loc2_.className;
         if(_loc3_.startsWith("carpet"))
         {
            return true;
         }
         if(_loc2_.height > 0.2 || !_loc2_.canStandOn || _loc2_.tileSizeX <= 1 || _loc2_.tileSizeY <= 1)
         {
            return false;
         }
         return true;
      }
      
      public static function isLtd(param1:GroupItem) : Boolean
      {
         var _loc2_:FurnitureItem = getFurnitureItem(param1);
         return _loc2_ != null && _loc2_.stuffData != null && _loc2_.stuffData.uniqueSerialNumber > 0;
      }
      
      public static function isWired(param1:GroupItem) : Boolean
      {
         var _loc2_:IFurnitureData = getFurnitureData(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return _loc2_.className.startsWith("wf_") || Boolean(_loc2_.furniDataCategory.startsWith("wired_"));
      }
      
      public static function isCreditFurni(param1:GroupItem) : Boolean
      {
         return hasCategory(param1,12) || Boolean(getClassName(param1).startsWith("CF_"));
      }
      
      public static function isClothes(param1:GroupItem) : Boolean
      {
         return hasCategory(param1,23);
      }
      
      public static function isPetFood(param1:GroupItem) : Boolean
      {
         var _loc2_:IFurnitureData = getFurnitureData(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return _loc2_.className.startsWith("petfood") || _loc2_.furniLine == "pet_food";
      }
      
      public static function isCollectible(param1:GroupItem) : Boolean
      {
         return param1 != null && param1.isNft();
      }
      
      public static function isTradable(param1:GroupItem) : Boolean
      {
         var _loc2_:IFurnitureData = getFurnitureData(param1);
         return _loc2_ != null && _loc2_.tradeable;
      }
      
      public static function isNonTradable(param1:GroupItem) : Boolean
      {
         var _loc2_:IFurnitureData = getFurnitureData(param1);
         return _loc2_ != null && !_loc2_.tradeable;
      }
      
      public static function isRecyclable(param1:GroupItem) : Boolean
      {
         var _loc2_:FurnitureItem = getFurnitureItem(param1);
         return _loc2_ != null && _loc2_.recyclable;
      }
      
      public static function isWindow(param1:GroupItem) : Boolean
      {
         var _loc2_:IFurnitureData = getFurnitureData(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return _loc2_.className.startsWith("window_") || _loc2_.furniLine == "windows" || _loc2_.furniDataCategory == "window";
      }
      
      public static function isDimmer(param1:GroupItem) : Boolean
      {
         var _loc2_:IFurnitureData = getFurnitureData(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return _loc2_.className.startsWith("dimmer_") || _loc2_.furniDataCategory == "dimmer" || _loc2_.furniLine == "dimmers";
      }
      
      public static function isStickie(param1:GroupItem) : Boolean
      {
         return hasCategory(param1,5);
      }
      
      public static function isPainting(param1:GroupItem) : Boolean
      {
         return getClassName(param1).startsWith("diamond_painting");
      }
      
      private static function getFurnitureData(param1:GroupItem) : IFurnitureData
      {
         return param1 != null ? param1.furniData : null;
      }
      
      private static function getClassName(param1:GroupItem) : String
      {
         return param1 != null ? param1.className : "";
      }
      
      private static function getFurnitureItem(param1:GroupItem) : FurnitureItem
      {
         return param1 != null ? param1.peek() : null;
      }
      
      private static function hasCategory(param1:GroupItem, ... rest) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         for each(var _loc3_ in rest)
         {
            if(param1.category == _loc3_)
            {
               return true;
            }
         }
         return false;
      }
   }
}


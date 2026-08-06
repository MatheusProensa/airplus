package com.sulake.habbo.catalog.habbicons
{
   public class HabbiconAlbumModel
   {
      public var sets:Vector.<HabbiconSetModel> = new Vector.<HabbiconSetModel>(0);
      
      public var UnknownVarFromHabbiconAlbumModel_Vector_1:Vector.<HabbiconSetModel> = new Vector.<HabbiconSetModel>(0);
      
      public var favouriteGroups:Vector.<HabbiconSetModel> = new Vector.<HabbiconSetModel>(0);
      
      public var UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1:HabbiconAlbumStats = new HabbiconAlbumStats();
      
      public function HabbiconAlbumModel()
      {
         super();
      }
      
      public function findSetById(param1:String) : HabbiconSetModel
      {
         for each(var _loc2_ in sets)
         {
            if(_loc2_ != null && _loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function findSetByCollectionId(param1:int) : HabbiconSetModel
      {
         for each(var _loc2_ in sets)
         {
            if(_loc2_ != null && _loc2_.collectionId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function findEntryByHabbiconId(param1:int) : HabbiconEntryModel
      {
         var _loc2_:* = null;
         for each(var _loc3_ in sets)
         {
            if(_loc3_ != null)
            {
               for each(_loc2_ in _loc3_.habbicons)
               {
                  if(_loc2_ != null && _loc2_.habbiconId == param1)
                  {
                     return _loc2_;
                  }
               }
               if(_loc3_.rewardHabbicon != null && _loc3_.rewardHabbicon.habbiconId == param1)
               {
                  return _loc3_.rewardHabbicon;
               }
            }
         }
         return null;
      }
   }
}


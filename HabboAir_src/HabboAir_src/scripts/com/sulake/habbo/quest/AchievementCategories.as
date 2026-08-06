package com.sulake.habbo.quest
{
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
   import flash.utils.Dictionary;
   
   public class AchievementCategories
   {
      private static const ACHIEVEMENT_DISABLED:int = 0;
      
      private static const ACHIEVEMENT_ENABLED:int = 1;
      
      private static const ACHIEVEMENT_ARCHIVED:int = 2;
      
      private static const ACHIEVEMENT_OFF_SEASON:int = 3;
      
      private static const ACHIEVEMENT_CONTROL_BY_WIRED:int = 4;
      
      public static const ACHIEVEMENT_CATEGORY_ARCHIVED:String = "archive";
      
      public static const ACHIEVEMENT_CATEGORY_NEW:String = "new";
      
      public static const ACHIEVEMENT_CATEGORY_WIRED_GAMES:String = "wired_games";
      
      private var UnknownVarFromAchievementCategories_Dictionary_1:Dictionary;
      
      private var _categoryList:Vector.<AchievementCategory>;
      
      private var _questEngine:HabboQuestEngine;
      
      public function AchievementCategories(param1:Array, param2:HabboQuestEngine)
      {
         var _loc7_:* = null;
         var _loc9_:AchievementCategory = null;
         var _loc5_:* = null;
         UnknownVarFromAchievementCategories_Dictionary_1 = new Dictionary();
         _categoryList = new Vector.<AchievementCategory>(0);
         super();
         _questEngine = param2;
         var _loc3_:AchievementCategory = new AchievementCategory("archive");
         UnknownVarFromAchievementCategories_Dictionary_1["archive"] = _loc3_;
         var _loc4_:AchievementCategory = new AchievementCategory("wired_games");
         UnknownVarFromAchievementCategories_Dictionary_1["wired_games"] = _loc4_;
         var _loc6_:Vector.<AchievementData> = new Vector.<AchievementData>();
         var _loc8_:Vector.<String> = getNewAchievementCodes();
         for each(_loc5_ in param1)
         {
            if(_loc5_.category != "")
            {
               if(!(_loc5_.state == 4 && _loc5_.category != "wired_games"))
               {
                  if(_loc5_.state == 2)
                  {
                     _loc9_ = UnknownVarFromAchievementCategories_Dictionary_1["archive"];
                  }
                  else
                  {
                     _loc9_ = UnknownVarFromAchievementCategories_Dictionary_1[_loc5_.category];
                  }
                  if(_loc9_ == null)
                  {
                     _loc9_ = new AchievementCategory(_loc5_.category);
                     UnknownVarFromAchievementCategories_Dictionary_1[_loc5_.category] = _loc9_;
                     if(_loc5_.category != "misc")
                     {
                        _categoryList.push(_loc9_);
                     }
                     else
                     {
                        _loc7_ = _loc9_;
                     }
                  }
                  _loc9_.add(_loc5_);
                  if(achievementIsNew(_loc8_,_loc5_))
                  {
                     _loc6_.push(_loc5_);
                  }
               }
            }
         }
         if(_loc7_ != null)
         {
            _categoryList.push(_loc7_);
         }
         _categoryList.push(_loc3_);
         _categoryList.push(_loc4_);
         if(_loc6_.length > 0)
         {
            _loc9_ = new AchievementCategory("new");
            UnknownVarFromAchievementCategories_Dictionary_1["new"] = _loc9_;
            _categoryList.push(_loc9_);
            for each(_loc5_ in _loc6_)
            {
               _loc9_.add(_loc5_);
            }
         }
      }
      
      private function achievementIsNew(param1:Vector.<String>, param2:AchievementData) : Boolean
      {
         return param1.indexOf(param2.code) != -1;
      }
      
      private function getNewAchievementCodes() : Vector.<String>
      {
         var _loc2_:Vector.<String> = new Vector.<String>();
         var _loc3_:String = _questEngine.getProperty("achievements.new");
         var _loc1_:Array = _loc3_.split(",");
         for each(var _loc4_ in _loc1_)
         {
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public function update(param1:AchievementData) : void
      {
         if(param1 == null || param1.category == "")
         {
            return;
         }
         var _loc2_:AchievementCategory = UnknownVarFromAchievementCategories_Dictionary_1[param1.category];
         if(_loc2_ != null)
         {
            _loc2_.update(param1);
         }
         _loc2_ = UnknownVarFromAchievementCategories_Dictionary_1["new"];
         if(_loc2_ != null)
         {
            _loc2_.update(param1);
         }
      }
      
      public function get categoryList() : Vector.<AchievementCategory>
      {
         return _categoryList;
      }
      
      public function getMaxProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in _categoryList)
         {
            _loc1_ += _loc2_.getMaxProgress();
         }
         return _loc1_;
      }
      
      public function getProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in _categoryList)
         {
            _loc1_ += _loc2_.getProgress();
         }
         return _loc1_;
      }
      
      public function getCategoryByCode(param1:String) : AchievementCategory
      {
         for each(var _loc2_ in _categoryList)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}


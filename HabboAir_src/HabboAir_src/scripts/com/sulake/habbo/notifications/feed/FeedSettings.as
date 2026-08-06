package com.sulake.habbo.notifications.feed
{
   public class FeedSettings
   {
      public static const UnknownConstFromFeedSettings_Int_1:int = 0;
      
      public static const UnknownConstFromFeedSettings_Int_2:int = 1;
      
      public static const UnknownConstFromFeedSettings_Int_3:int = 2;
      
      public static const UnknownConstFromFeedSettings_Int_4:int = 3;
      
      public static const FEED_CATEGORY_ME:int = 0;
      
      public static const UnknownConstFromFeedSettings_Int_5:int = 1;
      
      public static const FEED_CATEGORY_HOTEL:int = 2;
      
      private var UnknownVarFromFeedSettings_NotificationController_1:NotificationController;
      
      private var _visibleFeedCategories:Vector.<int>;
      
      public function FeedSettings(param1:NotificationController)
      {
         super();
         _visibleFeedCategories = new Vector.<int>();
         _visibleFeedCategories.push(1);
         _visibleFeedCategories.push(0);
         _visibleFeedCategories.push(2);
      }
      
      public function dispose() : void
      {
         UnknownVarFromFeedSettings_NotificationController_1 = null;
         _visibleFeedCategories = null;
      }
      
      public function getVisibleFeedCategories() : Vector.<int>
      {
         return _visibleFeedCategories;
      }
      
      public function toggleVisibleFeedCategory(param1:int) : void
      {
         UnknownVarFromFeedSettings_NotificationController_1.updateFeedCategoryFiltering();
      }
   }
}


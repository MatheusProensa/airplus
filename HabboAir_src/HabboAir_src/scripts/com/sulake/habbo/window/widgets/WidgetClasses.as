package com.sulake.habbo.window.widgets
{
   import flash.utils.Dictionary;
   
   public class WidgetClasses
   {
      private static var key:String;
      
      public static var UnknownVarFromWidgetClasses_Dictionary_1:Dictionary = new Dictionary();
      
      public static var WIDGET_TYPES:Array = [];
      
      UnknownVarFromWidgetClasses_Dictionary_1["avatar_image"] = AvatarImageWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["badge_image"] = BadgeImageWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["balloon"] = BalloonWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["countdown"] = CountdownWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["chest_overlay_grid"] = ChestItemGridOverlayWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["hover_bitmap"] = HoverBitmapWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["illumina_border"] = IlluminaBorderWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["illumina_chat_bubble"] = IlluminaChatBubbleWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["illumina_input"] = IlluminaInputWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["progress_indicator"] = ProgressIndicatorWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["limited_item_overlay_grid"] = LimitedItemGridOverlayWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["limited_item_overlay_preview"] = LimitedItemPreviewOverlayWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["limited_item_overlay_supply"] = LimitedItemSupplyLeftOverlayWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["product_icon"] = ProductIconWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["product_image"] = ProductImageWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["rarity_item_overlay_grid"] = RarityItemGridOverlayWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["rarity_item_overlay_preview"] = RarityItemPreviewOverlayWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["separator"] = SeparatorWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["updating_timestamp"] = UpdatingTimeStampWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["running_number"] = RunningNumberWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["pet_image"] = PetImageWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["furniture_image"] = FurnitureImageWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["room_previewer"] = RoomPreviewerWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["pixel_limit"] = PixelLimitWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["room_thumbnail"] = RoomThumbnailWidget;
      UnknownVarFromWidgetClasses_Dictionary_1["room_user_count"] = RoomUserCountWidget;
      for(key in UnknownVarFromWidgetClasses_Dictionary_1)
      {
         WIDGET_TYPES.push(key);
      }
      WIDGET_TYPES.sort();
      
      public function WidgetClasses()
      {
         super();
      }
   }
}


package com.sulake.habbo.catalog.habbicons
{
   import flash.events.Event;
   
   public class HabbiconControllerEvent extends Event
   {
      public static const UnknownConstFromHabbiconControllerEvent_String_1:String = "hce_owned_habbicons_updated";
      
      public static const SHOP_DATA_UPDATED:String = "hce_shop_data_updated";
      
      public static const UnknownConstFromHabbiconControllerEvent_String_2:String = "hce_habbicon_status_changed";
      
      public static const RECENT_HABBICONS_UPDATED:String = "hce_recent_habbicons_updated";
      
      public static const ROOM_USE_HABBICON:String = "hce_room_use_habbicon";
      
      public var habbiconId:int;
      
      public var collectionId:int;
      
      public var roomIndex:int;
      
      public function HabbiconControllerEvent(param1:String, param2:int = 0, param3:int = 0, param4:int = 0)
      {
         super(param1);
         this.habbiconId = param2;
         this.collectionId = param3;
         this.roomIndex = param4;
      }
      
      override public function clone() : Event
      {
         return new HabbiconControllerEvent(type,habbiconId,collectionId,roomIndex);
      }
   }
}


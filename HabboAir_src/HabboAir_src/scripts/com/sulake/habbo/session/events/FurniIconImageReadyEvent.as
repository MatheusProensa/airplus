package com.sulake.habbo.session.events
{
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class FurniIconImageReadyEvent extends Event
   {
      public static const UnknownConstFromFurniIconImageReadyEvent_String_1:String = "FIIRE_ICON_READY";
      
      private var _wallItem:Boolean;
      
      private var _typeId:int;
      
      private var _extra:String;
      
      private var _assetName:String;
      
      private var _furniIconImage:BitmapData;
      
      public function FurniIconImageReadyEvent(param1:String, param2:Boolean, param3:int, param4:String, param5:BitmapData, param6:Boolean = false, param7:Boolean = false)
      {
         super("FIIRE_ICON_READY",param6,param7);
         _assetName = param1;
         _wallItem = param2;
         _typeId = param3;
         _extra = param4;
         _furniIconImage = param5;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function get wallItem() : Boolean
      {
         return _wallItem;
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
      
      public function get extra() : String
      {
         return _extra;
      }
      
      public function get furniIconImage() : BitmapData
      {
         return _furniIconImage;
      }
   }
}


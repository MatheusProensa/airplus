package com.sulake.habbo.notifications.feed.data
{
   import flash.display.BitmapData;
   
   public class GenericNotificationItemData
   {
      private var _title:String;
      
      private var _timeStamp:int;
      
      private var _description:String;
      
      private var _decorationImage:BitmapData;
      
      private var _iconImage:BitmapData;
      
      private var _buttonAction:String;
      
      private var _buttonCaption:String;
      
      public function GenericNotificationItemData()
      {
         super();
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get timeStamp() : int
      {
         return _timeStamp;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get decorationImage() : BitmapData
      {
         return _decorationImage;
      }
      
      public function get iconImage() : BitmapData
      {
         return _iconImage;
      }
      
      public function get buttonAction() : String
      {
         return _buttonAction;
      }
      
      public function get buttonCaption() : String
      {
         return _buttonCaption;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
      
      public function set timeStamp(param1:int) : void
      {
         _timeStamp = param1;
      }
      
      public function set description(param1:String) : void
      {
         _description = param1;
      }
      
      public function set decorationImage(param1:BitmapData) : void
      {
         _decorationImage = param1;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         _iconImage = param1;
      }
      
      public function set buttonAction(param1:String) : void
      {
         _buttonAction = param1;
      }
      
      public function set buttonCaption(param1:String) : void
      {
         _buttonCaption = param1;
      }
   }
}


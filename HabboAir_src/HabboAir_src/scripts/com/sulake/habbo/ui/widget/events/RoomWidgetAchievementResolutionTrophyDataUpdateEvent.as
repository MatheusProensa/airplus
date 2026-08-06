package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetAchievementResolutionTrophyDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const UPDATE_TROPHY_DATA:String = "RWARTDUE_TROPHY_DATA";
      
      private var _color:Number;
      
      private var _name:String;
      
      private var _date:String;
      
      private var _message:String;
      
      private var _viewType:int;
      
      private var _frameTitle:String;
      
      private var _headerColor:uint;
      
      private var _backgroundTheme:int;
      
      private var _backgroundColor:uint;
      
      public function RoomWidgetAchievementResolutionTrophyDataUpdateEvent(param1:String, param2:Number, param3:String, param4:String, param5:String, param6:int, param7:String = "", param8:uint = 0, param9:int = -1, param10:uint = 0, param11:Boolean = false, param12:Boolean = false)
      {
         super(param1,param11,param12);
         _color = param2;
         _name = param3;
         _date = param4;
         _message = param5;
         _viewType = param6;
         _frameTitle = param7;
         _headerColor = param8;
         _backgroundTheme = param9;
         _backgroundColor = param10;
      }
      
      public function get color() : Number
      {
         return _color;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get date() : String
      {
         return _date;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get viewType() : int
      {
         return _viewType;
      }
      
      public function get frameTitle() : String
      {
         return _frameTitle;
      }
      
      public function get headerColor() : uint
      {
         return _headerColor;
      }
      
      public function get backgroundTheme() : int
      {
         return _backgroundTheme;
      }
      
      public function get backgroundColor() : uint
      {
         return _backgroundColor;
      }
   }
}


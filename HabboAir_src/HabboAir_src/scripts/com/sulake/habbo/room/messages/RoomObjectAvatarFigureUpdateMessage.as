package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _figure:String;
      
      private var _race:String;
      
      private var _gender:String;
      
      private var _isRiding:Boolean;
      
      public function RoomObjectAvatarFigureUpdateMessage(param1:String, param2:String = null, param3:String = null, param4:Boolean = false)
      {
         super();
         _figure = param1;
         _gender = param2;
         _race = param3;
         _isRiding = param4;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get race() : String
      {
         return _race;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get isRiding() : Boolean
      {
         return _isRiding;
      }
   }
}


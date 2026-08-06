package com.sulake.habbo.game.events
{
   import flash.events.Event;
   
   public class GameChatEvent extends Event
   {
      public static const GAME_CHAT:String = "gce_game_chat";
      
      private var _userId:int;
      
      private var _message:String;
      
      private var _locX:int;
      
      private var _color:uint;
      
      private var _figure:String;
      
      private var _gender:String;
      
      private var _name:String;
      
      private var _teamId:int;
      
      private var _notify:Boolean;
      
      public function GameChatEvent(param1:String, param2:int, param3:String, param4:int, param5:uint, param6:String, param7:String, param8:String, param9:int, param10:Boolean, param11:Boolean = false, param12:Boolean = false)
      {
         super(param1,param11,param12);
         _userId = param2;
         _message = param3;
         _locX = param4;
         _color = param5;
         _figure = param6;
         _gender = param7;
         _name = param8;
         _teamId = param9;
         _notify = param10;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get locX() : int
      {
         return _locX;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get teamId() : int
      {
         return _teamId;
      }
      
      public function get notify() : Boolean
      {
         return _notify;
      }
   }
}


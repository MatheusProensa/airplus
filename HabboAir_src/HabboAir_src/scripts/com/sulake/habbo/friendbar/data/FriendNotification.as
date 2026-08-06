package com.sulake.habbo.friendbar.data
{
   public class FriendNotification implements IFriendNotification
   {
      public static const TYPE_MESSENGER:int = -1;
      
      public static const UnknownConstFromFriendNotification_Int_1:int = 0;
      
      public static const UnknownConstFromFriendNotification_Int_2:int = 1;
      
      public static const TYPE_QUEST:int = 2;
      
      public static const TYPE_PLAYING_GAME:int = 3;
      
      public static const TYPE_FINISHED_GAME:int = 4;
      
      private var _typeCode:int = -1;
      
      private var _message:String;
      
      private var _viewOnce:Boolean;
      
      public function FriendNotification(param1:int, param2:String, param3:Boolean)
      {
         super();
         this._typeCode = param1;
         this._message = param2;
         this._viewOnce = param3;
      }
      
      public static function typeCodeToString(param1:int) : String
      {
         switch(param1 - -1)
         {
            case 0:
               return "instant_message";
            case 1:
               return "room_event";
            case 2:
               return "achievement";
            case 3:
               return "quest";
            case 4:
               return "playing_game";
            case 5:
               return "finished_game";
            default:
               return "unknown";
         }
      }
      
      public function get typeCode() : int
      {
         return _typeCode;
      }
      
      public function set typeCode(param1:int) : void
      {
         _typeCode = param1;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function set message(param1:String) : void
      {
         _message = param1;
      }
      
      public function get viewOnce() : Boolean
      {
         return _viewOnce;
      }
      
      public function set viewOnce(param1:Boolean) : void
      {
         _viewOnce = param1;
      }
   }
}


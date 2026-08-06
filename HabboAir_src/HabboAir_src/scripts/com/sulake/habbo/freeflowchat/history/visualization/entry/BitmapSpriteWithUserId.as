package com.sulake.habbo.freeflowchat.history.visualization.entry
{
   import flash.display.Bitmap;
   
   public class BitmapSpriteWithUserId extends Bitmap
   {
      private var _userIndex:int;
      
      private var _webId:int;
      
      private var _roomId:int;
      
      private var _canIgnore:Boolean;
      
      private var _userName:String;
      
      public function BitmapSpriteWithUserId()
      {
         super();
      }
      
      public function get canIgnore() : Boolean
      {
         return _canIgnore;
      }
      
      public function set canIgnore(param1:Boolean) : void
      {
         _canIgnore = param1;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function set userName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function get userIndex() : int
      {
         return _userIndex;
      }
      
      public function set userIndex(param1:int) : void
      {
         _userIndex = param1;
      }
      
      public function get webId() : int
      {
         return _webId;
      }
      
      public function set webId(param1:int) : void
      {
         _webId = param1;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function set roomId(param1:int) : void
      {
         _roomId = param1;
      }
   }
}


package com.sulake.habbo.communication.messages.incoming.sound
{
   [SecureSWF(rename="true")]
   public class PlayListEntry
   {
      protected var _id:int;
      
      protected var _length:int;
      
      protected var _songName:String;
      
      protected var _creator:String;
      
      private var _startPlayHeadPos:Number = 0;
      
      public function PlayListEntry(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         _id = param1;
         _length = param2;
         _songName = param3;
         _creator = param4;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get length() : int
      {
         return _length;
      }
      
      public function get name() : String
      {
         return _songName;
      }
      
      public function get creator() : String
      {
         return _creator;
      }
      
      public function get startPlayHeadPos() : Number
      {
         return _startPlayHeadPos;
      }
      
      public function set startPlayHeadPos(param1:Number) : void
      {
         _startPlayHeadPos = param1;
      }
   }
}


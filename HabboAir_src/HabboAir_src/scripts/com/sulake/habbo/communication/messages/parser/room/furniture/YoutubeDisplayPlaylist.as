package com.sulake.habbo.communication.messages.parser.room.furniture
{
   [SecureSWF(rename="true")]
   public class YoutubeDisplayPlaylist
   {
      private var _playlistId:String;
      
      private var _title:String;
      
      private var _description:String;
      
      public function YoutubeDisplayPlaylist(param1:String, param2:String, param3:String)
      {
         super();
         _playlistId = param1;
         _title = param2;
         _description = param3;
      }
      
      public function get playlistId() : String
      {
         return _playlistId;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get description() : String
      {
         return _description;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class YoutubeDisplayPlaylistsMessageParser implements IMessageParser
   {
      private var _furniId:int;
      
      private var _playlists:Vector.<YoutubeDisplayPlaylist>;
      
      private var _selectedPlaylistId:String;
      
      public function YoutubeDisplayPlaylistsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _playlists = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc6_:String = null;
         var _loc5_:String = null;
         _furniId = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         _playlists = new Vector.<YoutubeDisplayPlaylist>(0);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.readString();
            _loc6_ = param1.readString();
            _loc5_ = param1.readString();
            _playlists.push(new YoutubeDisplayPlaylist(_loc2_,_loc6_,_loc5_));
            _loc4_++;
         }
         _selectedPlaylistId = param1.readString();
         return true;
      }
      
      public function get furniId() : int
      {
         return _furniId;
      }
      
      public function get playlists() : Vector.<YoutubeDisplayPlaylist>
      {
         return _playlists;
      }
      
      public function get selectedPlaylistId() : String
      {
         return _selectedPlaylistId;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class YoutubeDisplayVideoMessageParser implements IMessageParser
   {
      private var _furniId:int;
      
      private var _videoId:String;
      
      private var _startAtSeconds:int;
      
      private var _endAtSeconds:int;
      
      private var _state:int;
      
      public function YoutubeDisplayVideoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _furniId = param1.readInteger();
         _videoId = param1.readString();
         _startAtSeconds = param1.readInteger();
         _endAtSeconds = param1.readInteger();
         _state = param1.readInteger();
         return true;
      }
      
      public function get furniId() : int
      {
         return _furniId;
      }
      
      public function get videoId() : String
      {
         return _videoId;
      }
      
      public function get startAtSeconds() : int
      {
         return _startAtSeconds;
      }
      
      public function get endAtSeconds() : int
      {
         return _endAtSeconds;
      }
      
      public function get state() : int
      {
         return _state;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class OfficialSongIdMessageParser implements IMessageParser
   {
      private var _songId:int;
      
      private var _officialSongId:String;
      
      public function OfficialSongIdMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _songId = 0;
         _officialSongId = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _officialSongId = param1.readString();
         _songId = param1.readInteger();
         return true;
      }
      
      public function get songId() : int
      {
         return _songId;
      }
      
      public function get officialSongId() : String
      {
         return _officialSongId;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.sound.SongInfoEntry;
   
   [SecureSWF(rename="true")]
   public class TraxSongInfoMessageParser implements IMessageParser
   {
      private var _songs:Array;
      
      public function TraxSongInfoMessageParser()
      {
         super();
      }
      
      public function get songs() : Array
      {
         return _songs;
      }
      
      public function flush() : Boolean
      {
         _songs = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc9_:int = 0;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc7_:int = 0;
         var _loc3_:String = null;
         var _loc8_:int = 0;
         var _loc10_:SongInfoEntry = null;
         var _loc5_:int = param1.readInteger();
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc9_ = param1.readInteger();
            _loc4_ = param1.readString();
            _loc6_ = param1.readString();
            _loc2_ = param1.readString();
            _loc7_ = param1.readInteger();
            _loc3_ = param1.readString();
            _loc10_ = new SongInfoEntry(_loc9_,_loc7_,_loc6_,_loc3_,_loc2_);
            _songs.push(_loc10_);
            _loc8_++;
         }
         return true;
      }
   }
}


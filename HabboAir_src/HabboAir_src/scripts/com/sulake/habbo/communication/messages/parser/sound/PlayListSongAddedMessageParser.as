package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
   
   [SecureSWF(rename="true")]
   public class PlayListSongAddedMessageParser implements IMessageParser
   {
      private var _entry:PlayListEntry;
      
      public function PlayListSongAddedMessageParser()
      {
         super();
      }
      
      public function get entry() : PlayListEntry
      {
         return _entry;
      }
      
      public function flush() : Boolean
      {
         _entry = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc5_:int = param1.readInteger();
         var _loc4_:int = param1.readInteger();
         var _loc2_:String = param1.readString();
         var _loc3_:String = param1.readString();
         _entry = new PlayListEntry(_loc5_,_loc4_,_loc2_,_loc3_);
         return true;
      }
   }
}


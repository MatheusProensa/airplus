package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class JukeboxSongDisksMessageParser implements IMessageParser
   {
      private var _songDisks:Map;
      
      private var _maxLength:int;
      
      public function JukeboxSongDisksMessageParser()
      {
         super();
         _songDisks = new Map();
      }
      
      public function get songDisks() : Map
      {
         return _songDisks;
      }
      
      public function get maxLength() : int
      {
         return _maxLength;
      }
      
      public function flush() : Boolean
      {
         _songDisks.reset();
         _maxLength = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _maxLength = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc4_:int = -1;
         var _loc5_:int = -1;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readInteger();
            _songDisks.add(_loc4_,_loc5_);
            _loc3_++;
         }
         return true;
      }
   }
}


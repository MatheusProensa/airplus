package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
   
   [SecureSWF(rename="true")]
   public class PlayListMessageParser implements IMessageParser
   {
      private var _synchronizationCount:int;
      
      private var _playList:Array;
      
      public function PlayListMessageParser()
      {
         super();
      }
      
      public function get synchronizationCount() : int
      {
         return _synchronizationCount;
      }
      
      public function get playList() : Array
      {
         return _playList;
      }
      
      public function flush() : Boolean
      {
         _synchronizationCount = -1;
         _playList = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc2_:String = null;
         _synchronizationCount = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc7_ = param1.readInteger();
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readString();
            _loc2_ = param1.readString();
            _playList.push(new PlayListEntry(_loc7_,_loc4_,_loc5_,_loc2_));
            _loc6_++;
         }
         return true;
      }
   }
}


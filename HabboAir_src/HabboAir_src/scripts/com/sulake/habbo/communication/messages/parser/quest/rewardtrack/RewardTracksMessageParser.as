package com.sulake.habbo.communication.messages.parser.quest.rewardtrack
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RewardTracksMessageParser implements IMessageParser
   {
      private var _disabled:Boolean;
      
      private var _tracks:Vector.<RewardTrackData>;
      
      private var _reload:Boolean;
      
      public function RewardTracksMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _disabled = false;
         _tracks = null;
         _reload = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _disabled = param1.readBoolean();
         _tracks = new Vector.<RewardTrackData>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _tracks.push(new RewardTrackData(param1));
            _loc3_++;
         }
         _reload = param1.readBoolean();
         return true;
      }
      
      public function get disabled() : Boolean
      {
         return _disabled;
      }
      
      public function get tracks() : Vector.<RewardTrackData>
      {
         return _tracks;
      }
      
      public function get reload() : Boolean
      {
         return _reload;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TalentTrackLevelMessageParser implements IMessageParser
   {
      private var _talentTrackName:String;
      
      private var _level:int;
      
      private var _maxLevel:int;
      
      public function TalentTrackLevelMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _talentTrackName = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _talentTrackName = param1.readString();
         _level = param1.readInteger();
         _maxLevel = param1.readInteger();
         return true;
      }
      
      public function get talentTrackName() : String
      {
         return _talentTrackName;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get maxLevel() : int
      {
         return _maxLevel;
      }
   }
}


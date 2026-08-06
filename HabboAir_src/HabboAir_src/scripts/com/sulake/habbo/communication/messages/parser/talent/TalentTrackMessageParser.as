package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TalentTrackMessageParser implements IMessageParser
   {
      private var _talentTrack:TalentTrack;
      
      public function TalentTrackMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _talentTrack = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _talentTrack = new TalentTrack();
         _talentTrack.parse(param1);
         return true;
      }
      
      public function getTalentTrack() : TalentTrack
      {
         return _talentTrack;
      }
   }
}


package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class TalentTrackRewardPerk
   {
      private var _perkId:String;
      
      public function TalentTrackRewardPerk(param1:IMessageDataWrapper)
      {
         super();
         _perkId = param1.readString();
      }
      
      public function get perkId() : String
      {
         return _perkId;
      }
   }
}


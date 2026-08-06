package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.utils.UnknownHabboUtils1;
   
   [SecureSWF(rename="true")]
   public class TalentTrack
   {
      public static const STATE_LOCKED:int = 0;
      
      public static const UnknownConstFromTalentTrack_Int_1:int = 1;
      
      public static const UnknownConstFromTalentTrack_Int_2:int = 2;
      
      private var _name:String;
      
      private var UnknownVarFromTalentTrack_Int_1:int;
      
      private var _levels:Vector.<TalentTrackLevel>;
      
      public function TalentTrack()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         var _loc4_:int = 0;
         var _loc3_:TalentTrackLevel = null;
         _name = param1.readString();
         _levels = new Vector.<TalentTrackLevel>();
         var _loc2_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new TalentTrackLevel();
            _loc3_.parse(param1);
            if(_loc3_.state == 1)
            {
               UnknownVarFromTalentTrack_Int_1 = _loc4_;
            }
            _levels.push(_loc3_);
            _loc4_++;
         }
      }
      
      public function findTaskByAchievementId(param1:int) : TalentTrackTask
      {
         var _loc3_:TalentTrackTask = null;
         var _loc4_:* = null;
         for each(var _loc2_ in _levels)
         {
            if(_loc2_.state != 0)
            {
               _loc3_ = _loc2_.findTaskByAchievementId(param1);
               if(_loc3_ != null)
               {
                  _loc4_ = _loc3_;
               }
            }
         }
         return _loc4_;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get levels() : Vector.<TalentTrackLevel>
      {
         return _levels;
      }
      
      public function get progressPerLevel() : Number
      {
         if(_levels.length > 0)
         {
            return 1 / _levels.length;
         }
         return 0;
      }
      
      public function get totalProgress() : Number
      {
         var _loc1_:Number = NaN;
         if(_levels.length > 0)
         {
            _loc1_ = _levels[UnknownVarFromTalentTrack_Int_1].levelProgress;
            return UnknownHabboUtils1.clamp(UnknownVarFromTalentTrack_Int_1 * progressPerLevel + _loc1_ * progressPerLevel);
         }
         return 0;
      }
      
      public function get progressForCurrentLevel() : Number
      {
         if(_levels.length > 0)
         {
            return UnknownVarFromTalentTrack_Int_1 * progressPerLevel;
         }
         return 0;
      }
      
      public function removeFirstLevel() : void
      {
         _levels.shift();
         UnknownVarFromTalentTrack_Int_1 = Math.max(0,UnknownVarFromTalentTrack_Int_1 - 1);
      }
   }
}


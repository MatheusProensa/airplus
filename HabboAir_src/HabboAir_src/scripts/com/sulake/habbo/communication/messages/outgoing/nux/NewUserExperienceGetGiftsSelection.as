package com.sulake.habbo.communication.messages.outgoing.nux
{
   [SecureSWF(rename="true")]
   public class NewUserExperienceGetGiftsSelection
   {
      private var _dayIndex:int;
      
      private var _stepIndex:int;
      
      private var _giftIndex:int;
      
      public function NewUserExperienceGetGiftsSelection(param1:int, param2:int, param3:int)
      {
         super();
         _dayIndex = param1;
         _stepIndex = param2;
         _giftIndex = param3;
      }
      
      public function get dayIndex() : int
      {
         return _dayIndex;
      }
      
      public function get stepIndex() : int
      {
         return _stepIndex;
      }
      
      public function get giftIndex() : int
      {
         return _giftIndex;
      }
   }
}


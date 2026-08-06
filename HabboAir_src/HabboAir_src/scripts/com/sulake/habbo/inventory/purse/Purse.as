package com.sulake.habbo.inventory.purse
{
   import flash.utils.getTimer;
   
   public class Purse
   {
      private var _isExpiring:Boolean = false;
      
      private var _isCitizenshipVipExpiring:Boolean = false;
      
      private var _clubDays:int = 0;
      
      private var _clubPeriods:int = 0;
      
      private var _clubPastPeriods:int = 0;
      
      private var _clubHasEverBeenMember:Boolean = false;
      
      private var _isVIP:Boolean = false;
      
      private var UnknownVarFromPurse_Int_1:int = 0;
      
      private var _minutesSinceLastModified:int = -1;
      
      private var UnknownVarFromPurse_Int_2:int;
      
      public function Purse()
      {
         super();
      }
      
      public function get clubDays() : int
      {
         return _clubDays;
      }
      
      public function set clubDays(param1:int) : void
      {
         UnknownVarFromPurse_Int_2 = getTimer();
         _clubDays = Math.max(0,param1);
      }
      
      public function get clubPeriods() : int
      {
         return _clubPeriods;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         UnknownVarFromPurse_Int_2 = getTimer();
         _clubPeriods = Math.max(0,param1);
      }
      
      public function get clubPastPeriods() : int
      {
         return _clubPastPeriods;
      }
      
      public function set clubPastPeriods(param1:int) : void
      {
         UnknownVarFromPurse_Int_2 = getTimer();
         _clubPastPeriods = Math.max(0,param1);
      }
      
      public function get clubHasEverBeenMember() : Boolean
      {
         return _clubHasEverBeenMember;
      }
      
      public function set clubHasEverBeenMember(param1:Boolean) : void
      {
         UnknownVarFromPurse_Int_2 = getTimer();
         _clubHasEverBeenMember = param1;
      }
      
      public function get isVIP() : Boolean
      {
         return _isVIP;
      }
      
      public function set isVIP(param1:Boolean) : void
      {
         UnknownVarFromPurse_Int_2 = getTimer();
         _isVIP = param1;
      }
      
      public function get minutesUntilExpiration() : int
      {
         var _loc1_:int = (getTimer() - UnknownVarFromPurse_Int_2) / 60000;
         var _loc2_:int = UnknownVarFromPurse_Int_1 - _loc1_;
         return _loc2_ > 0 ? _loc2_ : 0;
      }
      
      public function set minutesUntilExpiration(param1:int) : void
      {
         UnknownVarFromPurse_Int_2 = getTimer();
         UnknownVarFromPurse_Int_1 = param1;
      }
      
      public function get clubIsExpiring() : Boolean
      {
         return _isExpiring;
      }
      
      public function set clubIsExpiring(param1:Boolean) : void
      {
         _isExpiring = param1;
      }
      
      public function get citizenshipVipIsExpiring() : Boolean
      {
         return _isCitizenshipVipExpiring;
      }
      
      public function set citizenshipVipIsExpiring(param1:Boolean) : void
      {
         _isCitizenshipVipExpiring = param1;
      }
      
      public function get minutesSinceLastModified() : int
      {
         return _minutesSinceLastModified;
      }
      
      public function set minutesSinceLastModified(param1:int) : void
      {
         UnknownVarFromPurse_Int_2 = getTimer();
         _minutesSinceLastModified = param1;
      }
   }
}


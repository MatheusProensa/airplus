package com.sulake.habbo.catalog.purse
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Purse implements IPurse
   {
      private var _credits:int = 0;
      
      private var _activityPoints:Dictionary = new Dictionary();
      
      private var _clubDays:int = 0;
      
      private var _clubPeriods:int = 0;
      
      private var _isVIP:Boolean = false;
      
      private var _pastClubDays:int = 0;
      
      private var _pastVipDays:int = 0;
      
      private var _isExpiring:Boolean = false;
      
      private var UnknownVarFromPurse_Int_1:int = 0;
      
      private var _minutesSinceLastModified:int;
      
      private var _lastUpdated:int;
      
      private var _emeraldBalance:int = 0;
      
      private var _silverBalance:int = 0;
      
      public function Purse()
      {
         super();
      }
      
      public function get credits() : int
      {
         return _credits;
      }
      
      public function set credits(param1:int) : void
      {
         _lastUpdated = getTimer();
         _credits = param1;
      }
      
      public function get clubDays() : int
      {
         return _clubDays;
      }
      
      public function set clubDays(param1:int) : void
      {
         _lastUpdated = getTimer();
         _clubDays = param1;
      }
      
      public function get clubPeriods() : int
      {
         return _clubPeriods;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         _lastUpdated = getTimer();
         _clubPeriods = param1;
      }
      
      public function get hasClubLeft() : Boolean
      {
         return _clubDays > 0 || _clubPeriods > 0;
      }
      
      public function get isVIP() : Boolean
      {
         return _isVIP;
      }
      
      public function get isExpiring() : Boolean
      {
         return _isExpiring;
      }
      
      public function set isExpiring(param1:Boolean) : void
      {
         _isExpiring = param1;
      }
      
      public function set isVIP(param1:Boolean) : void
      {
         _isVIP = param1;
      }
      
      public function get pastClubDays() : int
      {
         return _pastClubDays;
      }
      
      public function set pastClubDays(param1:int) : void
      {
         _lastUpdated = getTimer();
         _pastClubDays = param1;
      }
      
      public function get pastVipDays() : int
      {
         return _pastVipDays;
      }
      
      public function set pastVipDays(param1:int) : void
      {
         _lastUpdated = getTimer();
         _pastVipDays = param1;
      }
      
      public function get activityPoints() : Dictionary
      {
         return _activityPoints;
      }
      
      public function set activityPoints(param1:Dictionary) : void
      {
         _lastUpdated = getTimer();
         _activityPoints = param1;
      }
      
      public function getActivityPointsForType(param1:int) : int
      {
         return _activityPoints[param1];
      }
      
      public function set minutesUntilExpiration(param1:int) : void
      {
         _lastUpdated = getTimer();
         UnknownVarFromPurse_Int_1 = param1;
      }
      
      public function get minutesUntilExpiration() : int
      {
         var _loc1_:int = (getTimer() - _lastUpdated) / 60000;
         var _loc2_:int = UnknownVarFromPurse_Int_1 - _loc1_;
         return _loc2_ > 0 ? _loc2_ : 0;
      }
      
      public function set minutesSinceLastModified(param1:int) : void
      {
         _lastUpdated = getTimer();
         _minutesSinceLastModified = param1;
      }
      
      public function get minutesSinceLastModified() : int
      {
         return _minutesSinceLastModified;
      }
      
      public function get lastUpdated() : int
      {
         return _lastUpdated;
      }
      
      public function get emeraldBalance() : int
      {
         return _emeraldBalance;
      }
      
      public function set emeraldBalance(param1:int) : void
      {
         _emeraldBalance = param1;
      }
      
      public function get silverBalance() : int
      {
         return _silverBalance;
      }
      
      public function set silverBalance(param1:int) : void
      {
         _silverBalance = param1;
      }
   }
}

